Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265287AbUBPA0Y (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Feb 2004 19:26:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265289AbUBPA0Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Feb 2004 19:26:24 -0500
Received: from mx1.redhat.com ([66.187.233.31]:43668 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265287AbUBPA0X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Feb 2004 19:26:23 -0500
Date: Sun, 15 Feb 2004 19:26:19 -0500 (EST)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Jari Ruusu <jariruusu@users.sourceforge.net>
cc: Jan Rychter <jan@rychter.com>, <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: Oopsing cryptoapi (or loop device?) on 2.6.*
In-Reply-To: <402F877C.C9B693C1@users.sourceforge.net>
Message-ID: <Xine.LNX.4.44.0402151924490.13809-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 15 Feb 2004, Jari Ruusu wrote:

> Jan Rychter wrote:
> > FWIW, I've just tried loop-AES with 2.4.24, after using cryptoapi for a
> > number of years. My machine froze dead in the midst of copying 2.8GB of
> > data onto my file-backed reiserfs encrypted loopback mount.
> > 
> > Since the system didn't ever freeze on me before and since I've had zero
> > problems with cryptoapi, I attribute the freeze to loop-AES.
> > 
> > Yes, I know this isn't a good bugreport...
> 
> Is there any particular reason why you insist on using file backed loops?
> 
> File backed loops have hard to fix re-entry problem: GFP_NOFS memory
> allocations that cause dirty pages to written out to file backed loop, will
> have to re-enter the file system anyway to complete the write. This causes
> deadlocks. Same deadlocks are there in mainline loop+cryptoloop combo.

Given the security issues, and the above problems, we should probably just
remove cryptoloop from the kernel and wait for something with a better
design.



- James
-- 
James Morris
<jmorris@redhat.com>


