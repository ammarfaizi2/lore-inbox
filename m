Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751240AbWGLKd4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751240AbWGLKd4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 06:33:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751245AbWGLKd4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 06:33:56 -0400
Received: from nz-out-0102.google.com ([64.233.162.207]:41208 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751240AbWGLKdz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 06:33:55 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qyGtNaO3ZHCdG83zZuWyXWAOneOdVO1jHb/s3h1QR5Mcbsd2I1IqtzK12SzOBJSA611/WWLof+vPP/1eOmCG28+WCiKF26rTNrX7R+KMTej3K+eCBJfXON8g8+wTF285nCb7AC8/lKS2ojA1Mj+f+C5gjoyv7XluLQ8Yn3vlkNE=
Message-ID: <b0943d9e0607120333q7960077veef91d63d826003b@mail.gmail.com>
Date: Wed, 12 Jul 2006 11:33:54 +0100
From: "Catalin Marinas" <catalin.marinas@gmail.com>
To: "Catherine Zhang" <cxzhang@watson.ibm.com>
Subject: Re: [PATCH 00/10] Kernel memory leak detector 0.8
Cc: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <6bffcb0e0607110802w4f423854rb340227331084596@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060710220901.5191.66488.stgit@localhost.localdomain>
	 <6bffcb0e0607110527x4520d5bbne8b9b3639a821a18@mail.gmail.com>
	 <b0943d9e0607110556v50185b9i5443dabedba46152@mail.gmail.com>
	 <6bffcb0e0607110617g36f7123dm2b5f0e88b10cbcaa@mail.gmail.com>
	 <b0943d9e0607110628w60a436f7t449714eb4a3200ca@mail.gmail.com>
	 <6bffcb0e0607110649s464840a9sf04c7537809436b1@mail.gmail.com>
	 <b0943d9e0607110702p60f5bf3fg910304bfe06ec168@mail.gmail.com>
	 <6bffcb0e0607110802w4f423854rb340227331084596@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Catherine,

On 11/07/06, Michal Piotrowski <michal.k.k.piotrowski@gmail.com> wrote:
> This is most common
> orphan pointer 0xf5a6fd60 (size 39):
>   c0173822: <__kmalloc>
>   c01df500: <context_struct_to_string>
>   c01df679: <security_sid_to_context>
>   c01d7eee: <selinux_socket_getpeersec_dgram>
>   f884f019: <unix_get_peersec_dgram>
>   f8850698: <unix_dgram_sendmsg>
>   c02a88c2: <sock_sendmsg>
>   c02a9c7a: <sys_sendto>
>
> cat /tmp/ml.txt | grep -c selinux_socket_getpeersec_dgram
> 8442

I'm looking into the above leak report from kmemleak (the back trace
to the kmalloc function). The "datagram getpeersec" patch went in as
commit 877ce7c1b3afd69a9b1caeb1b9964c992641f52a. Have you noticed any
abnormal increase in the slab statistics (especially size-64)?

Thanks.

-- 
Catalin
