Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S132212AbQK0Rcl>; Mon, 27 Nov 2000 12:32:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S132331AbQK0RcV>; Mon, 27 Nov 2000 12:32:21 -0500
Received: from chaos.analogic.com ([204.178.40.224]:1408 "EHLO
        chaos.analogic.com") by vger.kernel.org with ESMTP
        id <S132329AbQK0RcO>; Mon, 27 Nov 2000 12:32:14 -0500
Date: Mon, 27 Nov 2000 12:01:35 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: "Andrew E. Mileski" <andrewm@netwinder.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: Universal debug macros.
In-Reply-To: <3A228DDE.61BEAFD8@netwinder.org>
Message-ID: <Pine.LNX.3.95.1001127115313.153A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Nov 2000, Andrew E. Mileski wrote:

> Elmer Joandi wrote:
> > 
> > Now if there would be simple _unified_ system for switching debug code
> > on/off, it would be a real win. That  recompilation-capable enduser would
> > not need much knowledge to go "General Setup" or newly created
> > "Optimization" section and switch debugging off/on for _all_ network
> > drivers or ide drivers for example.
> 
> Reminds me ... <linux/kernel.h> has a "#if DEBUG" statement that blows
> up if the debug code does something like "#define DEBUG(X...) printk(X...)".
> I came across this recently (think I was debugging PCI code ... not sure).
> Changing it to "#ifdef DEBUG" avoids problems.
> 
> --
> Andrew E. Mileski - Software Engineer
> Rebel.com  http://www.rebel.com/

I find that the following works fine:

#ifdef DEBUG
#define DEB(f) f
#else
#define DEB(f)
#endif

code.....

DEB(printk("Lots of stuff, %s, %d, %d, %d\n", string, int0, int1, int2));

In this case, if DEBUG is defined, printk() with its variable-length
parameter list is compiled.

If not, nothing is compiled, everything inside DEB() is simply ignored.

This means that the macros do not, themselves, have to handle variable-
length parameter lists. The preprocessor only handles text as it was
designed to do.


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
