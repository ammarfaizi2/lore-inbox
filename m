Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261939AbVD0Scc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261939AbVD0Scc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 14:32:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261937AbVD0Scc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 14:32:32 -0400
Received: from alog0561.analogic.com ([208.224.223.98]:21416 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261935AbVD0SaU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 14:30:20 -0400
Date: Wed, 27 Apr 2005 14:29:28 -0400 (EDT)
From: "Richard B. Johnson" <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: coywolf@lovecn.org
cc: Chris Friesen <cfriesen@nortel.com>, linux-kernel@vger.kernel.org
Subject: Re: any way to find out kernel memory usage?
In-Reply-To: <2cd57c90050427110717b6e841@mail.gmail.com>
Message-ID: <Pine.LNX.4.61.0504271419090.22842@chaos.analogic.com>
References: <426FBFED.9090409@nortel.com> <2cd57c90050427110717b6e841@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Apr 2005, Coywolf Qi Hunt wrote:

> On 4/28/05, Chris Friesen <cfriesen@nortel.com> wrote:
>>
>> We recently had an issue with a kernel module leaking memory on unload,
>> and a userspace app that unloaded it way too many times.
>>
>> This ended up using up a bunch of memory, which triggered the oom-killer
>> to run, which went wild killing everything in sight since userspace
>> wasn't actually the culprt.
>>
>> One idea we had to prevent this in the future is to configure the OOM
>> killer to reset the system if the kernel uses more than a certain amount
>> of memory.  (Reset is better than hang for our purposes.) Is there any
>
> Curiously, how to reset? Reboot? (Teach oom killer to kill) or restart
> the related
> kernel thread?
>

In user-mode code... `man 2 reboot` tells all.
Quickest way in kernel mode on ix86 is a processor reset.

>
>> way to find out how much memory the kernel is using?  I don't see
>> anything in /proc, but maybe something internal that isn't currently
>> exported?
>>
>> Chris
>

In the kernel nr_free_pages() <swap.h> gives you a hint of what's left,
num_physpages() tells you what RAM you started with.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.11 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
