Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262780AbVAKOgx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262780AbVAKOgx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 09:36:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262779AbVAKOgw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 09:36:52 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:43459 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S262780AbVAKOeP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 09:34:15 -0500
Date: Tue, 11 Jan 2005 15:34:14 +0100
From: Jan Kara <jack@suse.cz>
To: domen@coderock.org
Cc: linux-kernel@vger.kernel.org, janitor@sternwelten.at
Subject: Re: [patch 1/1] list_for_each_entry: fs-dquot.c
Message-ID: <20050111143414.GF15061@atrey.karlin.mff.cuni.cz>
References: <20050110184218.405431F1ED@trashy.coderock.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050110184218.405431F1ED@trashy.coderock.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hello,

> Make code more readable with list_for_each_entry_safe.
> (Didn't compile before, doesn't compile now)
  What do you mean by "didn't compile before"? Which kernel have you
tried?

> Signed-off-by: Maximilian Attems <janitor@sternwelten.at>
> Signed-off-by: Domen Puncer <domen@coderock.org>
> ---
> 
> 
>  kj-domen/fs/dquot.c |    7 ++-----
>  1 files changed, 2 insertions(+), 5 deletions(-)
> 
> diff -puN fs/dquot.c~list-for-each-entry-safe-fs_dquot fs/dquot.c
> --- kj/fs/dquot.c~list-for-each-entry-safe-fs_dquot	2005-01-10 17:59:46.000000000 +0100
> +++ kj-domen/fs/dquot.c	2005-01-10 17:59:46.000000000 +0100
> @@ -406,13 +406,10 @@ out_dqlock:
>   * for this sb+type at all. */
>  static void invalidate_dquots(struct super_block *sb, int type)
>  {
> -	struct dquot *dquot;
> -	struct list_head *head;
> +	struct dquot *dquot, *tmp;
>  
>  	spin_lock(&dq_list_lock);
> -	for (head = inuse_list.next; head != &inuse_list;) {
> -		dquot = list_entry(head, struct dquot, dq_inuse);
> -		head = head->next;
> +	list_for_each_entry_safe(dquot, tmp, &inuse_list, dq_inuse) {
>  		if (dquot->dq_sb != sb)
>  			continue;
>  		if (dquot->dq_type != type)


								Honza
-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs
