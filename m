Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129786AbQLKUAp>; Mon, 11 Dec 2000 15:00:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129387AbQLKUAf>; Mon, 11 Dec 2000 15:00:35 -0500
Received: from chaos.analogic.com ([204.178.40.224]:6530 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S129786AbQLKUAQ>; Mon, 11 Dec 2000 15:00:16 -0500
Date: Mon, 11 Dec 2000 14:26:45 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: stewart@neuron.com
cc: Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: kapm-idled : is this a bug?
In-Reply-To: <Pine.LNX.4.10.10012111343570.2897-100000@localhost>
Message-ID: <Pine.LNX.3.95.1001211141623.32709A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Dec 2000 stewart@neuron.com wrote:

> 
> very helpful.
> 
> Technical merits and voter intent aside, this behavior is misleading and
> inconsistent with previous kernels. Tools like top or a CPU dock applet show
> a constantly loaded CPU. Hacking them to deduct the load from 'kapm-idled'
> seems like the wrong answer.
> 
> stewart
> 

Err.. Did you see the comment about shared memory info being permanently
removed because (something about too CPU intensive to justify...)?

It looks like we need to find another way to get kernel info rather
than from /proc. We need to calculate stuff only when it's needed.
Calculating stuff all the time, to make it available should somebody
care to read it in the /proc file-system is wasteful.

Maybe we need to have some kind of 'kernel ioctl' where a user-mode caller
'pays' for the CPU cycles necessary to obtain the info that the caller
requests. A better idea might be to have the 'read' of a particular
/proc file-system item, result in the calculation of the new values.
That way, the read and calculation of new values gets charged to
the reader.

In any event, the continuous calculation of 'kernel stuff' that may
be read once a week at most, is definitely a waste of CPU cycles.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.0 on an i686 machine (799.54 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
