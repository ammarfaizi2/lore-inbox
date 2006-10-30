Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965266AbWJ3Qrs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965266AbWJ3Qrs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 11:47:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965257AbWJ3Qrs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 11:47:48 -0500
Received: from sj-iport-6.cisco.com ([171.71.176.117]:41525 "EHLO
	sj-iport-6.cisco.com") by vger.kernel.org with ESMTP
	id S965161AbWJ3Qrr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 11:47:47 -0500
To: Al Viro <viro@ftp.linux.org.uk>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
       torvalds@osdl.org
Subject: Re: [PATCH 2/7] severing fs.h, radix-tree.h -> sched.h
X-Message-Flag: Warning: May contain useful information
References: <E1GeUeF-0002o7-6s@ZenIV.linux.org.uk>
From: Roland Dreier <rdreier@cisco.com>
Date: Mon, 30 Oct 2006 08:47:44 -0800
In-Reply-To: <E1GeUeF-0002o7-6s@ZenIV.linux.org.uk> (Al Viro's message of "Mon, 30 Oct 2006 10:45:43 +0000")
Message-ID: <adak62hyclr.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 30 Oct 2006 16:47:45.0253 (UTC) FILETIME=[1FC32950:01C6FC43]
Authentication-Results: sj-dkim-1.cisco.com; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trivial comment:

 >  /*
 > + * Superblock locking.  We really ought to get rid of these two.
 > + */
 > +void lock_super(struct super_block * sb)
 > +{
 > +	get_fs_excl();
 > +	mutex_lock(&sb->s_lock);
 > +}
 > +
 > +void unlock_super(struct super_block * sb)
 > +{
 > +	put_fs_excl();
 > +	mutex_unlock(&sb->s_lock);
 > +}
 > +
 > +EXPORT_SYMBOL(lock_super);
 > +EXPORT_SYMBOL(unlock_super);

isn't the current fashion to do this like:

void lock_super(struct super_block * sb)
{
	get_fs_excl();
	mutex_lock(&sb->s_lock);
}
EXPORT_SYMBOL(lock_super);

void unlock_super(struct super_block * sb)
{
	put_fs_excl();
	mutex_unlock(&sb->s_lock);
}
EXPORT_SYMBOL(unlock_super);
