Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264206AbUEDCyj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264206AbUEDCyj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 May 2004 22:54:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264210AbUEDCyj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 May 2004 22:54:39 -0400
Received: from gate.crashing.org ([63.228.1.57]:34726 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S264206AbUEDCyh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 May 2004 22:54:37 -0400
Subject: Re: workqueue and pending
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Mikkel Christiansen <mixxel@cs.auc.dk>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20040503162719.54fb7020.akpm@osdl.org>
References: <40962F75.8000200@cs.auc.dk>
	 <20040503162719.54fb7020.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1083639081.20092.294.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 04 May 2004 12:51:21 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>  
> @@ -75,8 +76,11 @@ extern void init_workqueues(void);
>   */
>  static inline int cancel_delayed_work(struct work_struct *work)
>  {
> -	return del_timer_sync(&work->timer);
> +	int ret;
> +
> +	ret = del_timer_sync(&work->timer);
> +	clear_bit(0, &work->pending);
> +	return ret;
>  }
>  

Looks wrong to me. The time may have fired already and queued the
work. Clearing pending is an error in this case since the work is
indeed pending for execution.... 

Ben.


