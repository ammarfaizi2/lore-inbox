Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281004AbRKYTDZ>; Sun, 25 Nov 2001 14:03:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280996AbRKYTDF>; Sun, 25 Nov 2001 14:03:05 -0500
Received: from smtp6.mindspring.com ([207.69.200.110]:57118 "EHLO
	smtp6.mindspring.com") by vger.kernel.org with ESMTP
	id <S280994AbRKYTC6>; Sun, 25 Nov 2001 14:02:58 -0500
Message-ID: <3C0141CB.617DEC1D@mindspring.com>
Date: Sun, 25 Nov 2001 11:08:59 -0800
From: Joe <joeja@mindspring.com>
Reply-To: joeja@mindspring.com
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.14 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jakob Kemi <jakob.kemi@telia.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.14/2.4.15 cpia driver IS broke.. no its parport
In-Reply-To: <Pine.LNX.4.33.0111230950580.24427-100000@netfinity.realnet.co.sz> <3C000EE7.D69C1482@mindspring.com> <200111242143.fAOLhsa10672@d1o849.telia.com> <200111242220.fAOMKxa13508@d1o849.telia.com>
Content-Type: multipart/mixed;
 boundary="------------D96DDA71340FE32D6A3929B9"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------D96DDA71340FE32D6A3929B9
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

In that case I'ss send my patch to 2.4.14 to the list and hope it helps others
with their parallel port webcams.. (its small)

Joe

> This works perfectly for my w9966 parport webcam!
>         /Jakob
>
> On Saturdayen den 24 November 2001 22.43, Jakob Kemi wrote:
> > Great!
> >
> > I'll test it right away.
> >       /Jakob
> >
> > > The problem is that in the call to acknowledge the handshake (Event 44?
> > > about line592) the call to parport_frob_control or
> > > parport_pc_frob_control as it is #defined to is called with a 0 which I
> > > think causes the code to call parport_pc_data_forward and the new code
> > > just calls
> > > parport_pc_data_reverse. I think that we may need to call the
> > > parport_pc_data_forward still.
> > >
> > > -               parport_write_control (port, ctl);   // new code
> > > +               parport_frob_control (port, PARPORT_CONTROL_AUTOFD, 0);
> > > //old working code
> > >
> > > Joe
> > >
>

--------------D96DDA71340FE32D6A3929B9
Content-Type: text/plain; charset=us-ascii;
 name="ieee1294_ops_fix-2.4.14"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ieee1294_ops_fix-2.4.14"

--- linux-2.4.14/drivers/parport/ieee1284_ops.c	Fri Nov 23 20:59:42 2001
+++ linux-2.4.current/drivers/parport/ieee1284_ops.c	Sun Nov 18 21:13:10 2001
@@ -592,7 +592,7 @@
 		}
 
 		/* Event 44: Set HostAck high, acknowledging handshake. */
-		parport_write_control (port, ctl);
+		parport_frob_control (port, PARPORT_CONTROL_AUTOFD, 0);
 
 		/* Event 45: The peripheral has 35ms to set nAck high. */
 		if (parport_wait_peripheral (port, PARPORT_STATUS_ACK,

--------------D96DDA71340FE32D6A3929B9--

