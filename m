Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264333AbTLPEs3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 23:48:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264339AbTLPEs3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 23:48:29 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:9949 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264333AbTLPEs2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 23:48:28 -0500
Date: Tue, 16 Dec 2003 04:48:27 +0000
From: viro@parcelfarce.linux.theplanet.co.uk
To: Thomas Molina <tmolina@cablespeed.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Is Rational rational?
Message-ID: <20031216044827.GO4176@parcelfarce.linux.theplanet.co.uk>
References: <Pine.LNX.4.58.0312152105550.5094@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0312152105550.5094@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 15, 2003 at 09:59:58PM -0500, Thomas Molina wrote:
> static inline int may_delete(struct inode *dir,struct dentry *victim, int isdir)
> {
> int error;
> - if (!victim->d_inode || victim->d_parent->d_inode != dir)
> + if (!victim->d_inode)
> return -ENOENT;

+ BUG_ON(victim->d_parent->d_inode != dir);

HAND.
 
> I'm not really competent to evaluate this proposesd patch, but it 
> certainly makes me nervous.  Their comment on this also bothers me: 
> "Rational Software believes that the check that is removed by this patch
> is one that should never fail for any properly operating filesystem. "

Precisely.  It does fail for their code, though.  Obvious conclusions are left
as an exercise to readers.
