Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292302AbSBPA64>; Fri, 15 Feb 2002 19:58:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292303AbSBPA6r>; Fri, 15 Feb 2002 19:58:47 -0500
Received: from taifun.devconsult.de ([212.15.193.29]:15621 "EHLO
	taifun.devconsult.de") by vger.kernel.org with ESMTP
	id <S292302AbSBPA6h>; Fri, 15 Feb 2002 19:58:37 -0500
Date: Sat, 16 Feb 2002 01:58:34 +0100
From: Andreas Ferber <aferber@techfak.uni-bielefeld.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: How to check the kernel compile options ?
Message-ID: <20020216015834.D28176@devcon.net>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.3.96.1020213180951.12448L-100000@gatekeeper.tmr.com> <Pine.LNX.4.33L2.0202140836210.1530-300000@dragon.pdx.osdl.net> <20020215155143.I14054@lynx.adilger.int>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020215155143.I14054@lynx.adilger.int>; from adilger@turbolabs.com on Fri, Feb 15, 2002 at 03:51:43PM -0700
Organization: dev/consulting GmbH
X-NCC-RegID: de.devcon
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 15, 2002 at 03:51:43PM -0700, Andreas Dilger wrote:
> 
> Note also that it is enough to store the config options without the
> leading CONFIG_ part, and then use 'grep "[A-Z0-9]*=[ym]$"' to get
> the actual config strings.  You can add a final 'sed "s/^/CONFIG_/"'
> step to return it to the original format.  So:

Note that you also need some way to keep the config symbols which are
set to "n" and commented out in the .config. Otherwise you will have
to answer a lot of questions on "make oldconfig" ("yes n | make
oldconfig" isn't an option, as this doesn't tell you which config
symbols have been added).



I have actually done my own patch to include the .config into the
kernel image some time ago. It provides the .config via
/proc/config{,.gz,.bz2} (the compression method to use is
configurable). Apart from compression, it doesn't try to do anything
special to reduce size, because I don't have any machines where it
actually matters if the kernel needs some kB more or less memory.

I didn't bother to submit the patch because of the discussions on this
topic in the past, instead I keep patching kernel sources myself
before compiling a kernel. Anyone interested can get the patch from
<http://www.myipv6.de/patches/kconfig/>. Patches for new kernel
versions are uploaded occasionally, everytime I don't forget to rediff
it before applying other patches to the source tree ;-) (possibly
conflicting parts for other kernel versions are Makefiles, config.in
or Configure.help, which can all be hand-applied easily, even if you
are not a kernel hacker ;-). It works for both 2.2 and 2.4 (probably
2.5 also, didn't test yet).

Any comments on the patch are welcome ;-)

Andreas
-- 
       Andreas Ferber - dev/consulting GmbH - Bielefeld, FRG
     ---------------------------------------------------------
         +49 521 1365800 - af@devcon.net - www.devcon.net
