Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751294AbVKIIhH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751294AbVKIIhH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 03:37:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751315AbVKIIhH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 03:37:07 -0500
Received: from gateway.argo.co.il ([194.90.79.130]:6667 "EHLO
	argo2k.argo.co.il") by vger.kernel.org with ESMTP id S1751294AbVKIIhF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 03:37:05 -0500
Message-ID: <4371B52E.4030004@argo.co.il>
Date: Wed, 09 Nov 2005 10:37:02 +0200
From: Avi Kivity <avi@argo.co.il>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Oliver Neukum <neukum@fachschaft.cup.uni-muenchen.de>
CC: Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@suse.de>
Subject: Re: userspace block driver?
References: <4371A4ED.9020800@pobox.com> <Pine.LNX.4.58.0511090852440.22793@fachschaft.cup.uni-muenchen.de>
In-Reply-To: <Pine.LNX.4.58.0511090852440.22793@fachschaft.cup.uni-muenchen.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 09 Nov 2005 08:37:03.0863 (UTC) FILETIME=[C2AE5070:01C5E508]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oliver Neukum wrote:

>On Wed, 9 Nov 2005, Jeff Garzik wrote:
>
>  
>
>>Has anybody put any thought towards how a userspace block driver would work?
>>
>>Consider a block device implemented via an SSL network connection.  I don't
>>want to put SSL in the kernel, which means the only other alternative is to
>>pass data to/from a userspace daemon.
>>    
>>
>
>I am afraid this is impossible without some heavy infrastructure work.
>You will almost inevitably deadlock. Yes, you can mlock() your driver, but 
>that still will not tell the kernel that GFP_KERNEL must be replaced with 
>GFP_NOIO if it is triggered by syscalls you are doing.
>
>  
>
A simple patch can help here (in addition to mlockall()):

  http://www.ussg.iu.edu/hypermail/linux/kernel/0407.3/0297.html

you might want to increase the free memory target as well.
