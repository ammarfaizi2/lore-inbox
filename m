Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932513AbWCIQ0r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932513AbWCIQ0r (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 11:26:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932444AbWCIQ0r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 11:26:47 -0500
Received: from rune.pobox.com ([208.210.124.79]:22436 "EHLO rune.pobox.com")
	by vger.kernel.org with ESMTP id S932648AbWCIQ0q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 11:26:46 -0500
Date: Thu, 9 Mar 2006 09:26:37 -0700
From: Paul Dickson <dickson@permanentmail.com>
To: NeilBrown <neilb@suse.de>
Cc: akpm@osdl.org, nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 001 of 14] knfsd: Change the store of auth_domains to
 not be a 'cache'.
Message-Id: <20060309092637.4d008f97.dickson@permanentmail.com>
In-Reply-To: <1060309065127.24521@suse.de>
References: <20060309174755.24381.patches@notabene>
	<1060309065127.24521@suse.de>
X-Mailer: Sylpheed version 2.2.0beta7 (GTK+ 2.8.13; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Mar 2006 17:51:27 +1100, NeilBrown wrote:

>  struct auth_domain *unix_domain_find(char *name)
>  {
> - [code deletions removed]
> +	struct auth_domain *rv;
> +	struct unix_domain *new = NULL;
>  
> - [code deletions removed]
> +	rv = auth_domain_lookup(name, NULL);
> +	while(1) {
> +		if (rv != &new->h) {
> +			if (new) auth_domain_put(&new->h);
> +			return rv;
> +		}

> +		new = kmalloc(sizeof(*new), GFP_KERNEL);
> +		if (new == NULL)
> +			return NULL;

My C skills are a bit rusty, but is seems the value of new is offsetted
while still NULL.  I could not find any further updates in the patch
series.

	-Paul

