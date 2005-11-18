Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932071AbVKRPey@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932071AbVKRPey (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 10:34:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932074AbVKRPex
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 10:34:53 -0500
Received: from relay4.usu.ru ([194.226.235.39]:49642 "EHLO relay4.usu.ru")
	by vger.kernel.org with ESMTP id S932071AbVKRPex (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 10:34:53 -0500
Message-ID: <437DF42B.8000008@ums.usu.ru>
Date: Fri, 18 Nov 2005 20:32:59 +0500
From: "Alexander E. Patrakov" <patrakov@ums.usu.ru>
User-Agent: Debian Thunderbird 1.0.2 (X11/20051002)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alasdair G Kergon <agk@redhat.com>
Cc: linux-kernel@vger.kernel.org, jblunck@suse.de
Subject: Re: [PATCH] device-mapper snapshot: bio_list fix
References: <20051118145547.GK11878@agk.surrey.redhat.com>
In-Reply-To: <20051118145547.GK11878@agk.surrey.redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by AntiVir MailGate (version: 2.0.1.15; AVE: 6.32.0.58; VDF: 6.32.0.196; host: usu2.usu.ru)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alasdair G Kergon wrote:
> bio_list_merge() should do nothing if the second list is empty - not oops.
> 
> From: jblunck@suse.de
> Signed-Off-By: Alasdair G Kergon <agk@redhat.com>
> 
> Index: linux-2.6.14/drivers/md/dm-bio-list.h
> ===================================================================
> --- linux-2.6.14.orig/drivers/md/dm-bio-list.h	2005-10-28 01:02:08.000000000 +0100
> +++ linux-2.6.14/drivers/md/dm-bio-list.h	2005-11-15 15:59:20.000000000 +0000
> @@ -33,6 +33,9 @@ static inline void bio_list_add(struct b
>  
>  static inline void bio_list_merge(struct bio_list *bl, struct bio_list *bl2)
>  {
> +	if (!bl2->head)
> +		return;
> +
>  	if (bl->tail)
>  		bl->tail->bi_next = bl2->head;
>  	else

Could you please tell how to reproduce this oops using e.g. loop 
devices? This patch looks relevant to my Live CD (although no oops has 
been reported yet).

-- 
Alexander E. Patrakov
