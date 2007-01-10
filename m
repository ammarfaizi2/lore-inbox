Return-Path: <linux-kernel-owner+w=401wt.eu-S964916AbXAJQMx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964916AbXAJQMx (ORCPT <rfc822;w@1wt.eu>);
	Wed, 10 Jan 2007 11:12:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964934AbXAJQMw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Jan 2007 11:12:52 -0500
Received: from h155.mvista.com ([63.81.120.158]:12015 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S964916AbXAJQMw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Jan 2007 11:12:52 -0500
Subject: Re: [PATCH 2.6.20-rc4 1/4] futex priority based wakeup
From: Daniel Walker <dwalker@mvista.com>
To: Pierre Peiffer <pierre.peiffer@bull.net>
Cc: LKML <linux-kernel@vger.kernel.org>, Dinakar Guniguntala <dino@in.ibm.com>,
       Jean-Pierre Dion <jean-pierre.dion@bull.net>,
       Ingo Molnar <mingo@elte.hu>, Ulrich Drepper <drepper@redhat.com>,
       Jakub Jelinek <jakub@redhat.com>, Darren Hart <dvhltc@us.ibm.com>,
       =?ISO-8859-1?Q?S=E9bastien_Dugu=E9?= <sebastien.dugue@bull.net>
In-Reply-To: <45A3BFC8.1030104@bull.net>
References: <45A3B330.9000104@bull.net>  <45A3BFC8.1030104@bull.net>
Content-Type: text/plain
Date: Wed, 10 Jan 2007 08:11:41 -0800
Message-Id: <1168445501.22579.7.camel@imap.mvista.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2007-01-09 at 17:16 +0100, Pierre Peiffer wrote:
> @@ -1358,7 +1366,7 @@ static int futex_unlock_pi(u32 __user *u
>         struct futex_hash_bucket *hb;
>         struct futex_q *this, *next;
>         u32 uval;
> -       struct list_head *head;
> +       struct plist_head *head;
>         union futex_key key;
>         int ret, attempt = 0;
> 
> @@ -1409,7 +1417,7 @@ retry_locked:
>          */
>         head = &hb->chain;
> 
> -       list_for_each_entry_safe(this, next, head, list) {
> +       plist_for_each_entry_safe(this, next, head, list) {
>                 if (!match_futex (&this->key, &key))
>                         continue;
>                 ret = wake_futex_pi(uaddr, uval, this);


Is this really necessary? The rtmutex will priority sort the waiters
when you enable priority inheritance. Inside the wake_futex_pi() it
actually just pulls the new owner off another plist inside the the
rtmutex structure.

Daniel

