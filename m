Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286411AbSABAGl>; Tue, 1 Jan 2002 19:06:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286428AbSABAGW>; Tue, 1 Jan 2002 19:06:22 -0500
Received: from hog.ctrl-c.liu.se ([130.236.252.129]:49675 "HELO
	hog.ctrl-c.liu.se") by vger.kernel.org with SMTP id <S286424AbSABAGP>;
	Tue, 1 Jan 2002 19:06:15 -0500
From: Christer Weinigel <wingel@hog.ctrl-c.liu.se>
To: hpa@zytor.com
Cc: robert@schwebel.de, linux-kernel@vger.kernel.org, jason@mugwump.taiga.com,
        anders@alarsen.net, rkaiser@sysgo.de, tytso@mit.edu
In-Reply-To: <3C322EEE.5040402@zytor.com> (hpa@zytor.com)
Subject: Re: [PATCH][RFC] AMD Elan patch
Reply-To: wingel@t1.ctrl-c.liu.se
In-Reply-To: <Pine.LNX.4.33.0112311900380.3056-100000@callisto.local> <3C322EEE.5040402@zytor.com>
Message-Id: <20020102000609.6B6C136F9F@hog.ctrl-c.liu.se>
Date: Wed,  2 Jan 2002 01:06:09 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> H. Peter Anvin wrote:

> Do you have documentation which verifies that A20 is enabled by the time 
> the IN instruction returns?  

>From the manual for the SC410 (found on AMD's homepage):

    Alternate Gate A20 Control Register (Port 00EEh) A special 8-bit
    read/write control register provides a fast and reliable way to
    control the CPU A20 signal. A dummy read of this register returns
    a value of FFh and forces the CPU A20 to propagate to the core
    logic, while a dummy write to this register will cause the CPU A20
    signal to be forced Low as long as no other A20 gate control
    sources are forcing the CPU A20 signal to propagate.

I think it's safe to assume that it takes effect immediately.

> Furthermore, I would still like to argue that this does not belong into 
> "processor type and features", because all of these are *chipset* 
> issues; in fact, in this particular case you're more than anything 
> working around a BIOS bug (not having INT 15h AX=2401h do the right thing).

I agree that it might be better to have a chipset option similar to
CONFIG_VISWS:

bool 'SGI Visual Workstation support' CONFIG_VISWS
...
bool 'AMD Elan SC4x0 support' CONFIG_ELAN_SC4x0
if [ "$CONFIG_ELAN_SC4x0" != "n" ]; then
    bool '  Use "inb 0xee" to control A20' CONFIG_ELAN_SC4x0_A20
fi

> I'm also very uncomfortable with putting this where you do; I think it 
> should be put before a20_kbc instead.  If the BIOS is implemented 
> correctly, it should be used.

I disagree, the Elan SC410 is an embedded CPU, it's used in systems
that might not even have a BIOS (such as the Ericsson eBox that I've
been working with).  Since there has to be a config option for this
CPU (the clock frequency selection) and a SC410-enabled kernel won't
work properly on a normal PC anyway, why not modify the boot sequence
so that it _always_ works on this CPU.

  /Christer

-- 
"Just how much can I get away with and still go to heaven?"
