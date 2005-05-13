Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262416AbVEMQHM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262416AbVEMQHM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 12:07:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262419AbVEMQHL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 12:07:11 -0400
Received: from dgate1.fujitsu-siemens.com ([217.115.66.35]:55195 "EHLO
	dgate1.fujitsu-siemens.com") by vger.kernel.org with ESMTP
	id S262415AbVEMQG6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 12:06:58 -0400
X-SBRSScore: None
X-IronPort-AV: i="3.93,107,1114984800"; 
   d="scan'208"; a="9296951:sNHT29356740"
Message-ID: <4284D0A0.5010809@fujitsu-siemens.com>
Date: Fri, 13 May 2005 18:06:56 +0200
From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
CC: linux-kernel@vger.kernel.org, Ulrich Weigand <uweigand@de.ibm.com>
Subject: Re: Again: UML on s390 (31Bit)
References: <OF004E24A7.29043C55-ONC1257000.0056CCB5-C1257000.00570853@de.ibm.com>
In-Reply-To: <OF004E24A7.29043C55-ONC1257000.0056CCB5-C1257000.00570853@de.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Schwidefsky wrote:
>>Each time when the kernel is entered again and a signal is pending,
>>do_signal() will be called on return to user with regs->trap setup
>>freshly. So, I still believe the patch doesn't have *any* effect.
> 
> 
> Oh, the patch does have an effect for the debugger. If the debugger
> stopped on the sys_sig_return system call and does e.g. an inferior
> function call, then the kernel might want to restart a system call
> that isn't there because the debugger did a "jump" but could not
> change regs->trap.

AFAICS, it not even has an effect for the debugger.

do_signal() is the only routine, that examines regs->trap. On each
kernel-entry, regs->trap is set freshly. What will be the effect of
changing it *after* it had been examined?

The only exceptions are sys_(rt_)sigsuspend. Here do_signal() might
be called twice, while *and* after processing the syscall. But even
here the patch has no effect, as regs->gprs[2] contains -EINTR, if
so_signal is called by sys_(rt_)sigreturn.

Regards
	Bodo

> 
> blue skies,
>    Martin
> 
> Martin Schwidefsky
> Linux for zSeries Development & Services
> IBM Deutschland Entwicklung GmbH
> 
