Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264066AbRFKWr6>; Mon, 11 Jun 2001 18:47:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264072AbRFKWrs>; Mon, 11 Jun 2001 18:47:48 -0400
Received: from mailgw.prontomail.com ([216.163.180.10]:45446 "EHLO
	c0mailgw02.prontomail.com") by vger.kernel.org with ESMTP
	id <S264066AbRFKWrn>; Mon, 11 Jun 2001 18:47:43 -0400
Message-ID: <3B254A0E.F08CDB6E@mvista.com>
Date: Mon, 11 Jun 2001 15:45:34 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jaswinder Singh <jaswinder.singh@3disystems.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Task Switching in Linux
In-Reply-To: <011701c0f2b5$4d2d7140$50a6b3d0@Toshiba>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jaswinder Singh wrote:
> 
> In Linux , If we assume that there are only 2 tasks A and B and both are
> equal , this is correct or not :-
> 
> TASK A -> schedule -> switch_to -> TASK B -> schedule -> switch_to ->
> schedule -> switch_to -> TASK A.
> 
Heck no.  TASK A will be run until it either blocks or its time quantum
drops below TASK B's.  It does not matter how many times it calls
schedule(), 'cept its a darn waste of time.

Now, it you call sched_yield() your chances are higher, but still no
guarantee.  If you get the tasks out of SCHED_OTHER sched_yield() will
do the above (if they have the same priority).

George
