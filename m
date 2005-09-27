Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932313AbVI0EZd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932313AbVI0EZd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 00:25:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932324AbVI0EZd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 00:25:33 -0400
Received: from smtp.osdl.org ([65.172.181.4]:17846 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932313AbVI0EZd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 00:25:33 -0400
Date: Mon, 26 Sep 2005 21:24:46 -0700
From: Andrew Morton <akpm@osdl.org>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Readahead
Message-Id: <20050926212446.365778e3.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.44L0.0509262234500.32418-100000@netrider.rowland.org>
References: <Pine.LNX.4.44L0.0509262234500.32418-100000@netrider.rowland.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Stern <stern@rowland.harvard.edu> wrote:
>
>  Can somebody please tell me where the code is that performs optimistic
>  readahead when a process does sequential reads on a block device?

mm/readahead.c:__do_page_cache_readahead() is the main one.  Use
dump_stack() to be sure.

>  And can someone explain why those readahead calls are allowed to extend 
>  beyond the end of the device?

It has a check in there for reads past the blockdev mapping's i_size. 
Maybe i_size is wrong, or maybe the code is wrong, or maybe it's a
different caller.

