Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262787AbVBYWqk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262787AbVBYWqk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Feb 2005 17:46:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262788AbVBYWqk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Feb 2005 17:46:40 -0500
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:48886 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S262787AbVBYWqh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Feb 2005 17:46:37 -0500
Message-ID: <421FAACB.4080207@acm.org>
Date: Fri, 25 Feb 2005 16:46:35 -0600
From: Corey Minyard <minyard@acm.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
Cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] I2C patch 2 - break up the SMBus formatting
References: <421E62DD.5030608@acm.org> <20050225214439.GC27270@kroah.com>
In-Reply-To: <20050225214439.GC27270@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:

>On Thu, Feb 24, 2005 at 05:27:25PM -0600, Corey Minyard wrote:
>  
>
>>+
>>+	/* It's wierd, but we use a usecount to track if an q entry is
>>+	   in use and when it should be reported back to the user. */
>>+	atomic_t usecount;
>>    
>>
>
>Please use a kref here instead of rolling your own.
>  
>
There's a trick I'm playing to avoid having to use a lock on the normal 
entry_put() case.  It let's the entry_get() routine detect that the 
object is about to be destroyed.  You can't do it with the current kref, 
but you could easily extend kref to allow it.  It's simple to implement, 
but the documentation on how to use it will be 10 times larger than the 
code :).

I'll work on a patch to kref to add that, if you don't mind.

>Oh, and can you cc: your patches to the sensors mailing list so the
>other i2c developers are aware of them and can comment?  I'll stick with
>just applying your first patch for now.
>  
>
certainly.

thanks

-Corey
