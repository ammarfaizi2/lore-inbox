Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261662AbULTVv0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261662AbULTVv0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 16:51:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261663AbULTVv0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 16:51:26 -0500
Received: from out008pub.verizon.net ([206.46.170.108]:22008 "EHLO
	out008.verizon.net") by vger.kernel.org with ESMTP id S261662AbULTVvS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 16:51:18 -0500
Message-ID: <41C7496B.4000401@verizon.net>
Date: Mon, 20 Dec 2004 16:51:39 -0500
From: Jim Nelson <james4765@verizon.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: kernel-janitors@lists.osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, akpm@osdl.org
Subject: Re: [PATCH] pcxx: replace cli()/sti() with	spin_lock_irqsave()/spin_unlock_irqrestore()
References: <20041217223426.11143.44338.87156@localhost.localdomain>	 <1103554747.30268.24.camel@localhost.localdomain> <1103574222.31479.12.camel@localhost.localdomain>
In-Reply-To: <1103574222.31479.12.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH at out008.verizon.net from [209.158.220.243] at Mon, 20 Dec 2004 15:51:17 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Llu, 2004-12-20 at 14:59, Alan Cox wrote:
> 
>>On Gwe, 2004-12-17 at 22:34, James Nelson wrote:
>>
>>>-	save_flags(flags);
>>>-	cli();
>>>+	spin_lock_irqsave(&pcxx_lock, flags);
>>> 	del_timer_sync(&pcxx_timer);
>>
>>Not safe if the lock is grabbed by the timer between the lock and the
>>irqsave as it will spin on another cpu and the timer delete will never
>>finish.
> 
> 
> Error between brain and keyboard
> 
> Between the lock and the timer_delete of course
> 

Right.

Go ahead and ignore that set of cli()/sti() patches - I'll have to take them a 
little slower, checking for potential deadlocks and other nastiness.

I'll try again in a week or so - gotta finish "The Design of the Unix Operating 
System" first.  Love early Xmas presents from my aunt, the mainframe systems 
programmer... :)
