Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932165AbWAEUah@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932165AbWAEUah (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 15:30:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932169AbWAEUah
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 15:30:37 -0500
Received: from omx3-ext.sgi.com ([192.48.171.26]:24767 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S932165AbWAEUag (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 15:30:36 -0500
Date: Thu, 5 Jan 2006 12:30:30 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Andrew Morton <akpm@osdl.org>
cc: jeff shia <tshxiayu@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: what is the state of current after an mm_fault occurs?
In-Reply-To: <20060104192334.1e88cfda.akpm@osdl.org>
Message-ID: <Pine.LNX.4.62.0601051228320.7328@schroedinger.engr.sgi.com>
References: <7cd5d4b40601040240n79b2d654t33424e91059988a9@mail.gmail.com>
 <20060104174808.7b882af8.akpm@osdl.org> <7cd5d4b40601041920u596551d2h75e167311e9452e4@mail.gmail.com>
 <20060104192334.1e88cfda.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Jan 2006, Andrew Morton wrote:

> >  You mean in some pagefault place we do schedule()?
> 
> We used to - that should no longer be the case.  The TASK_RUNNING thing is
> probably redundant now.

The page fault handler calls the page allocator in various places 
which may sleep. 

current may not point to the current process if the page fault handler was 
called from get_user_pages.

