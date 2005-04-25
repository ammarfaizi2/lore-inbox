Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262685AbVDYSGx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262685AbVDYSGx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 14:06:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262694AbVDYSGx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 14:06:53 -0400
Received: from mail.dif.dk ([193.138.115.101]:40076 "EHLO saerimmer.dif.dk")
	by vger.kernel.org with ESMTP id S262685AbVDYSGu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 14:06:50 -0400
Date: Mon, 25 Apr 2005 20:10:04 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: David Teigland <teigland@redhat.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH 2/7] dlm: communication
In-Reply-To: <20050425151218.GC6826@redhat.com>
Message-ID: <Pine.LNX.4.62.0504251844540.2941@dragon.hyggekrogen.localhost>
References: <20050425151218.GC6826@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Apr 2005, David Teigland wrote:

> 
> Inter-node communiction using SCTP.  This level is not aware of locks or
> resources or other dlm objects, only data buffers.  These functions also
> batch (and extract) lots of small messages bound for one node into larger
> chunks.
> 
> Signed-Off-By: Dave Teigland <teigland@redhat.com>
> Signed-Off-By: Patrick Caulfield <pcaulfie@redhat.com>
> 
> ---
> 
> +struct connection {
> +	struct socket *		sock;
> +	unsigned long		flags;
> +	struct page *		rx_page;
> +	atomic_t		waiting_requests;
> +	struct cbuf		cb;
> +};

type * varname;  is not very pretty. The prefered form is generally
type *varname;
Several instances of this in various places.


> +static void init_failed(void)
> +{
> +	int i;
> +	struct nodeinfo *ni;
> +
> +	for (i=1; i<=max_nodeid; i++) {
Nitpicking, but how about a few spaces? 
        for (i = 1; i <= max_nodeid; i++) {
makes it more readable IMHO.

> +#if 0
> +static int lowcomms_close(int nodeid)
> +{

Ehh, why try and merge code that's not active? Why not leave it out and 
submit a patch later to add it if it is needed later?


-- 
Jesper Juhl


