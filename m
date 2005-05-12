Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262181AbVELXg1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262181AbVELXg1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 May 2005 19:36:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262182AbVELXg1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 May 2005 19:36:27 -0400
Received: from zproxy.gmail.com ([64.233.162.199]:42596 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262181AbVELXgX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 May 2005 19:36:23 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=damyzKSLbgy5LHME0uPsCziYj/0CvlWjXinczB694vfxZTd1E/LEkMLi2IaH3xeBuz13a0vj4MaLsst4F+Z/+/TnB11a9jcLSmRQBOSOzi96IsVZ0+P9GSfVn+t+8UoNugTzBuk98u3VB82oXFCwJWdjV41FFpkpl2WSPAtiKok=
Message-ID: <5fc59ff305051216367e3054cd@mail.gmail.com>
Date: Thu, 12 May 2005 16:36:23 -0700
From: Ganesh Venkatesan <ganesh.venkatesan@gmail.com>
Reply-To: Ganesh Venkatesan <ganesh.venkatesan@gmail.com>
To: Oleg Nesterov <oleg@tv-sign.ru>
Subject: Re: [RFC][PATCH] timers fixes/improvements
Cc: "David S.Miller" <davem@davemloft.net>, christoph@lameter.com,
       akpm@osdl.org, linux-kernel@vger.kernel.org,
       "Venkatesan, Ganesh" <ganesh.venkatesan@intel.com>
In-Reply-To: <42821F65.3FEA7939@tv-sign.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <Pine.LNX.4.58.0505091449580.29090@graphe.net>
	 <42808B84.BCC00574@tv-sign.ru>
	 <Pine.LNX.4.58.0505101212350.20718@graphe.net>
	 <20050510.125301.59655362.davem@davemloft.net>
	 <42821F65.3FEA7939@tv-sign.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Linville, who originally proposed the patch (to add
e1000_watchdog_task and related code) has since withdrawn the patch.

e1000_down may still be suffering from the del_timer_sync race
condition that Oleg identified at the start of this thread.

ganesh.

On 5/11/05, Oleg Nesterov <oleg@tv-sign.ru> wrote:
> Btw, i think that drivers/net/e1000/e1000_main.c:e1000_down() is buggy.
> 
> It calls del_timer_sync(&adapter->watchdog_timer), but e1000_watchdog()
> calls schedule_work(e1000_watchdog_task), so the work could be queued
> after del_timer_sync().
> 
> And e1000_watchdog_task() arms timers again.
> 
> Note that it's not enough to do flush_scheduled_work() here.
> 
> Oleg.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
