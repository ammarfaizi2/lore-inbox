Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932366AbWDBREq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932366AbWDBREq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Apr 2006 13:04:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932374AbWDBREq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Apr 2006 13:04:46 -0400
Received: from morbo.e-centre.net ([66.154.82.3]:48875 "EHLO
	cubert.e-centre.net") by vger.kernel.org with ESMTP id S932366AbWDBREp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Apr 2006 13:04:45 -0400
X-ASG-Debug-ID: 1143997483-29827-29-0
X-Barracuda-URL: http://10.3.1.19:8000/cgi-bin/mark.cgi
X-ASG-Orig-Subj: Re: [PATCH] hwmon: Semaphore to mutex conversions
Subject: Re: [PATCH] hwmon: Semaphore to mutex conversions
From: Arjan van de Ven <lkml@fenrus.demon.nl>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: mingo@elte.hu, khali@linux-fr.org, gregkh@suse.de
In-Reply-To: <200603240011.k2O0BBTw007372@hera.kernel.org>
References: <200603240011.k2O0BBTw007372@hera.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sun, 02 Apr 2006 19:04:31 +0200
Message-Id: <1143997471.3066.6.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=4.0 tests=
X-Barracuda-Spam-Report: Code version 3.02, rules version 3.0.10386
	Rule breakdown below pts rule name              description
	---- ---------------------- --------------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> @@ -325,7 +326,7 @@ static void hdaps_mousedev_poll(unsigned
>  	int x, y;
>  
>  	/* Cannot sleep.  Try nonblockingly.  If we fail, try again later. */
> -	if (down_trylock(&hdaps_sem)) {
> +	if (!mutex_trylock(&hdaps_mutex)) {
>  		mod_timer(&hdaps_timer,jiffies + HDAPS_POLL_PERIOD);
>  		return;
>  	}
> @@ -340,7 +341,7 @@ static void hdaps_mousedev_poll(unsigned
>  	mod_timer(&hdaps_timer, jiffies + HDAPS_POLL_PERIOD);
>  
>  out:
> -	up(&hdaps_sem);
> +	mutex_unlock(&hdaps_mutex);
>  }
>  


this isn't right; this is run in irq context!
