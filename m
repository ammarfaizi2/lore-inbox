Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932093AbWCTK43@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932093AbWCTK43 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 05:56:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932111AbWCTK43
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 05:56:29 -0500
Received: from smtp.osdl.org ([65.172.181.4]:57059 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932093AbWCTK42 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 05:56:28 -0500
Date: Mon, 20 Mar 2006 02:53:11 -0800
From: Andrew Morton <akpm@osdl.org>
To: prasanna@in.ibm.com
Cc: ak@suse.de, davem@davemloft.net, suparna@in.ibm.com,
       richardj_moore@uk.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [2/3 PATCH] Kprobes: User space probes support- readpage hooks
Message-Id: <20060320025311.419a44e3.akpm@osdl.org>
In-Reply-To: <20060320061014.GE31091@in.ibm.com>
References: <20060320060745.GC31091@in.ibm.com>
	<20060320060931.GD31091@in.ibm.com>
	<20060320061014.GE31091@in.ibm.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Prasanna S Panchamukhi <prasanna@in.ibm.com> wrote:
>
> This patch provides the feature of inserting probes on pages that are
> not present in the memory during registration.
> 
> To add readpage and readpages() hooks, two new elements are added to
> the uprobe_module object:
> 	struct address_space_operations *ori_a_ops;
> 	struct address_space_operations user_a_ops;
> 
> User-space probes allows probes to be inserted even in pages that are
> not present in the memory at the time of registration. This is done
> by adding hooks to the readpage and readpages routines. During
> registration, the address space operation object is modified by
> substituting user-space probes's specific readpage and readpages
> routines. When the pages are read into memory through the readpage and
> readpages address space operations, any associated probes are
> automatically inserted into those pages. These user-space probes
> readpage and readpages routines internally call the original
> readpage() and readpages() routines, and then check whether probes are
> to be added to these pages, inserting probes as necessary. The
> overhead of adding these hooks is limited to the application on which
> the probes are inserted.
> 
> During unregistration, care should be taken to replace the readpage and
> readpages hooks with the original routines if no probes remain on that
> application.
> 

So...  The code's replacing the address_space's address_space_operations
with a copy which has .readpage() and .readpages() modified, because it
happens that filemap_nopage() uses those.

This is all rather hacky.

I think we need to step back and discuss what services this feature is
trying to provide, and how it is to provide them.  Your covering
description didn't describe that - it dives straigt into details without
even describing what the patches are trying to achieve.

So.  What are we trying to achieve here, and how are we trying to achieve
it?  What problems were encountered in the development of the feature and
how were they solved?  What alternative solutions were there?

I can mostly work all that out from background knowledge and looking at the
code, but I'd rather hear it from the designers please.
