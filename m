Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261864AbVC3LPA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261864AbVC3LPA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 06:15:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261863AbVC3LPA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 06:15:00 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:44730 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261862AbVC3LO6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 06:14:58 -0500
Date: Wed, 30 Mar 2005 12:14:39 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Christoph Lameter <christoph@lameter.com>
Cc: Manfred Spraul <manfred@colorfullife.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
       linux-mm@kvack.org, shai@scalex86.org
Subject: Re: [PATCH] Pageset Localization V2
Message-ID: <20050330111439.GA13110@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Christoph Lameter <christoph@lameter.com>,
	Manfred Spraul <manfred@colorfullife.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	linux-ia64@vger.kernel.org, linux-mm@kvack.org, shai@scalex86.org
References: <Pine.LNX.4.58.0503292147200.32571@server.graphe.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0503292147200.32571@server.graphe.net>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +#define MAKE_LIST(list, nlist)  \
> +	do {    \
> +		if(list_empty(&list))      \
> +			INIT_LIST_HEAD(nlist);          \
> +		else {  nlist->next->prev = nlist;      \
> +			nlist->prev->next = nlist;      \
> +		}                                       \
> +	}while(0)

This is horrible.  Where are the nlist pointers supposed to point to?
What's so magic you need the INIT_LIST_HEAD only conditionally?

