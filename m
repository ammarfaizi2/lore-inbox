Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265177AbSLPE4l>; Sun, 15 Dec 2002 23:56:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265222AbSLPE4l>; Sun, 15 Dec 2002 23:56:41 -0500
Received: from mrmorr.lnk.telstra.net ([139.130.12.153]:52485 "EHLO
	cheesypoof.guarana.org") by vger.kernel.org with ESMTP
	id <S265177AbSLPE4k>; Sun, 15 Dec 2002 23:56:40 -0500
Date: Mon, 16 Dec 2002 16:04:30 +1100
From: Kevin Easton <kevin@sylandro.com>
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
Cc: Keith Owens <kaos@ocs.com.au>, Kevin Easton <kevin@sylandro.com>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.4.20 st + aic7xxx (Adaptec 19160B) + VIA KT333 repeatable freeze
Message-ID: <20021216050430.GB30613@guarana.org>
References: <1047.1039952560@ocs3.intra.ocs.com.au> <17460000.1039982505@aslan.btc.adaptec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17460000.1039982505@aslan.btc.adaptec.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 15, 2002 at 01:01:45PM -0700, Justin T. Gibbs wrote:
> > On Fri, 13 Dec 2002 11:51:27 +1100, 
> > Kevin Easton <kevin@sylandro.com> wrote:
> >> I'm not sure exactly where this problem fits in, but I'm getting a 
> >> completely repeatable freeze (100% lockup, no response to keyboard)
> >> triggered by writing to /dev/st0 (dd if=/dev/urandom of=/dev/st0 bs=512
> >> count=163840 will reproduce it).
> >> So... does anyone have any ideas how I should start trying to track this
> >> down?
> 
> You might also look into your BIOS to ensure that the option "PCI Byte
> Merging" is disabled.  This option allows the chipset to perform illegal
> byte merging on the PCI bus that will upset the Adaptec.  Since the byte
> merging will only occur in certain scenarios (heavily dependent on what
> is going on with the SCSI bus), you may only see the lockup when accessing
> a particular device or running a certain program.
> 
> The latest versions of the aic7xxx and aic79xx drivers will automatically
> detect this broken VIA behavior and will fall back to using PIO for register
> access.  Although I haven't generated patches against 2.4.20, you can pull
> down a src tarball for 2.4.X that should just drop in:

Well, like I thought, this BIOS (it's an ASUS A7V333 mobo) doesn't have
an option for PCI Byte Merging - it has very few PCI options at all.
I'm going to update the BIOS to see if that gains me anything useful.

I took a clean 2.4.20 source tree and overlaid it with the contents of
aic79xx-linux-2.4.20-20021213.tar.gz, and it doesn't seem to have fixed
the problem completely, though it is *much* harder to trigger it now - I
thought it was working, but the same problem reappeared after copying
just over 4.5Gb to a tape.

As I mentioned in my reply to Keith, the NMI watchdog isn't even
triggering after this crash, which seems a little odd to me.

	- Kevin.

