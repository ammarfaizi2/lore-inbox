Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284451AbRLEV4s>; Wed, 5 Dec 2001 16:56:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284526AbRLEV4n>; Wed, 5 Dec 2001 16:56:43 -0500
Received: from maild.telia.com ([194.22.190.101]:17919 "EHLO maild.telia.com")
	by vger.kernel.org with ESMTP id <S284536AbRLEV4B>;
	Wed, 5 Dec 2001 16:56:01 -0500
Message-Id: <200112052155.fB5Ltxa26014@d1o849.telia.com>
Content-Type: text/plain; charset=US-ASCII
From: Jakob Kemi <jakob.kemi@telia.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.17-pre4
Date: Wed, 5 Dec 2001 22:54:26 +0100
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <Pine.LNX.4.21.0112051640570.20575-100000@freak.distro.conectiva>
In-Reply-To: <Pine.LNX.4.21.0112051640570.20575-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesdayen den 5 December 2001 19.41, Marcelo Tosatti wrote:
> Duh. I forgot to add tcp_diag.c and tcp_diag.h in -pre3, which avoid it to
> compile correctly.
>
> Well, here goes -pre4 which fixes that.
>
> - Added missing tcp_diag.c and tcp_diag.h       (me)
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

Hi Marcelo,

Since 2.4.14 the ieee1284 parport functions have worked improperly for some 
drivers (CPiA, W9966 and others). Joe <joeja@mindspring.com> was quick to 
find the failure. He said he was going to send the patch to you some week ago 
and maybe he already have. If it somehow got lost in an internet black-hole 
or something I try to also send it to you. It's just a one-liner which 
reverts to pre-2.4.14 behavior.

--- ieee1284_ops.c.orig	Tue Nov  6 11:29:26 2001
+++ ieee1284_ops.c	Wed Dec  5 22:44:20 2001
@@ -592,7 +592,7 @@
 		}

 		/* Event 44: Set HostAck high, acknowledging handshake. */
-		parport_write_control (port, ctl);
+		parport_frob_control (port, PARPORT_CONTROL_AUTOFD, 0);

 		/* Event 45: The peripheral has 35ms to set nAck high. */
 		if (parport_wait_peripheral (port, PARPORT_STATUS_ACK,
