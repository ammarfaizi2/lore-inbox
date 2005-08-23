Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932476AbVHWW43@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932476AbVHWW43 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 18:56:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932484AbVHWW43
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 18:56:29 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:53487 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S932475AbVHWW41
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 18:56:27 -0400
Message-ID: <430BA990.9090807@mvista.com>
Date: Tue, 23 Aug 2005 15:56:16 -0700
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050323 Fedora/1.7.6-1.3.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jim Ramsay <jim.ramsay@gmail.com>
CC: Linux-ide <linux-ide@vger.kernel.org>,
       Lukasz Kosewski <lkosewsk@gmail.com>, Jeff Garzik <jgarzik@pobox.com>,
       linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] Add disk hotswap support to libata RESEND #2
References: <355e5e5e05080103021a8239df@mail.gmail.com>	 <4789af9e050823124140eb924f@mail.gmail.com> <4789af9e050823154364c8e9eb@mail.gmail.com>
In-Reply-To: <4789af9e050823154364c8e9eb@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jim Ramsay wrote:
> On 8/23/05, Jim Ramsay <jim.ramsay@gmail.com> wrote:
> 
>>Then I must have found an undocumented feature!  I've applied this set
>>of patches to a 2.6.11 kernel (with few problems) and ran into a bunch
>>of "scheduling while atomic" errors when hotplugging a drive, culprit
>>being probably scsi_sysfs.c where scsi_remove_device locks a mutex, or
>>perhaps when it then calls class_device_unregister, which does a
>>'down_write'.
> 
> 
> After further debugging, it appears that the problem is the debounce
> timer in libata-core.c.
> 
> Timers appear to operate in an atomic context, so timers should not be
> allowed to call scsi_remove_device, which eventually schedules.
> 
> Any suggestions on the best way to fix this?

Workqueue, perhaps.
> 

-- 
George Anzinger   george@mvista.com
HRT (High-res-timers):  http://sourceforge.net/projects/high-res-timers/
