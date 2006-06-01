Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965101AbWFATLR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965101AbWFATLR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 15:11:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965280AbWFATLR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 15:11:17 -0400
Received: from smtp.osdl.org ([65.172.181.4]:42920 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965101AbWFATLQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 15:11:16 -0400
Date: Thu, 1 Jun 2006 12:15:22 -0700
From: Andrew Morton <akpm@osdl.org>
To: olh@suse.de, linux-kernel@vger.kernel.org, viro@ftp.linux.org.uk
Subject: Re: [PATCH] cramfs corruption after BLKFLSBUF on loop device
Message-Id: <20060601121522.6783f233.akpm@osdl.org>
In-Reply-To: <20060601121200.457c0335.akpm@osdl.org>
References: <20060529214011.GA417@suse.de>
	<20060530182453.GA8701@suse.de>
	<20060601184938.GA31376@suse.de>
	<20060601121200.457c0335.akpm@osdl.org>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Jun 2006 12:12:00 -0700
Andrew Morton <akpm@osdl.org> wrote:

> I'd have
> thought that it'd be appropriate to take i_mutex while running
> invalidate_inode_pages().

Let me add: it'd be appropriate, but also difficult -
invalidate_inode_pages() is called from all sorts of contexts, including
inside spinlock.

A quickie fix would be to take i_mutex at the top level, on entry to the
ioctl.  But that'll only fix the BLKFLSBUF case.

