Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261188AbUBQHPH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 02:15:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261262AbUBQHPH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 02:15:07 -0500
Received: from islay.mach.uni-karlsruhe.de ([129.13.162.92]:1440 "EHLO
	mailout.schmorp.de") by vger.kernel.org with ESMTP id S261188AbUBQHPA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 02:15:00 -0500
Date: Tue, 17 Feb 2004 08:14:48 +0100
From: <pcg@goof.com ( Marc) (A.) (Lehmann )>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jamie Lokier <jamie@shareable.org>, Marc Lehmann <pcg@schmorp.de>,
       viro@parcelfarce.linux.theplanet.co.uk,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: UTF-8 practically vs. theoretically in the VFS API (was: Re: JFS default behavior)
Message-ID: <20040217071448.GA8846@schmorp.de>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Jamie Lokier <jamie@shareable.org>, Marc Lehmann <pcg@schmorp.de>,
	viro@parcelfarce.linux.theplanet.co.uk,
	Linux kernel <linux-kernel@vger.kernel.org>
References: <200402150006.23177.robin.rosenberg.lists@dewire.com> <20040214232935.GK8858@parcelfarce.linux.theplanet.co.uk> <200402150107.26277.robin.rosenberg.lists@dewire.com> <Pine.LNX.4.58.0402141827200.14025@home.osdl.org> <20040216183616.GA16491@schmorp.de> <Pine.LNX.4.58.0402161040310.30742@home.osdl.org> <20040216200321.GB17015@schmorp.de> <Pine.LNX.4.58.0402161205120.30742@home.osdl.org> <20040216222618.GF18853@mail.shareable.org> <Pine.LNX.4.58.0402161431260.30742@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.58.0402161431260.30742@home.osdl.org>
X-Operating-System: Linux version 2.4.24 (root@cerebro) (gcc version 2.95.4 20011002 (Debian prerelease)) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 16, 2004 at 02:40:25PM -0800, Linus Torvalds <torvalds@osdl.org> wrote:
> Try it with a regular C locale. Do a simple
> 
> 	echo > едц

Just for your info, though. You can't even input these characters in a C
locale, since your libc (and/or xlib) is unable to handle them (lots of SO
C functions will barf on this one). C is 7 bit only.

> Which, if you think about is, is 100% EXACTLY equivalent to what a UTF-8
> program should do when it sees broken UTF-8.

The problem is that the very common C language makes it a pain to use
this in i18n programs. multibyte functions or iconv will no accept
these, so programs wanting to do what you are expecting to do need to
re-implement most if not all of the character handling of your typical
libc.

Yes, it's possible....

> The two cases are 100% equivalent. We've gone through this before. There 
> is a bit of pain involved, but it's not something new, or something 
> fundamentally impossible. It's very straightforward indeed.

The "bit" is enourmous, as you can't use your libc for text processing
anymore.

Yes, it works in non-i18n programms, but right now most programs get
i18n support, which means they will all fail to properly handle
non-locale characters.

-- 
      -----==-                                             |
      ----==-- _                                           |
      ---==---(_)__  __ ____  __       Marc Lehmann      +--
      --==---/ / _ \/ // /\ \/ /       pcg@goof.com      |e|
      -=====/_/_//_/\_,_/ /_/\_\       XX11-RIPE         --+
    The choice of a GNU generation                       |
                                                         |
