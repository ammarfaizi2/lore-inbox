Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267295AbUG1Qal@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267295AbUG1Qal (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 12:30:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267312AbUG1Q1n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 12:27:43 -0400
Received: from fw.osdl.org ([65.172.181.6]:43701 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267304AbUG1QZH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 12:25:07 -0400
Date: Wed, 28 Jul 2004 09:23:34 -0700
From: Andrew Morton <akpm@osdl.org>
To: Alan Cox <alan@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PATCH: fix some 32bit isms
Message-Id: <20040728092334.74e0cfcd.akpm@osdl.org>
In-Reply-To: <20040728135941.GA17409@devserv.devel.redhat.com>
References: <20040728135941.GA17409@devserv.devel.redhat.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@redhat.com> wrote:
>
>  		printk(MYIOC_s_ERR_FMT 
>   		     "Invalid IOC facts reply, msgLength=%d offsetof=%d!\n",
>  -		     ioc->name, facts->MsgLength, (offsetof(IOCFactsReply_t,
>  +		     ioc->name, facts->MsgLength, (int)(offsetof(IOCFactsReply_t,

printk expects %zd for a size_t

>   		     RequestFrameSize)/sizeof(u32)));
> ...
>   			printk(KERN_WARNING "INFTL: allocation of PUtable "
>  -				"failed (%d bytes)\n",
>  +				"failed (%ld bytes)\n",
>   				inftl->nb_blocks * sizeof(u16));

Some architectures will emit a warning here, and will perhaps print the
wrong thing.  We need to print size_t's with %zd.  I'll fix that up.
