Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261522AbVAGStA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261522AbVAGStA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 13:49:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261530AbVAGStA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 13:49:00 -0500
Received: from fw.osdl.org ([65.172.181.6]:51330 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261522AbVAGSsy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 13:48:54 -0500
Date: Fri, 7 Jan 2005 10:48:38 -0800
From: Andrew Morton <akpm@osdl.org>
To: Vladimir Saveliev <vs@namesys.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, hch@infradead.org
Subject: Re: [RFC] per thread page reservation patch
Message-Id: <20050107104838.0eacd301.akpm@osdl.org>
In-Reply-To: <1105118217.3616.171.camel@tribesman.namesys.com>
References: <20050103011113.6f6c8f44.akpm@osdl.org>
	<20050103114854.GA18408@infradead.org>
	<41DC2386.9010701@namesys.com>
	<1105019521.7074.79.camel@tribesman.namesys.com>
	<20050107144644.GA9606@infradead.org>
	<1105118217.3616.171.camel@tribesman.namesys.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vladimir Saveliev <vs@namesys.com> wrote:
>
> +int perthread_pages_reserve(int nrpages, int gfp)
>  +{
>  +	int i;
>  +	struct list_head  accumulator;
>  +	struct list_head *per_thread;
>  +
>  +	per_thread = get_per_thread_pages();
>  +	INIT_LIST_HEAD(&accumulator);
>  +	list_splice_init(per_thread, &accumulator);
>  +	for (i = 0; i < nrpages; ++i) {

This will end up reserving more pages than were asked for, if
current->private_pages_count is non-zero.  Deliberate?
