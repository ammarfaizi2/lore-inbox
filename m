Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269049AbUJKREc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269049AbUJKREc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 13:04:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269065AbUJKRDh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 13:03:37 -0400
Received: from dbl.q-ag.de ([213.172.117.3]:22669 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S269093AbUJKQ7n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 12:59:43 -0400
Message-ID: <416ABBED.8020100@colorfullife.com>
Date: Mon, 11 Oct 2004 18:59:25 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Brian Lazara <blazara@nvidia.com>
CC: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.28-pre4
References: <20041008112135.GG16028@logos.cnet> <1097512373.6780.4.camel@localhost.localdomain>
In-Reply-To: <1097512373.6780.4.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brian Lazara wrote:

>At some point, can we get forcedeth.c updated in 2.4.x? We've taken the
>latest from 2.6.8
>
The driver in 2.6.8 contains a critical bug that prevents the operation 
on the non-GB board with a modularized driver.
See
https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=128292

It's now fixed, I've written a backport of the 0.29 driver, it's at

http://marc.theaimsgroup.com/?l=linux-kernel&m=109439014812433&w=2

But that backport was stopped due to an oddity in your original backport:

>From http://www.uwsg.indiana.edu/hypermail/linux/kernel/0408.1/1523.html:

> #define PCI_DEVICE_ID_NVIDIA_NFORCE3 0x00d1
> #define PCI_DEVICE_ID_NVIDIA_NFORCE3_IDE 0x00d5
> +#define PCI_DEVICE_ID_NVIDIA_NVENET_3 0x00d5
> #define PCI_DEVICE_ID_NVIDIA_MCP3_AUDIO 0x00da


NVENET_3 can't have the id 0x00d5. I've asked Jane Liu a month ago to 
double check the values and I'm still waiting for a reply.

For me, that's the only open point that prevents merging. What I'm 
missing is a positive test report from a non-GB board, but that's not 
mandatory - IMHO the code receives enough testing in 2.6.

--
    Manfred
