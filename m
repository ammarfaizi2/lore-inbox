Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262608AbTCZXDU>; Wed, 26 Mar 2003 18:03:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262609AbTCZXDU>; Wed, 26 Mar 2003 18:03:20 -0500
Received: from chaos.analogic.com ([204.178.40.224]:38031 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S262608AbTCZXDT>; Wed, 26 Mar 2003 18:03:19 -0500
Date: Wed, 26 Mar 2003 18:18:09 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: henrique.gobbi@cyclades.com
cc: linux-kernel@vger.kernel.org
Subject: Re: Interpretation of termios flags on a serial driver
In-Reply-To: <3E81BE5C.400@cyclades.com>
Message-ID: <Pine.LNX.4.53.0303261804020.2833@chaos>
References: <1046909941.1028.1.camel@gandalf.ro0tsiege.org>
 <20030326092010.3EDA8124023@mx12.arcor-online.net> <3E81BE5C.400@cyclades.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Mar 2003, Henrique Gobbi wrote:

> Hi,
>
> If this is not the right forum to discuss this matter, excuse me. Please
> point me to the right place.
>
> I'm having some problems understanding three flags on the termios
> struct: PARENB, INPCK, IGNPAR. After reading the termios manual a couple
> of times I'm still not able to understand the different purposes of
> these flags.
>
> What I understood:
>
> 1 - PARENB: if this flag is set the serial chip must generate parity
> (odd or even depending on the flag PARODD). If this flag is not set, use
> parity none.
>
> 2 - IGNPAR: two cases here:
>     	2.1 - PARENB is set: if IGNPAR is set the driver should ignore 			all
> parity and framing errors and send the problematic bytes to 		tty flip
> buffer as normal data. If this flag is not set the 			driver must send the
> problematic data to the tty as problematic 		data.
>
> 	2.2 - PARENB is not set: disregard IGNPAR
>
> What I don't understand:
>
> 3 - Did I really understand the items 1 and 2 ?
>
> 4 - INPCK flag: What's the purpose of this flag. What's the diference in
> relation to IGNPAR;
>
> 5 - If the TTY knows the data status (PARITY, FRAMING, OVERRUN, NORMAL),
> why the driver has to deal with the flag IGNPAR. Shouldn't the TTY being
> doing it ?
>
> Thanks in advance
> Henrique
>

Since I've been mucking with serial I/O for many years, I'll
explain what I've descovered.

If PARENB is set you generate parity. It is ODD parity if PARODD
is set, otherwise it's EVEN. There is no provision to generate
"stick parity" even though most UARTS will do that. When you
generate parity, you can also ignore parity on received data if
you want.  This is the IGNPAR flag.

INPCK used to tell the driver to echo the rubout charcter
every time you got a parity error. This would cause the
user to back-space over the rubout character and enter the
errored character again. I don't know if Linux actually does
this. This was the "parity-checking" that you are enabling.
With this enabled, the errored character should go into the
buffer so the user can back-space over it.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.

