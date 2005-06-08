Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261538AbVFHXgR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261538AbVFHXgR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 19:36:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261567AbVFHXgR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 19:36:17 -0400
Received: from fire.osdl.org ([65.172.181.4]:53378 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261538AbVFHXf4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 19:35:56 -0400
Date: Wed, 8 Jun 2005 16:32:12 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andrew James Wade 
	<ajwade@cpe00095b3131a0-cm0011ae8cd564.cpe.net.cable.rogers.com>
Cc: linux-kernel@vger.kernel.org, khali@linux-fr.org, greg@kroah.com
Subject: Re: BUG in i2c_detach_client
Message-Id: <20050608163212.7c9f9255.akpm@osdl.org>
In-Reply-To: <200506081856.45334.ajwade@cpe00095b3131a0-cm0011ae8cd564.cpe.net.cable.rogers.com>
References: <20050607042931.23f8f8e0.akpm@osdl.org>
	<200506081033.12445.ajwade@cpe00095b3131a0-cm0011ae8cd564.cpe.net.cable.rogers.com>
	<20050608142631.7e956792.akpm@osdl.org>
	<200506081856.45334.ajwade@cpe00095b3131a0-cm0011ae8cd564.cpe.net.cable.rogers.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew James Wade <ajwade@cpe00095b3131a0-cm0011ae8cd564.cpe.net.cable.rogers.com> wrote:
>
> On June 8, 2005 05:26 pm, Andrew Morton wrote:
>  > Were there no interesting printks before this BUG hit?
>  Nope :-(
> 
>  > It's due to the kernel running list_del() on a list_head which isn't on a list.
>  > 
>  > Seems there is an error-path bug in that driver, but I don' thtink the fix
>  > will fix it.  Please test?
>  Will do. But I don't think that's it. I've been adding printks to determine the
>  execution path and it goes through the ERROR3 path in asb100_detect(), which means
>  AFACT that the error path in asb100_detect_subclients() isn't taken:
> 
>  ERROR3:
>          i2c_detach_client(data->lm75[0]);
>          kfree(data->lm75[1]);
>          kfree(data->lm75[0]);
>  ERROR2:
>          i2c_detach_client(new_client); // <--- BUG() in here.
>  ERROR1:
>          kfree(data);
>  ERROR0:
>          return err;

hm, the tree I have here doesn't do that.  What kernel do you have there?

I suggest you work against
http://www.zip.com.au/~akpm/linux/patches/stuff/x.bz2 which is a patch
against 2.6.12-rc6 containing everybody's latest everything.




