Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269088AbUJKQo6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269088AbUJKQo6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 12:44:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269097AbUJKQni
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 12:43:38 -0400
Received: from ylpvm15-ext.prodigy.net ([207.115.57.46]:13242 "EHLO
	ylpvm15.prodigy.net") by vger.kernel.org with ESMTP id S269150AbUJKQg1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 12:36:27 -0400
From: David Brownell <david-b@pacbell.net>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: Totally broken PCI PM calls
Date: Mon, 11 Oct 2004 09:36:37 -0700
User-Agent: KMail/1.6.2
Cc: Linus Torvalds <torvalds@osdl.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Pavel Machek <pavel@ucw.cz>
References: <1097455528.25489.9.camel@gaston> <Pine.LNX.4.58.0410101937100.3897@ppc970.osdl.org> <16746.299.189583.506818@cargo.ozlabs.ibm.com>
In-Reply-To: <16746.299.189583.506818@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200410110936.37268.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 10 October 2004 8:42 pm, Paul Mackerras wrote:
> 
> The USB drivers aren't a good example, they are currently quite broken
> as far as suspend/resume is concerned.  They used to work just fine
> but got broken some time in the last few months.

It would have been interesting to have seen some problem report
on linux-usb-devel.  Which USB drivers, by the way?  There have
to be at least a hundred of them.

I can say that USB suspend/resume works much better now on
some x86 hardware, especially with patches in Greg's bk-usb tree;
at the level of "those never worked on 2.6 before!"  There are still
several PMcore problems getting in the way though, and I'd not
be surprised if your "used to work" translated as "somehow a
bunch of bugs canceled each other out on PPC" ...


> Maybe the real problem is that we are trying to use the device suspend
> functions for suspend-to-disk, when we don't really want to change the
> device's power state at all.

I've made that point too.  STD is logically a few steps:  quiesce system,
write image to swap, change power state.  The ACPI spec talks about
that as keeping the system in a G1/S4 powered state, but "swusp"
doesn't use that ... it does a full power-off.   And of course, full power-off
means that the BIOS probably mucks with the USB hardware, so it's
not a real resume any more.

- Dave
