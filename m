Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131575AbQLVSoh>; Fri, 22 Dec 2000 13:44:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131822AbQLVSoR>; Fri, 22 Dec 2000 13:44:17 -0500
Received: from chaos.analogic.com ([204.178.40.224]:16512 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S131574AbQLVSoQ>; Fri, 22 Dec 2000 13:44:16 -0500
Date: Fri, 22 Dec 2000 13:13:33 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Miquel van Smoorenburg <miquels@traveler.cistron-office.nl>
cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.2.19pre3
In-Reply-To: <9204fu$ghe$3@enterprise.cistron.net>
Message-ID: <Pine.LNX.3.95.1001222130921.2200B-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 22 Dec 2000, Miquel van Smoorenburg wrote:

> In article <Pine.LNX.3.95.1001222104908.791A-100000@chaos.analogic.com>,
> Richard B. Johnson <root@chaos.analogic.com> wrote:
> >alias kwhich='type -path' in ~./bashrc should fix.
> 
> Hmm? Smells like a stupid bug to me. The script is called as:
> 
> CCFOUND :=$(shell $(CONFIG_SHELL) scripts/kwhich kgcc gcc272 cc gcc)
> 
> So how can bash ever decide to replace scripts/kwhich (OBVIOUSLY
> a call to a non-internal command) with an alias or builtin?
> 
> Are you sure this is in fact the bug?

No it isn't the bug. I didn't see the path to kwhich when I first
replied. I assumed another GNUism had appeared.

> 
> Couldn't it be the games with IFS in the scripts/kwhich script?
> 
> Try this patch:
> 
> --- linux-2.2.19pre3/scripts/kwhich.orig	Tue Dec 19 23:16:52 2000
> +++ linux-2.2.19pre3/scripts/kwhich	Fri Dec 22 19:02:47 2000
> @@ -7,7 +7,7 @@
>          exit 1
>  fi
>  
> -IFS=:
> +IFS=":$IFS"
>  for cmd in $*
>  do
>          for path in $PATH
>

And yes, this should do it.


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
