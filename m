Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263078AbTJPSyK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 14:54:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263079AbTJPSx6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 14:53:58 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:765 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S263078AbTJPSx4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 14:53:56 -0400
Message-ID: <3F8EE91E.5090202@mvista.com>
Date: Thu, 16 Oct 2003 11:53:18 -0700
From: George Anzinger <george@mvista.com>
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Sanil K <Sanil.K@lntinfotech.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Interrupt handling
References: <OF7678B59D.AD894507-ON65256DC1.0048458F@lntinfotech.com>
In-Reply-To: <OF7678B59D.AD894507-ON65256DC1.0048458F@lntinfotech.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sanil K wrote:
> Hi all,
> 
> This may be a generic problem as far as a driver is concerned.
> 
> We need to handle an interrupt and inform the user space on the event and
> pass the data correspodning to the event.
> 
> The event can be informed through SIGNAL and the signal handler can be
> invoked in the user space. Then again for data, we need to have the
> "copy_to_user" mechanism .
> 
> Is there any other effective mechanism(s) to handle the interrupt. I mean
> we need to convey the event and or data to the user space(prefer -
> asynchronously).
> 
IF the amount of data is small, say a word or two or less, you can use the 
siginfo and a realtime signal.  This will get the data at the same time as the 
signal.  If you prefer to avoid the overhead of the signal, you can do 
sigwaitinfo() which avoids the floating point save/restore, but does require the 
task to wait (i.e. is not asynchronous).




-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

