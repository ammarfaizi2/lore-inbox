Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292980AbSBVUCx>; Fri, 22 Feb 2002 15:02:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292982AbSBVUCe>; Fri, 22 Feb 2002 15:02:34 -0500
Received: from air-2.osdl.org ([65.201.151.6]:53002 "EHLO osdlab.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S292980AbSBVUCW>;
	Fri, 22 Feb 2002 15:02:22 -0500
Date: Fri, 22 Feb 2002 11:56:31 -0800 (PST)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Andreas Ferber <aferber@techfak.uni-bielefeld.de>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: How to check the kernel compile options ?
In-Reply-To: <20020216015834.D28176@devcon.net>
Message-ID: <Pine.LNX.4.33L2.0202221150420.2938-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 16 Feb 2002, Andreas Ferber wrote:

| On Fri, Feb 15, 2002 at 03:51:43PM -0700, Andreas Dilger wrote:
| >
| > Note also that it is enough to store the config options without the
| > leading CONFIG_ part, and then use 'grep "[A-Z0-9]*=[ym]$"' to get
| > the actual config strings.  You can add a final 'sed "s/^/CONFIG_/"'
| > step to return it to the original format.  So:

except that not all options are "=[ynm]$"; some are string values.

| Note that you also need some way to keep the config symbols which are
| set to "n" and commented out in the .config. Otherwise you will have
| to answer a lot of questions on "make oldconfig" ("yes n | make
| oldconfig" isn't an option, as this doesn't tell you which config
| symbols have been added).

Oh, thanks for pointing that out.

Will
  yes n | make oldconfig
build a kernel with the current y/m options still intact,
but any new or missing options set to 'n'?
That doesn't sound so bad, but not optimal either.

| I have actually done my own patch to include the .config into the
| kernel image some time ago. It provides the .config via
| /proc/config{,.gz,.bz2} (the compression method to use is
| configurable). Apart from compression, it doesn't try to do anything
| special to reduce size, because I don't have any machines where it
| actually matters if the kernel needs some kB more or less memory.
|
| I didn't bother to submit the patch because of the discussions on this
| topic in the past, instead I keep patching kernel sources myself
| before compiling a kernel. Anyone interested can get the patch from
| <http://www.myipv6.de/patches/kconfig/>. Patches for new kernel
| versions are uploaded occasionally, everytime I don't forget to rediff
| it before applying other patches to the source tree ;-) (possibly
| conflicting parts for other kernel versions are Makefiles, config.in
| or Configure.help, which can all be hand-applied easily, even if you
| are not a kernel hacker ;-). It works for both 2.2 and 2.4 (probably
| 2.5 also, didn't test yet).
|
| Any comments on the patch are welcome ;-)

I looked.  It does nicely if that's where you want to store and find
the .config.  I'd rather have it associated with a kernel image file
and accessible even if the kernel isn't running.

Thanks,
-- 
~Randy

