Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284297AbRL1W72>; Fri, 28 Dec 2001 17:59:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284289AbRL1W7U>; Fri, 28 Dec 2001 17:59:20 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:15117 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S284239AbRL1W7H>; Fri, 28 Dec 2001 17:59:07 -0500
Subject: Re: AX25/socket kernel PATCHes
To: henk.de.groot@hetnet.nl (Henk de Groot)
Date: Fri, 28 Dec 2001 23:09:43 +0000 (GMT)
Cc: linux-hams@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <5.1.0.14.2.20011228213437.009d1190@pop.hetnet.nl> from "Henk de Groot" at Dec 28, 2001 09:57:32 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16K68F-00029E-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I just downloaded the latest 2.4.17 kernel and I still do not see the 
> patches of Jeroen Vreeken, PE1RXQ, applied. Anybody know the reason why?

Because it changes core code in a way that shouldn't be needed

>    *		Arnaldo C. Melo :       cleanups, use skb_queue_purge
> + *		Jeroen Vreeken	:	Add check for sk->dead in sock_def_write_space
>    *
>    * To Fix:
>    *
> @@ -1146,7 +1147,7 @@
>   	/* Do not wake up a writer until he can make "significant"
>   	 * progress.  --DaveM
>   	 */
> -	if((atomic_read(&sk->wmem_alloc) << 1) <= sk->sndbuf) {
> +	if(!sk->dead && (atomic_read(&sk->wmem_alloc) << 1) <= sk->sndbuf) {
>   		if (sk->sleep && waitqueue_active(sk->sleep))
>   			wake_up_interruptible(sk->sleep);

Does the fix work without this change ?
