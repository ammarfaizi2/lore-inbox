Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267125AbTBHXQc>; Sat, 8 Feb 2003 18:16:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267126AbTBHXQc>; Sat, 8 Feb 2003 18:16:32 -0500
Received: from smtp08.iddeo.es ([62.81.186.18]:2693 "EHLO smtp08.retemail.es")
	by vger.kernel.org with ESMTP id <S267125AbTBHXQb>;
	Sat, 8 Feb 2003 18:16:31 -0500
Date: Sun, 9 Feb 2003 00:25:10 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: Oleg Drokin <green@linuxhacker.ru>
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: 2.4.21-pre4 comparison bugs
Message-ID: <20030208232510.GA1841@werewolf.able.es>
References: <20030208171838.GA2230@linuxhacker.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20030208171838.GA2230@linuxhacker.ru>; from green@linuxhacker.ru on Sat, Feb 08, 2003 at 18:18:38 +0100
X-Mailer: Balsa 2.0.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2003.02.08 Oleg Drokin wrote:
> Hello!
> 
>    Thanks to whoever mentioned "gcc -W", it's *sweet*  ;)
>    Looking at it's output I found few cases where error checking
>    does not work.
>    Though nothing too serious it seems (except maybe IDE setup-pci stuff,
>    I just do not know about that, and may be in that case
>    we actually want to change all the functions to return signed
>    value, though my fix is certainly less intrusive ;) )
>    Most of the patched stuff in here assigns signed value to unsigned
>    variable and then checks if it is less than zero which does not work
>    for obvious reasons ;)
>    I decided taht in most cases simple casting to int would be best
>    and least intrusive resolution of a problem.
>    The only exception is fs/isofs/inode.c, there we have unsigned int
>    (so it is unsigned not depending on any arch) and so '> some num'
>    stuff will also check for former negative numbers anyway. So
>    I removed one extra comparison in that case.
>    See the patch below.
> 

So:

unsgined f()
{
	return -1;
}

if ((int)f()<0)
??

Wouldn't you get killed by some kind of bit/sign extension in the return ?
Just to be sure, probably the answer is just 'go learn C internals'...

-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.1 (Cooker) for i586
Linux 2.4.21-pre4-jam1 (gcc 3.2.1 (Mandrake Linux 9.1 3.2.1-5mdk))
