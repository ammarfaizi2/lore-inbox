Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262700AbTC0ACb>; Wed, 26 Mar 2003 19:02:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262699AbTC0ACb>; Wed, 26 Mar 2003 19:02:31 -0500
Received: from intra.cyclades.com ([64.186.161.6]:15018 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP
	id <S262685AbTC0AC1>; Wed, 26 Mar 2003 19:02:27 -0500
Subject: RE: Interpretation of termios flags on a serial driver
From: Henrique Gobbi <henrique.gobbi@cyclades.com>
To: Ed Vance <EdV@macrolink.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "'linux-serial'" <linux-serial@vger.kernel.org>
In-Reply-To: <11E89240C407D311958800A0C9ACF7D1A33E03@EXCHANGE>
References: <11E89240C407D311958800A0C9ACF7D1A33E03@EXCHANGE>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 26 Mar 2003 16:17:23 -0800
Message-Id: <1048724243.2374.27.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Ed !
Thanks for the feedback. 

Please read my coments (doubts actually) below:

> > 4 - INPCK flag: What's the purpose of this flag. What's the 
> > diference in 
> > relation to IGNPAR;
>      If INPCK is set, input parity checking  is  enabled.      If
>      INPCK is  not  set, input parity checking is disabled.  This
>      allows output parity generation without input parity errors.
>      Note  that  whether input parity checking is enabled or dis-
>      abled is independent of whether parity detection is  enabled
>      or disabled. If parity detection is enabled but input parity
>      checking is disabled, the hardware to which the terminal  is
>      connected  will  recognize  the parity bit, but the terminal
>      special file will not check whether this is set correctly or
>      not.
> 
>      If IGNPAR is set, a  byte  with  framing  or  parity  errors
>      (other than break) is ignored. This means that the data byte
>      with the error is thrown away  by the  driver as if the byte
>      had never been received. 
> 
> In short,
> If INPCK is _not_ set, then all received data bytes will be delivered 
> to the user level, regardless of parity errors.
> If IGNPAR is set, then only received data bytes that do not have 
> parity errors will be delivered to the user level.
> If PARENB is _not_ set, then the receiver hardware will not detect 
> bad parity, so all received data bytes are considered free of errors. 
> Since there are no data bytes with associated error indications, 
> setting IGNPAR would have no effect. All of the data are considered 
> error free.

Your explanation makes sense to me. With this information I built the
table:
   IGNPAR    INPCK         ACTION:
     0         0           Deliver all data to the user-level
     0         1           Check parity. Discard erroneous bytes
     1         0           ????
     1         1           Check parity. Discard erroneous bytes 

What goes on ????   ?

> > 5 - If the TTY knows the data status (PARITY, FRAMING, 
> > OVERRUN, NORMAL), 
> > why the driver has to deal with the flag IGNPAR. Shouldn't 
> > the TTY being 
> > doing it ?
> 
> Not sure I understand the question. Received data does not carry any
> information about errors with it after it leaves the driver, unless 
> PARMRK is set. 

When the driver copy the data from the controler to the flip buffer it
copies the data to the buffer tty->flip.char_buf_ptr and it set a flag
(TTY_NORMAL, TTY_PARITY, TTY_FRAME, etc) on the buffer
tty->flip.flag_buf_ptr telling the TTY how this byte was received. So
the TTY knows if certain byte was problematic or not. Did you understand
my doubt know ?

Thanks for your patience
Henrique

