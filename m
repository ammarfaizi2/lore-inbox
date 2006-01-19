Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161212AbWASOVV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161212AbWASOVV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 09:21:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161213AbWASOVV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 09:21:21 -0500
Received: from nommos.sslcatacombnetworking.com ([67.18.224.114]:47254 "EHLO
	nommos.sslcatacombnetworking.com") by vger.kernel.org with ESMTP
	id S1161212AbWASOVU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 09:21:20 -0500
In-Reply-To: <1137664156.8471.16.camel@localhost.localdomain>
References: <Pine.LNX.4.44.0601190057130.8484-100000@gate.crashing.org> <1137664156.8471.16.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <0D215BB4-D75D-439C-BB33-4880315C1191@kernel.crashing.org>
Cc: Andrew Morton <akpm@osdl.org>, wim@iguana.be,
       LKML List <linux-kernel@vger.kernel.org>,
       "Linuxppc-Embedded ((E-Mail))" <linuxppc-embedded@ozlabs.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Content-Transfer-Encoding: 7bit
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: remove useless spinlock from mpc83xx watchdog
Date: Thu, 19 Jan 2006 08:21:14 -0600
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
X-Mailer: Apple Mail (2.746.2)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - nommos.sslcatacombnetworking.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - kernel.crashing.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Jan 19, 2006, at 3:49 AM, Alan Cox wrote:

> On Iau, 2006-01-19 at 00:58 -0600, Kumar Gala wrote:
>> Since we can only open the watchdog once having a spinlock to protect
>> multiple access is pointless.
>>
>> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
>
> NAK
>
> This is a common mistake.
>
> open is called on the open() call and is indeed in this case 'single
> open', but file handles can be inherited and many users may have  
> access
> to a single file handle.
>
> eg
>
> 	f = open("/dev/watchdog", O_RDWR);
> 	fork();
> 	while(1) {
> 		write(f, "Boing", 5);
> 	}
>
> Alan

Thanks, you learn something new every day.

- kumar

