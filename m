Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751204AbWIWOio@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751204AbWIWOio (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Sep 2006 10:38:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751205AbWIWOio
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Sep 2006 10:38:44 -0400
Received: from excu-mxob-1.symantec.com ([198.6.49.12]:11725 "EHLO
	excu-mxob-1.symantec.com") by vger.kernel.org with ESMTP
	id S1751204AbWIWOin (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Sep 2006 10:38:43 -0400
Date: Sat, 23 Sep 2006 15:38:34 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@blonde.wat.veritas.com
To: Kylene Jo Hall <kjhall@us.ibm.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>, akpm@osdl.org,
       Mimi Zohar <zohar@us.ibm.com>, Dave Safford <safford@us.ibm.com>,
       Serge Hallyn <sergeh@us.ibm.com>
Subject: Re: [PATCH] slim: fix bug with mm_users usage
In-Reply-To: <1158966797.20493.76.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0609231527560.26585@blonde.wat.veritas.com>
References: <1158966797.20493.76.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 23 Sep 2006 14:38:30.0426 (UTC) FILETIME=[F03DB7A0:01C6DF1D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Sep 2006, Kylene Jo Hall wrote:

Nothing to do with this patch as such, but as it went past I noticed

> --- linux-2.6.18-rc6-orig/security/slim/slm_main.c	2006-09-18 16:41:51.000000000 -0500
> +++ linux-2.6.18-rc6/security/slim/slm_main.c	2006-09-22 13:58:35.000000000 -0500
> @@ -529,7 +519,7 @@ static int enforce_integrity_read(struct
>  	spin_lock(&cur_tsec->lock);
>  	if (!is_iac_less_than_or_exempt(level, cur_tsec->iac_r)) {
>  		rc = has_file_wperm(level);
> -		if (atomic_read(&current->mm->mm_users) != 1)
> +		if (current->mm && atomic_read(&current->mm->mm_users) != 1)
>  			rc = 1;

I've not studied your patches, and I don't know what that line's about,
but you appear to be attaching considerable significance to the value of
mm->mm_users.  Yet swapoff (try_to_unuse) has to bump it up to hold the
mm temporarily, as does get_task_mm() used in various places (mainly /proc).

Hugh
