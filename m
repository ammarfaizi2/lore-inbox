Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129101AbRA2UDb>; Mon, 29 Jan 2001 15:03:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129274AbRA2UDV>; Mon, 29 Jan 2001 15:03:21 -0500
Received: from baldur.fh-brandenburg.de ([195.37.0.5]:50376 "HELO
	baldur.fh-brandenburg.de") by vger.kernel.org with SMTP
	id <S129101AbRA2UDC>; Mon, 29 Jan 2001 15:03:02 -0500
Date: Mon, 29 Jan 2001 20:47:50 +0100 (MET)
From: Roman Zippel <zippel@fh-brandenburg.de>
To: Andi Kleen <ak@suse.de>
cc: Timur Tabi <ttabi@interactivesi.com>, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Kernel Janitor's TODO list
In-Reply-To: <20010129182633.A2522@gruyere.muc.suse.de>
Message-ID: <Pine.GSO.4.10.10101292036070.17869-100000@zeus.fh-brandenburg.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 29 Jan 2001, Andi Kleen wrote:

> You can miss wakeups. The standard pattern is:
> 
> 	get locks
> 
> 	add_wait_queue(&waitqueue, &wait);
> 	for (;;) { 
> 		if (condition you're waiting for is true) 
> 			break; 
> 		unlock any non sleeping locks you need for condition
> 		__set_task_state(current, TASK_UNINTERRUPTIBLE); 
> 		schedule(); 
> 		__set_task_state(current, TASK_RUNNING); 
> 		reaquire locks
> 	}
> 	remove_wait_queue(&waitqueue, &wait); 

You still miss wakeups. :)
Always set the task state first, then check the condition. See the
wait_event*() macros you mentioned for the right order.

bye, Roman

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
