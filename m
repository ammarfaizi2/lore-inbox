Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268698AbUIQNQb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268698AbUIQNQb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 09:16:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268733AbUIQNQb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 09:16:31 -0400
Received: from postfix3-1.free.fr ([213.228.0.44]:21475 "EHLO
	postfix3-1.free.fr") by vger.kernel.org with ESMTP id S268698AbUIQNQ2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 09:16:28 -0400
From: Duncan Sands <baldrick@free.fr>
To: Stelian Pop <stelian@popies.net>
Subject: Re: [RFC, 2.6] a simple FIFO implementation
Date: Fri, 17 Sep 2004 15:16:24 +0200
User-Agent: KMail/1.6.2
Cc: Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
References: <20040917102413.GA3089@crusoe.alcove-fr> <200409171500.35499.baldrick@free.fr> <20040917130532.GA22386@sd291.sivit.org>
In-Reply-To: <20040917130532.GA22386@sd291.sivit.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200409171516.24840.baldrick@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Hi Stelian, what is to stop the compiler putting, say, "in" in a register
> > for the process calling __kfifo_get, so that it only sees a constant
> > value.  Then after a while that process will think there is nothing
> > to get even though another process is shoving stuff into the fifo and
> > modifying "in".
> 
> This can happen all right, but the buffer (or the indices) will not
> get corrupt (this is what I call coherent). Its just like the __kfifo_get()
> was executed entirely before the __kfifo_put().

Hi Stelian, that's not how I read the comment

+ * Note that with only one concurrent reader and one concurrent 
+ * writer, you don't need extra locking to use these functions.

so maybe it is better to avoid confusion and be more explicit here.

Ciao,

Duncan.
