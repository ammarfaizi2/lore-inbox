Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262830AbVF3IGT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262830AbVF3IGT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 04:06:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262886AbVF3IGT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 04:06:19 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:62189 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S262830AbVF3IGM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 04:06:12 -0400
Date: Thu, 30 Jun 2005 04:05:43 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@localhost.localdomain
Reply-To: rostedt@goodmis.org
To: Denis Vlasenko <vda@ilport.com.ua>
cc: Timur Tabi <timur.tabi@ammasso.com>,
       Arjan van de Ven <arjan@infradead.org>, Jens Axboe <axboe@suse.de>,
       linux-kernel@vger.kernel.org
Subject: Re: kmalloc without GFP_xxx?
In-Reply-To: <200506301052.54570.vda@ilport.com.ua>
Message-ID: <Pine.LNX.4.58.0506300400540.21482@localhost.localdomain>
References: <200506291402.18064.vda@ilport.com.ua> <200506291714.32990.vda@ilport.com.ua>
 <42C2D0C1.4030500@ammasso.com> <200506301052.54570.vda@ilport.com.ua>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 30 Jun 2005, Denis Vlasenko wrote:

>
> Think about this:
>
> /* may be called under spinlock */
> void do_something() {
> 	/* we need to alloc here */
> }
>

Well thinking about this :-)  The way that this needs to be implemented is
by passing to do_something the flags to use in kmalloc, which is done in
the kernel when needing to call something that allocates when different
flags can be used. So a kmalloc_auto would only save on passing flags in
parameters, which can sometimes get annoying.

-- Steve

