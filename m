Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263507AbTDGQLD (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 12:11:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263516AbTDGQLD (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 12:11:03 -0400
Received: from adsl-67-120-62-187.dsl.lsan03.pacbell.net ([67.120.62.187]:4883
	"EHLO exchange.macrolink.com") by vger.kernel.org with ESMTP
	id S263507AbTDGQLB (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 7 Apr 2003 12:11:01 -0400
Message-ID: <11E89240C407D311958800A0C9ACF7D1A33E28@EXCHANGE>
From: Ed Vance <EdV@macrolink.com>
To: "'Michael Buesch'" <freesoftwaredeveloper@web.de>
Cc: linux-kernel@vger.kernel.org
Subject: RE: modifying line state manually on ttyS
Date: Mon, 7 Apr 2003 09:22:26 -0700 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 07, 2003 at 8:42 AM, Michael Buesch wrote:
> On Monday 07 April 2003 16:16, Alan Cox wrote:
> > TxD is a bad choice. A lot of the hardware cannot control TXD this
> > way. DTR is the usual one because it is easy to handle but there
> > are other control lines you can drive directly (see TIOCGMODEM)
> 
> Oh great, you have just discovered the reason, why my driver 
> is working
> on my Pentium1-PC but not on my Pentium4-PC. It's simply not supported
> by hardware.  I've spent hours and hours about this. :)
> 
> My device is actually using DTR and RTS. What line could I 
> use instead of
> TxD? Is it possible to use CTS for this, although it is normally a
> "input-signal", but not a "output-signal" like RTS?
> 
No, CTS cannot operate as an output. 

The following ioctl calls are implemented in the generic serial driver,
/usr/src/linux*/drivers/char/serial.c:

  Modem Lines
     On special files representing serial ports, the  modem  con-
     trol  lines  supported  by the hardware can be read, and the
     modem status lines supported by the hardware can be changed.
     The  following  modem  control  and status lines may be sup-
     ported by a device; they are defined by <asm/termios.h>:

          TIOCM_DTR      data terminal ready  (DTE output)
          TIOCM_RTS      request to send      (DTE output)
          TIOCM_CTS      clear to send        (DTE input)
          TIOCM_CAR      carrier detect       (DTE input)
          TIOCM_RNG      ring                 (DTE input)
          TIOCM_DSR      data set ready       (DTE input)
          TIOCM_OUT1     UART OUT1 signal     (misc output)
          TIOCM_OUT2     UART OUT2 signal     (misc output)

     TIOCM_CD is a synonym  for  TIOCM_CAR,  and  TIOCM_RI  is  a
     synonym for TIOCM_RNG. Not all of these are necessarily sup-
     ported by any particular device; check the manual  page  for
     the device in question. Output signals OUT1 and OUT2 are not
     always  connected to  port interface  pins.  Often  they are
     dedicated to control of  UART special functions or loopback.

     TIOCMBIS       The argument is a pointer  to  an  int  whose
                    value  is  a  mask  containing  modem control
                    lines to be turned  on.   The  control  lines
                    whose bits are set in the argument are turned
                    on; no other control lines are affected.

     TIOCMBIC       The argument is a pointer  to  an  int  whose
                    value  is  a  mask  containing  modem control
                    lines to be turned off.   The  control  lines
                    whose bits are set in the argument are turned
                    off; no other control lines are affected.

     TIOCMGET       The argument is a pointer  to  an  int.   The
                    current  state  of  the modem status lines is
                    fetched and stored in the int pointed  to  by
                    the argument.

     TIOCMSET       The argument is a pointer to an int  contain-
                    ing  a  new  set of modem control lines.  The
                    modem control lines are  turned  on  or  off,
                    depending on whether the bit for that mode is
                    set or clear.

Cheers,
Ed

---------------------------------------------------------------- 
Ed Vance              edv (at) macrolink (dot) com
Macrolink, Inc.       1500 N. Kellogg Dr  Anaheim, CA  92807
----------------------------------------------------------------
