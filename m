Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992563AbWJTHmq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992563AbWJTHmq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 03:42:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992574AbWJTHmq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 03:42:46 -0400
Received: from mis011-1.exch011.intermedia.net ([64.78.21.128]:43231 "EHLO
	mis011-1.exch011.intermedia.net") by vger.kernel.org with ESMTP
	id S2992563AbWJTHmp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 03:42:45 -0400
Message-ID: <45387DEF.9060903@qumranet.com>
Date: Fri, 20 Oct 2006 09:42:39 +0200
From: Avi Kivity <avi@qumranet.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20061008)
MIME-Version: 1.0
To: Anthony Liguori <aliguori@us.ibm.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/7] KVM: userspace interface
References: <4537818D.4060204@qumranet.com> <453781F9.3050703@qumranet.com> <4537C807.4@us.ibm.com> <4537CC24.2070708@qumranet.com> <4537CD54.8020006@us.ibm.com> <4537D174.8090204@qumranet.com> <4537D298.6010105@us.ibm.com>
In-Reply-To: <4537D298.6010105@us.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 20 Oct 2006 07:42:44.0890 (UTC) FILETIME=[54B23FA0:01C6F41B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anthony Liguori wrote:
>>
>>  writel(dst_x_reg, x);
>>  writel(dst_y_reg, y)
>>  writel(width_reg, w);
>>  writel(height_reg, h);
>>  writel(blt_cmd_reg, fill);
>>
>> then kvm would cache the first four in a mmap()able memory area and 
>> only exit to userspace on the fifth.  Userspace would then read the 
>> cached registers from memory and emulate the command.
>
> Letting QEMU do a certain amount of emulation after every transition 
> would the problem in a more elegant and generic way.
>

But what amount?  A basic block, or several?

Emulation has its costs.  You need to marshal the registers to and fro.  
You need to reset qemu's cached translations.  You need to throw away 
shadow page tables and qemu's softmmu.  You increase the time spent in 
single threaded code.

-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.

