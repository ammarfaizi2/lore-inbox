Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932261AbWF0GzX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932261AbWF0GzX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 02:55:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932532AbWF0GzX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 02:55:23 -0400
Received: from mx0.towertech.it ([213.215.222.73]:38120 "HELO mx0.towertech.it")
	by vger.kernel.org with SMTP id S932261AbWF0GzX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 02:55:23 -0400
Date: Tue, 27 Jun 2006 08:55:18 +0200
From: Alessandro Zummo <alessandro.zummo@towertech.it>
To: Sonny Rao <sonny@burdell.org>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] fix idr locking in rtc class
Message-ID: <20060627085518.787bb831@inspiron>
In-Reply-To: <20060627001951.GA24726@kevlar.burdell.org>
References: <20060627001951.GA24726@kevlar.burdell.org>
Organization: Tower Technologies
X-Mailer: Sylpheed
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Jun 2006 20:19:51 -0400
Sonny Rao <sonny@burdell.org> wrote:

 thanks for spotting this.
 Signed-off-by: Alessandro Zummo <a.zummo@towertech.it>

> We need to serialize access to the global rtc_idr even in this error path.
> 
> Signed-off-by: Sonny Rao <sonny@burdell.org>
> 
> --- linux-2.6.17/drivers/rtc/class.c~orig	2006-06-26 19:10:44.738511816 -0500
> +++ linux-2.6.17/drivers/rtc/class.c	2006-06-26 19:12:22.008724496 -0500
> @@ -93,7 +93,9 @@ exit_kfree:
>  	kfree(rtc);
>  
>  exit_idr:
> +	mutex_lock(&idr_lock);
>  	idr_remove(&rtc_idr, id);
> +	mutex_unlock(&idr_lock);
>  
>  exit:
>  	dev_err(dev, "rtc core: unable to register %s, err = %d\n",


-- 

 Best regards,

 Alessandro Zummo,
  Tower Technologies - Turin, Italy

  http://www.towertech.it

