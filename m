Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261720AbVBSOdG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261720AbVBSOdG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Feb 2005 09:33:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261721AbVBSOdG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Feb 2005 09:33:06 -0500
Received: from smtpq2.home.nl ([213.51.128.197]:32930 "EHLO smtpq2.home.nl")
	by vger.kernel.org with ESMTP id S261720AbVBSOcx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Feb 2005 09:32:53 -0500
Message-ID: <42174DD4.9010506@keyaccess.nl>
Date: Sat, 19 Feb 2005 15:31:48 +0100
From: Rene Herman <rene.herman@keyaccess.nl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8a6) Gecko/20050111
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Roland Dreier <roland@topspin.com>
CC: Vicente Feito <vicente.feito@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: workqueue - process context
References: <200502190148.11334.vicente.feito@gmail.com> <52is4ptae0.fsf@topspin.com>
In-Reply-To: <52is4ptae0.fsf@topspin.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AtHome-MailScanner-Information: Neem contact op met support@home.nl voor meer informatie
X-AtHome-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland Dreier wrote:

> Not destroying its workqueue is a bug in the module just like any
> other resource leak.  It's analogous to a module allocating some
> memory with kmalloc() and not calling kfree() when it's unloaded.

Except though that with kmalloc() it's indeed just a leak while in this 
case things might blow up violently if run_workqueue() later accesses a 
workqueue_struct (or work_struct) which is already gone as part of the 
modules' datasection, for example. That's to say, if I'm reading this 
right...

I have no idea about the module refcounting stuff. Is there a chance 
that create_workqueue() could increase a reference somewhere so that the 
module wouldn't be allowed to unload untill after a destroy_workqueue()?

Rene.
