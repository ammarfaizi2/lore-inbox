Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262631AbVA0OQA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262631AbVA0OQA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 09:16:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262632AbVA0OQA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 09:16:00 -0500
Received: from apachihuilliztli.mtu.ru ([195.34.32.124]:2053 "EHLO
	Apachihuilliztli.mtu.ru") by vger.kernel.org with ESMTP
	id S262631AbVA0OPy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 09:15:54 -0500
Subject: Re: [2.6.11-rc2] kernel BUG at fs/reiserfs/prints.c:362
From: Vladimir Saveliev <vs@namesys.com>
To: Jan Kara <jack@suse.cz>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <20050127112647.GA20806@atrey.karlin.mff.cuni.cz>
References: <200501271024.13778.rathamahata@ehouse.ru>
	 <1106821035.3270.30.camel@tribesman>
	 <20050127112647.GA20806@atrey.karlin.mff.cuni.cz>
Content-Type: text/plain
Message-Id: <1106835321.6191.130.camel@tribesman>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Thu, 27 Jan 2005 17:15:22 +0300
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

On Thu, 2005-01-27 at 14:26, Jan Kara wrote:
>   Hello,
> 
> > On Thu, 2005-01-27 at 10:24, Sergey S. Kostyliov wrote:
> > > Hello all,
> > > 
> > > Here is a BUG() I've just hited on quota enabled reiserfs disk.
> > > 
> > > rathamahata@dev rathamahata $ mount | grep /dev/sdb2
> > > /dev/sdb2 on /var/www type reiserfs (rw,noatime,nodiratime,data=writeback,grpquota,usrquota)
> > > rathamahata@dev rathamahata $
> > > 
> > > REISERFS: panic (device sdb2): journal_begin called without kernel lock held
> > 
> > Would you check whether this patch helps, please?
>   BTW: What are the exact rules where lock_kernel() should be held for
> reiserfs? Is there a doc somewhere? 
I do not think so.
Earlier reiserfs used to lock_kernel on entering and unlock on exit. The
reason is that reiserfs has no fine grain locking protecting access to
its data structures.
Since that time there could be introduced some minor improvements,
though.

> I suspect we might need the lock
> also for reiserfs_quota_read() (reiserfs_quota_write() should be
> already protected by your fix).
>   Hmm, I should also check ext2/ext3 whether it needs the lock...
> 
> 								Honza

