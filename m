Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263230AbUCNAer (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Mar 2004 19:34:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263234AbUCNAer
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Mar 2004 19:34:47 -0500
Received: from fw.osdl.org ([65.172.181.6]:61861 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263230AbUCNAep (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Mar 2004 19:34:45 -0500
Date: Sat, 13 Mar 2004 16:34:51 -0800
From: Andrew Morton <akpm@osdl.org>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] kref, a tiny, sane, reference count object
Message-Id: <20040313163451.3c841ac2.akpm@osdl.org>
In-Reply-To: <20040313082003.GA13084@kroah.com>
References: <20040313082003.GA13084@kroah.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <greg@kroah.com> wrote:
>
> For all of those people, this patch is for you.

It does rather neatly capture a common idiom.

> +struct kref * kref_get(struct kref *kref)
> +{
> +	if (kref) {
> +		WARN_ON(!atomic_read(&kref->refcount));
> +		atomic_inc(&kref->refcount);
> +	}
> +	return kref;
> +}

Why is a NULL arg permitted here?

> +void kref_cleanup(struct kref *kref)
> +{
> +	if (!kref)
> +		return;

and here?
