Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286447AbSABAtJ>; Tue, 1 Jan 2002 19:49:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286453AbSABAs7>; Tue, 1 Jan 2002 19:48:59 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:58373 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S286447AbSABAso>; Tue, 1 Jan 2002 19:48:44 -0500
Message-ID: <3C3258DF.5000908@zytor.com>
Date: Tue, 01 Jan 2002 16:48:31 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: wingel@t1.ctrl-c.liu.se
CC: robert@schwebel.de, linux-kernel@vger.kernel.org, jason@mugwump.taiga.com,
        anders@alarsen.net, rkaiser@sysgo.de, tytso@mit.edu
Subject: Re: [PATCH][RFC] AMD Elan patch
In-Reply-To: <Pine.LNX.4.33.0112311900380.3056-100000@callisto.local> <3C322EEE.5040402@zytor.com> <20020102000609.6B6C136F9F@hog.ctrl-c.liu.se>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christer Weinigel wrote:

> 
>     Alternate Gate A20 Control Register (Port 00EEh) A special 8-bit
>     read/write control register provides a fast and reliable way to
>     control the CPU A20 signal. A dummy read of this register returns
>     a value of FFh and forces the CPU A20 to propagate to the core
>     logic, while a dummy write to this register will cause the CPU A20
>     signal to be forced Low as long as no other A20 gate control
>     sources are forcing the CPU A20 signal to propagate.
> 
> I think it's safe to assume that it takes effect immediately.
> 


What leads you to that conclusion?  There is nothing in the above 
paragraph that would lead you to believe that.

> 
>>I'm also very uncomfortable with putting this where you do; I think it 
>>should be put before a20_kbc instead.  If the BIOS is implemented 
>>correctly, it should be used.
>>
> 
> I disagree, the Elan SC410 is an embedded CPU, it's used in systems
> that might not even have a BIOS (such as the Ericsson eBox that I've
> been working with).  Since there has to be a config option for this
> CPU (the clock frequency selection) and a SC410-enabled kernel won't
> work properly on a normal PC anyway, why not modify the boot sequence
> so that it _always_ works on this CPU.
> 


If used sans BIOS you need *massive* modifications to the setup anyway, 
and you're talking a completely custom kernel.  The reason to use the 
BIOS first is to give the platform vendor a hook to deal with 
platform-specific issues, and God knows there are plenty of those when 
it comes to A20.  (The fact that the BIOSes on the boards we have 
discussed haven't provided such a hook is a bug in itself.)

	-hpa


