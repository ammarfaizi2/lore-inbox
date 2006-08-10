Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030374AbWHJBLJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030374AbWHJBLJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 21:11:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030520AbWHJBLJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 21:11:09 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:8571 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1030374AbWHJBLI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 21:11:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ExLunXB0wcl10VrCsefrwnPjbYGaEfUuWto2dscCfNFwiBQumRbDkdTMd/wQ7v9aSqYgdzVvFJwkPvf2S5nYNh0dmPVRSRkMUMhDRQp7bJBwz4HvtNUM6lkyzHZC/yaXXehYT+MX4pRsIDp0R6n3sYn+ld9iRfwTVhmSGl63Yxk=
Message-ID: <82faac5b0608091811v1217ac44i3e48006e4d1eed44@mail.gmail.com>
Date: Thu, 10 Aug 2006 11:11:06 +1000
From: "Darren Jenkins" <darrenrjenkins@gmail.com>
To: ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com
Subject: Re: [KJ] [patch] fix common mistake in polling loops
Cc: "Om N." <xhandle@gmail.com>, kernel-janitors@osdl.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <200608092025.02259.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <710c0ee0607280128g2d968c49ycff3bac9e073e7fa@mail.gmail.com>
	 <82faac5b0608071753q71050d72uadcf55bc1e54f30e@mail.gmail.com>
	 <6de39a910608071953l39ce0873w713d59eda4aa5d84@mail.gmail.com>
	 <200608092025.02259.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

G'day,

On 8/10/06, Andrew James Wade <andrew.j.wade@gmail.com> wrote:
> You're getting duplicated code there. That'll be an issue in more
> complex loops. How about:
>
> unsigned long timeout = jiffies + HZ/2;
> int timeup = 0;
>
> for (;;;) {
>         if (ready())
>                 return 0;
>         if (timeup)
>                 break;
>         msleep(10);
>         timeup = time_after(timeout, jiffies);
> };
> ... timeout ...
>

Nice, looks better than my idea.
Removes the code duplication and reduces complexity(a little) at the
cost of an extra variable.

The only Nitpick is

- int timeup = 0;
+ unsigned char timeup = 0;


>
> Andrew Wade

Darren J.
