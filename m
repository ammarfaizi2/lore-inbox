Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129216AbRB0NLi>; Tue, 27 Feb 2001 08:11:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129259AbRB0NL2>; Tue, 27 Feb 2001 08:11:28 -0500
Received: from chaos.analogic.com ([204.178.40.224]:27777 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S129216AbRB0NLU>; Tue, 27 Feb 2001 08:11:20 -0500
Date: Tue, 27 Feb 2001 08:11:00 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Per Erik Stendahl <PerErik@onedial.se>
cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: Bug in cdrom_ioctl?
In-Reply-To: <E44E649C7AA1D311B16D0008C73304460933AF@caspian.prebus.uppsala.se>
Message-ID: <Pine.LNX.3.95.1010227080200.13747A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Feb 2001, Per Erik Stendahl wrote:

> Hi.
> 
> In linux-2.4.2/drivers/cdrom/cdrom.c:cdrom_ioctl() branches
> CDROM_SET_OPTIONS and CDROM_CLEAR_OPTIONS both return like this:
> 
>     return cdi->options;
> 
> If cdi->options is non-zero, the ioctl() calls returns non-zero.
> My ioctl(2) manpage says that a successful ioctl() should return
> zero. Now I dont know which is at fault here - the cdrom.c code or
> the manpage. :-) Could somebody enlighten me?
> 
> /Per Erik Stendahl
> -

Specifically, (at the API) upon an error -1 (nothing else) is to be
returned and 'errno' set appropriately. The results of a successful ioctl()
operation is supposed to have been returned in the parameter list (via
pointer). So, you have found a design bug. I wonder how much stuff
gets broken if this gets fixed?

I suggest you just fix it and see what breaks. Maybe sombody's
CD writer will break, but a patch will quickly be made by the
maintainer(s).


Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


