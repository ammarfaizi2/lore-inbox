Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265649AbUFSAu1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265649AbUFSAu1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 20:50:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265516AbUFSAuV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 20:50:21 -0400
Received: from nacho.alt.net ([207.14.113.18]:24741 "HELO nacho.alt.net")
	by vger.kernel.org with SMTP id S261375AbUFSArK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 20:47:10 -0400
Date: Fri, 18 Jun 2004 17:47:05 -0700 (PDT)
To: linux-kernel@vger.kernel.org
Subject: inode_unused list corruption in 2.4.26 - spin_lock problem?
Message-ID: <Pine.LNX.4.44.0406181730370.1847-100000@nacho.alt.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
From: Chris Caputo <ccaputo@alt.net>
X-Delivery-Agent: TMDA/1.0.2 (Bold Forbes)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In 2.4.26 on two different dual-proc x86 machines (one dual-P4 Xeon based,
the other dual-PIII) I am seeing crashes which are the result of the
inode_unused doubly linked list in fs/inode.c becoming corrupted.

A particular instance of the corruption I have isolated is in a call from
iput() to __refile_inode().  To try to diagnose this further I placed list
verification code before and after the list_del() and list_add() calls in
__refile_inode() and observed a healthy list become corrupted after the
del/add was completed.

It would seem to me that list corruption on otherwise healthy machines
would only be the result of the inode_lock spinlock not being properly
locked prior to the call to __refile_inode(), but as far as I can tell,
the call to atomic_dec_and_lock() in iput() is doing that properly.

So I am at a loss.  Has anyone else seen this or does anyone have any idea
what routes I should be exploring to fix this problem?

Thank you,
Chris

