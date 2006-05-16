Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753115AbWEPTGs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753115AbWEPTGs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 15:06:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752278AbWEPTGs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 15:06:48 -0400
Received: from terminus.zytor.com ([192.83.249.54]:2690 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1753108AbWEPTGr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 15:06:47 -0400
Message-ID: <446A2243.6050109@zytor.com>
Date: Tue, 16 May 2006 12:04:35 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: Jim Cromie <jim.cromie@gmail.com>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.17-rc4-mm1 nfsroot build err, looks related to klibc
References: <44692CA1.5000903@gmail.com> <446950E3.4060601@zytor.com> <20060516101838.GK6931@stusta.de>
In-Reply-To: <20060516101838.GK6931@stusta.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> On Mon, May 15, 2006 at 09:11:15PM -0700, H. Peter Anvin wrote:
>> Jim Cromie wrote:
>>> Im getting nfsroot build error on 2 configs, both carried forward
>> >from good rc4 and from rc3-mm1 builds.
>>> turning off nfsroot fixes the err.
>>>
>> Could you throw me your configs, so I can try to reproduce it here?
> 
> The problem is:
> 
> CONFIG_IP_PNP=y
> CONFIG_NFS_FS=y
> CONFIG_ROOT_NFS=y
> 
> A (compile-only) .config exhibiting this error is attached.
> 

Yeah, OK, problem recovered; total thinko on my part -- I forgot to remove the in-kernel 
nfsroot code.  Just setting CONFIG_ROOT_NFS=n will work just fine; right now kinit doesn't 
depend on the configuration (another buglet for my list), so if you set CONFIG_ROOT_NFS=n 
the kernel will compile *and* nfsroot should still work.

	-hpa
