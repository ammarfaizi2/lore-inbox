Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264320AbUAIUVX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 15:21:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264389AbUAIUVW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 15:21:22 -0500
Received: from gaia.cela.pl ([213.134.162.11]:3858 "EHLO gaia.cela.pl")
	by vger.kernel.org with ESMTP id S264320AbUAIUVN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 15:21:13 -0500
Date: Fri, 9 Jan 2004 21:20:53 +0100 (CET)
From: Maciej Zenczykowski <maze@cela.pl>
To: Jesper Juhl <juhl-lkml@dif.dk>
cc: Valdis.Kletnieks@vt.edu, Andrew Morton <akpm@osdl.org>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][RFC] invalid ELF binaries can execute - better sanity
 checking 
In-Reply-To: <Pine.LNX.4.56.0401090437060.11276@jju_lnx.backbone.dif.dk>
Message-ID: <Pine.LNX.4.44.0401092105070.1739-100000@gaia.cela.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I know of the document, but thank you for pointing it out, it's quite an
> interresting read. Actually, reading that exact document ages ago was what
> initially caused me to start reading the ELF loading code (thinking
> "there's got to be something wrong here").
> I've actually been planning to use some of the crazy stunts he pulls
> with that code as validity checks of the code I want to implement (in
> adition to specially tailored test-cases ofcourse).

I think this points to an 'issue', if we're going to increase the checks
in the ELF-loader (and thus increase the size of the minimal valid ELF
file we can load, thus effectively 'bloating' (lol) some programs) we
should probably allow some sort of direct binary executable files [i.e.
header 'XBIN386\0' followed by Read/Execute binary code to execute by
mapping as RX at any offset and jumping to offset 8] to allow writing
minimal executables.  Minimalizing executables is useful for embedded
systems, portable devices, floppy distributions and ramdisk/initrd
situations.  Sure many of these solve this problem by UPX compressing
busybox/crunchbox one-file-many-executables files, but it would still be
nice to be able to dump all the extra crud in some cases.  Some of these
distributions already contain non-standards conforming ELF files. I have a
933 byte less and a 305 byte strings command on my initrd (taken from some
floppy distribution) which report "ERROR: Corrupted section header size"
via 'file *' and there is probably many many more out there.  Is this 
worth it?  I don't know, in many ways this would be the COM to the ELF 
EXE... the DOS analogy proves little though [note: I have no idea about 
the a.out or COFF or whatever it's called format].

Cheers,
MaZe.


