Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263515AbUCTT2c (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Mar 2004 14:28:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263516AbUCTT2c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Mar 2004 14:28:32 -0500
Received: from fw.osdl.org ([65.172.181.6]:58854 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263515AbUCTT2b convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Mar 2004 14:28:31 -0500
Date: Sat, 20 Mar 2004 11:28:28 -0800
From: Andrew Morton <akpm@osdl.org>
To: =?ISO-8859-1?B?SvZybg==?= Engel <joern@wohnheim.fh-wedel.de>
Cc: linux-kernel@vger.kernel.org, akpm@digeo.com,
       viro@parcelfarce.linux.theplanet.co.uk, s.b.wielinga@student.utwente.nl
Subject: Re: [PATCH] cowlinks v2
Message-Id: <20040320112828.7bce82d2.akpm@osdl.org>
In-Reply-To: <20040320112718.GA4688@wohnheim.fh-wedel.de>
References: <20040320083411.GA25934@wohnheim.fh-wedel.de>
	<20040320004901.4328c1e1.akpm@osdl.org>
	<20040320112718.GA4688@wohnheim.fh-wedel.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jörn Engel <joern@wohnheim.fh-wedel.de> wrote:
>
> > i_lock is an innermost lock.  No locks should be taken inside i_lock.
>  > 
>  > Here, not only is inode_lock being taken inside i_lock but ->dirty_inode
>  > may be called as well, and dirty_inode() may not be called under any
>  > spinlock.
> 
>  Is it enough to move the mark_inode_dirty outside of i_lock?

yup.  Now you're using i_lock to protect i_flags (which seems reasonable)
you'll need to hnt down all the other i_flags users and make them use
i_lock too.  Currently they appear to be using i_sem.

