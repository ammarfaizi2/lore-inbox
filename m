Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262785AbTCVPqe>; Sat, 22 Mar 2003 10:46:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262788AbTCVPqe>; Sat, 22 Mar 2003 10:46:34 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:38554
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262785AbTCVPqd>; Sat, 22 Mar 2003 10:46:33 -0500
Subject: Re: [CHECKER] race in 2.5.62/drivers/char/esp.c?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Dawson Engler <engler@csl.stanford.edu>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200303221154.h2MBs6r09675@csl.stanford.edu>
References: <200303221154.h2MBs6r09675@csl.stanford.edu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1048352981.9221.13.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 22 Mar 2003 17:09:41 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>    /u2/engler/mc/oses/linux/linux-2.5.62/drivers/char/esp.c:1426:rs_throttle
>         cli();
>         info->IER &= ~UART_IER_RDI;
>         serial_out(info, UART_ESI_CMD1, ESI_SET_SRV_MASK);
>         serial_out(info, UART_ESI_CMD2, info->IER);
>         serial_out(info, UART_ESI_CMD1, ESI_SET_RX_TIMEOUT);
>         serial_out(info, UART_ESI_CMD2, 0x00);
>         sti();

> Error --->
>                 serial_out(info, UART_ESI_CMD1, ESI_GET_UART_STAT);
>                 if (serial_in(info, UART_ESI_STAT2) & UART_MSR_DCD)
>                         do_clocal = 1;

This is a bug yes - the CMD/STAT sequences look like they need a
spinlock to control sequence that use them. Does anyone have an esp card
any more to test stuff ?

