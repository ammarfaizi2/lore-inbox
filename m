Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263563AbTDNQ5X (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 12:57:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263564AbTDNQ5X (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 12:57:23 -0400
Received: from s161-184-77-200.ab.hsia.telus.net ([161.184.77.200]:20443 "EHLO
	cafe.hardrock.org") by vger.kernel.org with ESMTP id S263563AbTDNQ5V convert rfc822-to-8bit (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Apr 2003 12:57:21 -0400
Date: Mon, 14 Apr 2003 11:09:02 -0600 (MDT)
From: James Bourne <jbourne@hardrock.org>
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
cc: Martin Schlemmer <azarah@gentoo.org>,
       Ken Brownfield <brownfld@irridia.com>,
       Marc-Christian Petersen <m.c.p@wolk-project.de>,
       KML <linux-kernel@vger.kernel.org>
Subject: Re: Oops: ptrace fix buggy
In-Reply-To: <20030414144709.GE10347@wohnheim.fh-wedel.de>
Message-ID: <Pine.LNX.4.44.0304141048390.24506-100000@cafe.hardrock.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Apr 2003, Jörn Engel wrote:

> On Mon, 14 April 2003 16:31:08 +0200, Martin Schlemmer wrote:
> > On Mon, 2003-04-14 at 15:46, Jörn Engel wrote:
> > 
> > > Privately, I have introduced a variable FIXLEVEL for this. The
> > > resulting kernel version is 2.4.20.2 instead of 2.4.20-uv2, which imo
> > > is more suiting for a fixed stable kernel.
> > 
> > This is not a good idea ... especially if its a box that you
> > compile a lot of software on.  Reason is that everything expects
> > it to be MAJ.MIN.MIC  ... If you add now another version, then
> > things start to break.  A good example is mozilla ...
> 
> That doesn't convince me (yet?). Why doesn't 2.4.20-pre5-ac3 break
> mozilla, but 2.4.20.1 does? If mozilla depends on this information, it
> should at least have a robust parser for it.
> 
> Can you give me a little more details on this? Did anyone ever declare
> that userspace can expect kernel versions to fit this regex?
> \d+\.\d+\.\d+(-.+)?

Hi,
If you only change the one line and add the new variable I'm afraid it won't
work due to other things changing as well...  At least the files 
Makefile
Rules.make
arch/ppc/boot/Makefile
arch/arm/boot/Makefile
scripts/patch-kernel
scripts/mkspec
scripts/Menuconfig

will need to be looked at as these are ones which contain references to
SUBVERSION...  References to EXTRAVERSION also reside in these files.  It
would just be better to do the "right thing" IMHO.

I will take a look at this and produce a patch for the same.

Regards
James Bourne

> Jörn

-- 
James Bourne                  | Email:            jbourne@hardrock.org          
Unix Systems Administrator    | WWW:           http://www.hardrock.org
Custom Unix Programming       | Linux:  The choice of a GNU generation
----------------------------------------------------------------------
 "All you need's an occasional kick in the philosophy." Frank Herbert  

