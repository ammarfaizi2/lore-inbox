Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751254AbWAPW67@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751254AbWAPW67 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 17:58:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751255AbWAPW67
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 17:58:59 -0500
Received: from S01060080c85517f6.wp.shawcable.net ([24.79.196.167]:9141 "EHLO
	ubb.ca") by vger.kernel.org with ESMTP id S1751254AbWAPW67 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 17:58:59 -0500
Mime-Version: 1.0 (Apple Message framework v746.2)
In-Reply-To: <6951EFDF-9499-40D5-AD09-2AE217A0A579@ubb.ca>
References: <6951EFDF-9499-40D5-AD09-2AE217A0A579@ubb.ca>
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <59A5E944-6499-47D4-B875-C0DE75E27701@ubb.ca>
Content-Transfer-Encoding: 7bit
From: Tony Mantler <nicoya@ubb.ca>
Subject: Re: CONFIG_MK6 = lsof hangs unkillable
Date: Mon, 16 Jan 2006 16:58:55 -0600
To: linux-kernel@vger.kernel.org
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 15-Jan-06, at 10:43 PM, Tony Mantler wrote:

> I'm having trouble running lsof on 2.6.15.1 when the kernel is  
> compiled with CONFIG_MK6. When run as root, lsof will segfault, and  
> when run as a user lsof will hang unkillable.
>
> The same kernel, same machine, but compiled with CONFIG_MK7 runs  
> just lsof just fine.

To follow up on this, it appears that things are getting stuck while  
reading /proc/*/maps, specifically it hangs in fs/proc/task_mmu.c in  
m_start() at down_read(&mm->mmap_sem). The same thing happens when  
trying to readlink /proc/*/exe.

I'm really not sure why this lock is getting stuck. Can anyone  
reproduce this?

--
Tony 'Nicoya' Mantler -- Master of Code-fu -- nicoya@ubb.ca
--  http://nicoya.feline.pp.se/  --  http://www.ubb.ca/  --

