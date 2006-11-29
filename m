Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933832AbWK2FSZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933832AbWK2FSZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 00:18:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933879AbWK2FSZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 00:18:25 -0500
Received: from mis011-1.exch011.intermedia.net ([64.78.21.128]:64624 "EHLO
	mis011-1.exch011.intermedia.net") by vger.kernel.org with ESMTP
	id S933832AbWK2FSY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 00:18:24 -0500
Message-ID: <456D1807.1000603@qumranet.com>
Date: Wed, 29 Nov 2006 07:17:59 +0200
From: Avi Kivity <avi@qumranet.com>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Thomas Tuttle <thinkinginbinary@gmail.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Yaniv Kamay <yaniv@qumranet.com>
Subject: Re: 2.6.19-rc6-mm2
References: <20061128020246.47e481eb.akpm@osdl.org>	<20061129002411.GA1178@lion> <20061128165328.fd17d085.akpm@osdl.org>
In-Reply-To: <20061128165328.fd17d085.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 29 Nov 2006 05:18:23.0787 (UTC) FILETIME=[CACCCFB0:01C71375]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Tue, 28 Nov 2006 19:24:45 -0500
> Thomas Tuttle <thinkinginbinary@gmail.com> wrote:
>
>   
>> I've found a couple of bugs so far...
>>
>> 1. I did `modprobe kvm' and then tried running a version of the KVM Qemu
>> compiled for a different kernel.  My mistake.  But I got an oops:
>>
>> BUG: unable to handle kernel NULL pointer dereference at virtual address 00000008
>> Code: 14 0f 87 77 02 00 00 8b 0c b5 00 15 20 f9 85 c9 0f 84 68 02 00 00 89 ea 89 f8 ff d1 85 c0 0f 84 4c 02 00 00 89 f8 e8 31 e9 ff ff <65> a1 08 00 00 00 8b 40 04 8b 40 08 a8 04 0f 85 ae 02 00 00 e8 
>> EIP: [<f91f9c3f>] kvm_vmx_return+0xef/0x4d0 [kvm] SS:ESP 0068:e5a4fd54
>>
>>     

65 a1 08 00 00 00       mov    %gs:0x8,%eax

kvm isn't restoring gs properly.

I'll look into it.


>> Oh, and I get a ton of these messages with kvm:
>>
>> rtc: lost some interrupts at 1024Hz.
>>     
>
>   

I'll look into these too, though I'm not sure where.


-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.

