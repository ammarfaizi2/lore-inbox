Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283531AbRLDVyK>; Tue, 4 Dec 2001 16:54:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283532AbRLDVyA>; Tue, 4 Dec 2001 16:54:00 -0500
Received: from odin.allegientsystems.com ([208.251.178.227]:25984 "EHLO
	lasn-001.allegientsystems.com") by vger.kernel.org with ESMTP
	id <S283531AbRLDVxn>; Tue, 4 Dec 2001 16:53:43 -0500
Message-ID: <3C0D45E6.6070500@optonline.net>
Date: Tue, 04 Dec 2001 16:53:42 -0500
From: Nathan Bryant <nbryant@optonline.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5) Gecko/20011012
X-Accept-Language: en-us
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Doug Ledford <dledford@redhat.com>, Mario Mikocevic <mozgy@hinet.hr>
Subject: Re: i810 audio patch
In-Reply-To: <3C0C16E7.70206@optonline.net> <3C0C508C.40407@redhat.com> <3C0C58DE.9020703@optonline.net> <3C0C5CB2.6000602@optonline.net> <3C0C61CC.1060703@redhat.com> <20011204153507.A842@danielle.hinet.hr> <3C0D1DD2.4040609@optonline.net> <3C0D223E.3020904@redhat.com> <3C0D350F.9010408@optonline.net> <3C0D3CF7.6030805@redhat.com> <3C0D428F.307@optonline.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ok, i'm learning here ;)

it seems i guessed wrong, and schedule() wakes up on a wait queue which 
has been added by poll_wait; poll_wait doesn't actually do any sleeping 
so no loop is necessary in i810_poll; it will be called again by do_poll 
or do_select after the call to schedule. so no latency and no problem.

right?

Nathan Bryant wrote:

> fs/select.c:do_poll() calls schedule_timeout() after all do_pollfd's 
> have returned empty sets and there is still time remaining. so if you 
> just eliminate the loop in i810_poll, it will loop back and if there's 
> data available, poll(2) would return properly, but with extra latency. 
> i assume sys_select behaves the same way...
>
> so, 2 choices to eliminate latency, either hack i810_poll further, or 
> be a lot more intelligent about calling wake_up. am i wrong?
>



