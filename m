Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262366AbUKKW6v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262366AbUKKW6v (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 17:58:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262404AbUKKW5r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 17:57:47 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:5770 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262417AbUKKWvU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 17:51:20 -0500
Message-ID: <4193ECDA.4000903@pobox.com>
Date: Thu, 11 Nov 2004 17:51:06 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
CC: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [patch 4/10] s390: network driver.
References: <20041111171602.GF4900@mschwid3.boeblingen.de.ibm.com>
In-Reply-To: <20041111171602.GF4900@mschwid3.boeblingen.de.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Schwidefsky wrote:
> [patch 4/10] s390: network driver.
> 
> From: Thomas Spatzier <tspat@de.ibm.com>
> From: Peter Tiedemann <ptiedem@de.ibm.com>
> 
> network driver changes:
>  - qeth: return -EINVAL if an skb is too large.
>  - qeth: don't call netif_stop_queue after cable pull. Drop the
>    packets instead.


You should be using netif_carrier_{on,off} properly, and not drop the 
packets.  When (if) link comes back, you requeue the packets to hardware 
(or hypervisor or whatever).  Your dev->stop() should stop operation and 
clean up anything left in your send/receive {rings | buffers}.

	Jeff


