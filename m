Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264777AbUFTAWg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264777AbUFTAWg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jun 2004 20:22:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264782AbUFTAWg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jun 2004 20:22:36 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:6272 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264777AbUFTAWd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jun 2004 20:22:33 -0400
Date: Sat, 19 Jun 2004 21:15:29 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Chris Caputo <ccaputo@alt.net>
Cc: linux-kernel@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>,
       riel@redhat.com
Subject: Re: inode_unused list corruption in 2.4.26 - spin_lock problem?
Message-ID: <20040620001529.GA4326@logos.cnet>
References: <Pine.LNX.4.44.0406181730370.1847-100000@nacho.alt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0406181730370.1847-100000@nacho.alt.net>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Chris,

I've seen your previous post -- should have answered you earlier.

On Fri, Jun 18, 2004 at 05:47:05PM -0700, Chris Caputo wrote:
> In 2.4.26 on two different dual-proc x86 machines (one dual-P4 Xeon based,
> the other dual-PIII) I am seeing crashes which are the result of the
> inode_unused doubly linked list in fs/inode.c becoming corrupted.

What steps are required to reproduce the problem?

> A particular instance of the corruption I have isolated is in a call from
> iput() to __refile_inode().  To try to diagnose this further I placed list
> verification code before and after the list_del() and list_add() calls in
> __refile_inode() and observed a healthy list become corrupted after the
> del/add was completed.

Can you show us this data in more detail?

> It would seem to me that list corruption on otherwise healthy machines
> would only be the result of the inode_lock spinlock not being properly
> locked prior to the call to __refile_inode(), but as far as I can tell,
> the call to atomic_dec_and_lock() in iput() is doing that properly.
> 
> So I am at a loss.  Has anyone else seen this or does anyone have any idea
> what routes I should be exploring to fix this problem?

The changes between 2.4.25->2.4.26 (which introduce __refile_inode() and 
the unused_pagecache list) must have something to do with this. 

David, Rik, can you give some help here?
