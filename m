Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932491AbWAFWqW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932491AbWAFWqW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 17:46:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932498AbWAFWqW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 17:46:22 -0500
Received: from mf01.sitadelle.com ([212.94.174.68]:15726 "EHLO
	smtp.cegetel.net") by vger.kernel.org with ESMTP id S932491AbWAFWqV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 17:46:21 -0500
Message-ID: <43BEF338.3010403@cosmosbay.com>
Date: Fri, 06 Jan 2006 23:46:16 +0100
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [patch 0/4] Series to allow a "const" file_operations struct
References: <1136583937.2940.90.camel@laptopd505.fenrus.org> <1136584539.2940.105.camel@laptopd505.fenrus.org>
In-Reply-To: <1136584539.2940.105.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven a écrit :
> On Fri, 2006-01-06 at 22:45 +0100, Arjan van de Ven wrote:
>> Hi,
>>
>> this series allows drivers to have "const" file_operations, by making
>> the f_ops field in the inode const. This has another benefit, there have
> 
> ok there was a sentence missing here. The first benefit is that this
> moves these hot datastructures to the rodata section, which means they
> won't accidentally be doing false cacheline sharing.
> 

Definitly a good thing I agree.

But your patches miss to really declare all 'struct file_operations' as const, 
dont they ?


On my x86_64 machine, I managed to reduce by 10% .data section by moving all 
file_operations, but also 'address_space_operations', 'inode_operations, 
super_operations, dentry_operations, seq_operations, ... to rodata section.

size vmlinux*
    text    data     bss     dec     hex filename
2476156  522236  244868 3243260  317cfc vmlinux
2588685  571348  246692 3406725  33fb85 vmlinux.old

Eric

