Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932338AbWCVTEF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932338AbWCVTEF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 14:04:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932342AbWCVTEF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 14:04:05 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:9171 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP id S932338AbWCVTEE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 14:04:04 -0500
Date: Wed, 22 Mar 2006 14:04:03 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Kristen Accardi <kristen.c.accardi@intel.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] add private data to notifier_block
In-Reply-To: <1142970154.31210.10.camel@whizzy>
Message-ID: <Pine.LNX.4.44L0.0603221402070.7453-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Mar 2006, Kristen Accardi wrote:

> While most current uses of notifier_block use a global struct, I would
> like to be able to use it on a per device basis for drivers which have
> multiple device instances.  I would also like to be able to have a
> private data struct associated with the notifier block so that per
> device data can be easily accessed.  This patch will modify the
> notifier_block struct to add a void *, and will require no modifications
> to any other users of the notifier_block.
> 
> Signed-off-by:  Kristen Carlson Accardi <kristen.c.accardi@intel.com>
> 
> ---
>  include/linux/notifier.h |    1 +
>  1 files changed, 1 insertion(+)
> 
> --- 2.6-git-kca.orig/include/linux/notifier.h
> +++ 2.6-git-kca/include/linux/notifier.h
> @@ -15,6 +15,7 @@ struct notifier_block
>  {
>  	int (*notifier_call)(struct notifier_block *self, unsigned long, void *);
>  	struct notifier_block *next;
> +	void *data;
>  	int priority;
>  };

I still think this isn't really needed.  The same effect can be 
accomplished by embedding a notifier_block struct within a larger 
structure that also contains the data pointer.

On the other hand this isn't a terribly big change, so I don't actually 
object to it.

Alan Stern

