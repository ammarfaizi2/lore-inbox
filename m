Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261628AbSIXJrZ>; Tue, 24 Sep 2002 05:47:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261629AbSIXJrY>; Tue, 24 Sep 2002 05:47:24 -0400
Received: from [80.120.128.82] ([80.120.128.82]:8708 "EHLO hofr.at")
	by vger.kernel.org with ESMTP id <S261628AbSIXJrY>;
	Tue, 24 Sep 2002 05:47:24 -0400
From: Der Herr Hofrat <der.herr@mail.hofr.at>
Message-Id: <200209240854.g8O8sr407036@hofr.at>
Subject: Re: mmap question
In-Reply-To: <200209240726.g8O7QNA06595@hofr.at> from Der Herr Hofrat at "Sep
 24, 2002 09:26:23 am"
Date: Tue, 24 Sep 2002 10:54:53 +0200 (CEST)
CC: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> int
> init_module(void){
> 	...
> 	kmalloc_area=kmalloc(LEN,GFP_USER);
> 	strncpy(kmalloc_area,init_msg,sizeof(init_msg));
> 	...
> }

found the problem (naturally after posting....) - forgot to mark 
the page as reserved...

	struct page *page;
	kmalloc_area=kmalloc(LEN,GFP_USER);
	page = virt_to_page(kmalloc_area); 
	mem_map_reserve(page);
	memcpy(kmalloc_area,msg,sizeof(msg));

hofrat
