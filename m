Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267886AbRGRQQ1>; Wed, 18 Jul 2001 12:16:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267901AbRGRQQQ>; Wed, 18 Jul 2001 12:16:16 -0400
Received: from cs2719-203.austin.rr.com ([24.27.19.203]:50673 "EHLO
	snafu.haywired.net") by vger.kernel.org with ESMTP
	id <S267886AbRGRQQJ>; Wed, 18 Jul 2001 12:16:09 -0400
Date: Wed, 18 Jul 2001 11:31:59 -0500 (CDT)
From: <paulsch@haywired.net>
To: Paul Schroeder <paulsch@us.ibm.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>,
        Mike Sullivan <sullivam@us.ibm.com>
Subject: Re: [PATCH] ACP Modem (Mwave)
In-Reply-To: <OF67CA15A0.AE538F3E-ON85256A8D.00580180@raleigh.ibm.com>
Message-ID: <Pine.LNX.4.33.0107181129430.18913-100000@screwy.haywired.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oh yeah...

It can be gotten here:

http://oss.software.ibm.com/acpmodem/

Directly:
http://oss.software.ibm.com/pub/acpmodem/mwave_linux-2.4.6.patch-20010718


On Wed, 18 Jul 2001, Paul Schroeder wrote:

> Okay..  I cleaned things up...  I was more careful about the globals this
> time...
>
> Also...  The driver now builds as mwave.o instead of mwavedd.o...  The
> driver now registers it's UART as a serial device (Thomas Hood)..  So there
> is no need to run setserial anymore...
>
> Cheers...Paul...
>
>
> ---
> Paul B Schroeder  <paulsch@us.ibm.com>
> Software Engineer, Linux Technology Center
> IBM Corporation, Austin, TX
>
>
> Alan Cox <alan@lxorguk.ukuu.org.uk> on 07/12/2001 02:55:00 PM
>
> To:   Paul Schroeder/Austin/IBM@IBMUS
> cc:   linux-kernel@vger.kernel.org, Mike Sullivan/Austin/IBM@IBMUS,
>       alan@lxorguk.ukuu.org.uk (Alan Cox)
> Subject:  Re: [PATCH] ACP Modem (Mwave)
>
>
>
> > The patch has been updated...  The updates primarily consist of Alan's
> > suggested changes below... (thank you)  It applies against the 2.4.6
> > kernel...
>
> A quick glance through it:
>
> dsp3780I_WriteDStore still touches user space with a spinlock held
> (also doesnt check the get_user return)
>
> The ioctl handlers do not check copy_from_user/to_user returns
>
> IOCTL_MW_UNREGISTER_IPC will oops if fed bogus info (ipcnum should be
> unsigned)
>
> The return should be -ENOTTY not -ENOIOCTLCMD  unless its internal code
> that catches NOIOCTLCMD and changes it before user space sees it
>
> mwave_Read should be -EINVAL not -ENOSYS (ENOSYS means the entire read
> syscall
> in the OS isnt there)
>
> In debug mode mwave_write accesses user space directly and may crash
> (buf[0])
>
> Trivial item - coding style uses foo(void) not foo() to indicate functions
> taking no arguments
>
> Still have globals like "dspio" "uartio"  "ClaimResources" etc
>
> whats wrong with tp3780_uart_io etc for globals ?
>
> Otherwise it looks close to ready
>
> Alan
>
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

-- 

Paul B Schroeder
paulsch@haywired.net


