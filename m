Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964903AbWACVXN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964903AbWACVXN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 16:23:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964910AbWACVXL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 16:23:11 -0500
Received: from omx3-ext.sgi.com ([192.48.171.25]:48571 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S964898AbWACVWq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 16:22:46 -0500
Date: Tue, 3 Jan 2006 13:22:38 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Avishay Traeger <atraeger@cs.sunysb.edu>
cc: linux-kernel@vger.kernel.org
Subject: Re: page refcounts?
In-Reply-To: <1135868372.28155.4.camel@rockstar.fsl.cs.sunysb.edu>
Message-ID: <Pine.LNX.4.62.0601031321260.21392@schroedinger.engr.sgi.com>
References: <1135868372.28155.4.camel@rockstar.fsl.cs.sunysb.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Dec 2005, Avishay Traeger wrote:

> How does the kernel determine when a page is unused?  I see that
> __get_free_pages() returns pages that have no refcount and no flags
> indicating that they should not be reclaimed.
> 
> The first page that is returned looks like:
> flags:0x80000000 mapping:00000000 mapcount:0 count:1
> 
> And the subsequent pages look like:
> flags:0x80000000 mapping:00000000 mapcount:0 count:0
> 
> I am printing this out exactly the way bad_page() does.  How does the
> kernel know not to mess around with pages that have no refcount or any
> flags to indicate that they are in use?  I've already searched google
> and checked a couple books, and couldn't find an answer.

The kernel knows that a page is free if count == 0 in the first page.
All pages of a higher order allocation are managed through the status of 
the first page.
