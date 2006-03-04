Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751494AbWCDHhs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751494AbWCDHhs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Mar 2006 02:37:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751508AbWCDHhs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Mar 2006 02:37:48 -0500
Received: from smtp.osdl.org ([65.172.181.4]:21664 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751494AbWCDHhr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Mar 2006 02:37:47 -0500
Date: Fri, 3 Mar 2006 23:36:17 -0800
From: Andrew Morton <akpm@osdl.org>
To: Daniel Phillips <phillips@google.com>
Cc: linux-kernel@vger.kernel.org, ocfs2-devel@oss.oracle.com
Subject: Re: Ocfs2 performance bugs of doom
Message-Id: <20060303233617.51718c8e.akpm@osdl.org>
In-Reply-To: <4408C2E8.4010600@google.com>
References: <4408C2E8.4010600@google.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips <phillips@google.com> wrote:
>
> @@ -103,31 +103,28 @@ struct dlm_lock_resource * __dlm_lookup_
>    					 const char *name,
>    					 unsigned int len)
>    {
>  -	unsigned int hash;
>  -	struct hlist_node *iter;
>  -	struct dlm_lock_resource *tmpres=NULL;
>    	struct hlist_head *bucket;
>  +	struct hlist_node *list;
> 
>    	mlog_entry("%.*s\n", len, name);
> 
>    	assert_spin_locked(&dlm->spinlock);
>  +	bucket = dlm->lockres_hash + full_name_hash(name, len) % DLM_HASH_BUCKETS;
> 
>  -	hash = full_name_hash(name, len);

err, you might want to calculate that hash outside the spinlock.

Maybe have a lock per bucket, too.

A 1MB hashtable is verging on comical.  How may data are there in total?

