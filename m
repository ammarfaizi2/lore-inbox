Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266993AbSKRWqG>; Mon, 18 Nov 2002 17:46:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266995AbSKRWqG>; Mon, 18 Nov 2002 17:46:06 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:31678 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S266993AbSKRWqE>; Mon, 18 Nov 2002 17:46:04 -0500
Message-ID: <3DD96EE6.1080603@us.ibm.com>
Date: Mon, 18 Nov 2002 14:51:18 -0800
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (compatible; MSIE5.5; Windows 98;
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: "Martin J. Bligh" <mbligh@aracnet.com>, linux-kernel@vger.kernel.org,
       mingo@elte.hu, rml@tech9.net, riel@surriel.com, akpm@zip.com.au
Subject: Re: unusual scheduling performance
References: <20021118081854.GJ23425@holomorphy.com> <705474709.1037608454@[10.10.2.3]> <20021118165316.GK23425@holomorphy.com> <3DD92914.1060301@us.ibm.com> <20021118201748.GL23425@holomorphy.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As Andrew suggested, I put a dump_stack() in rwsem_down_write_failed().

This was actually in a 2.5.47 bk snapshot, so it has eventpoll in it.
kksymoops is broken, so:
dmesg | tail -20 | sort | uniq | ksymoops -m /boot/System.map

Trace; c01c5757 <rwsem_down_write_failed+27/170>
Trace; c01220c6 <update_wall_time+16/50>
Trace; c01223ee <do_timer+2e/c0>
Trace; c0166bd3 <.text.lock.eventpoll+6/f3>
Trace; c0146568 <__fput+18/c0>
Trace; c010ae9a <handle_IRQ_event+2a/60>
Trace; c0144a05 <filp_close+85/b0>
Trace; c0144a8d <sys_close+5d/70>
Trace; c0108fab <syscall_call+7/b>

Trace; c01c5757 <rwsem_down_write_failed+27/170>
Trace; c0166bd3 <.text.lock.eventpoll+6/f3>
Trace; c0146568 <__fput+18/c0>
Trace; c011e90b <do_softirq+6b/d0>
Trace; c0144a05 <filp_close+85/b0>
Trace; c0144a8d <sys_close+5d/70>
Trace; c0108fab <syscall_call+7/b>

Trace; c01c5757 <rwsem_down_write_failed+27/170>
Trace; c0166bd3 <.text.lock.eventpoll+6/f3>
Trace; c0146568 <__fput+18/c0>
Trace; c0144c2d <generic_file_llseek+2d/e0>
Trace; c0144a05 <filp_close+85/b0>
Trace; c0144a8d <sys_close+5d/70>
Trace; c0108fab <syscall_call+7/b>

Trace; c01c5757 <rwsem_down_write_failed+27/170>
Trace; c0166bd3 <.text.lock.eventpoll+6/f3>
Trace; c0146568 <__fput+18/c0>
Trace; c01553fa <sys_getdents64+4a/98>
Trace; c0144a05 <filp_close+85/b0>
Trace; c0144a8d <sys_close+5d/70>
Trace; c0108fab <syscall_call+7/b>

Mystery solved?

-- 
Dave Hansen
haveblue@us.ibm.com

