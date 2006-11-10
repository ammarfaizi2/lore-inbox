Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424377AbWKJHaZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424377AbWKJHaZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 02:30:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424287AbWKJHaZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 02:30:25 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:59177 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1424377AbWKJHaY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 02:30:24 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fJiMztAgdBukU3JWKiY1JyDGiHbxSwr2/e4py6u7qVvUoJOBQo9BywoduqmdfW1ykzsrPfqYNVCK9XQCjlDCKXiv3vX8gnaypqzZwBMMqpvAoqXE+wfVIS7kbP+ausM53sR4jHNxrgaOdymMRGBVAphX/QBr65Fg8+bDbExLxuo=
Message-ID: <2ea3fae10611092330q551127e0oad87775964fe7251@mail.gmail.com>
Date: Thu, 9 Nov 2006 23:30:22 -0800
From: yhlu <yinghailu@gmail.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [Fastboot] Kexec with latest kernel fail
Cc: Horms <horms@verge.net.au>,
       "Fastboot mailing list" <fastboot@lists.osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <m164dnnaac.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <5986589C150B2F49A46483AC44C7BCA49071D3@ssvlexmb2.amd.com>
	 <m164dnnaac.fsf@ebiederm.dsl.xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I found the cause before your mail.

the /proc/iomem doesn't show RAM above 1M.

I have increased linuxbios table at high 0xf0000-0xf0400 to
0xf0000-0x100000. the RAM above 1M show up.

I think root cause in the latest kernel 2.6.19, e820 align increase to 0xffff.
and when it check 0xf0000-0xf0400, will make 0xf0000-0x100000
reserved, and then when it  check 0xf0400-4G, it will fail to reserved
System RAM above 1M.

I will check arch/x86_64/kernel/e820.c about
void __init e820_reserve_resources(void)
tommorrow.

YH
