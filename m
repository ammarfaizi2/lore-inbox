Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264992AbSKRXEl>; Mon, 18 Nov 2002 18:04:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264940AbSKRXEh>; Mon, 18 Nov 2002 18:04:37 -0500
Received: from packet.digeo.com ([12.110.80.53]:53973 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S264950AbSKRXCs>;
	Mon, 18 Nov 2002 18:02:48 -0500
Message-ID: <3DD97336.40326A65@digeo.com>
Date: Mon, 18 Nov 2002 15:09:42 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.46 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Dave Hansen <haveblue@us.ibm.com>
CC: William Lee Irwin III <wli@holomorphy.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>, linux-kernel@vger.kernel.org,
       mingo@elte.hu, rml@tech9.net, riel@surriel.com,
       Davide Libenzi <davidel@xmailserver.org>
Subject: Re: unusual scheduling performance
References: <20021118081854.GJ23425@holomorphy.com> <705474709.1037608454@[10.10.2.3]> <20021118165316.GK23425@holomorphy.com> <3DD92914.1060301@us.ibm.com> <20021118201748.GL23425@holomorphy.com> <3DD96EE6.1080603@us.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 18 Nov 2002 23:09:42.0359 (UTC) FILETIME=[93C08670:01C28F57]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen wrote:
> 
> As Andrew suggested, I put a dump_stack() in rwsem_down_write_failed().
> 
> This was actually in a 2.5.47 bk snapshot, so it has eventpoll in it.

So printk("hey!\n") would have worked.  Looks like it would have
talked to you, too...

> kksymoops is broken, so:
> dmesg | tail -20 | sort | uniq | ksymoops -m /boot/System.map
> 
> Trace; c01c5757 <rwsem_down_write_failed+27/170>
> Trace; c01220c6 <update_wall_time+16/50>
> Trace; c01223ee <do_timer+2e/c0>
> Trace; c0166bd3 <.text.lock.eventpoll+6/f3>
> Trace; c0146568 <__fput+18/c0>
> Trace; c010ae9a <handle_IRQ_event+2a/60>
> Trace; c0144a05 <filp_close+85/b0>
> Trace; c0144a8d <sys_close+5d/70>
> Trace; c0108fab <syscall_call+7/b>
> 

So it would appear that eventpoll_release() is the problem.
How odd.  You're not actually _using_ epoll there, are you?
