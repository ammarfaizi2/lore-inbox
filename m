Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262629AbTCZXWr>; Wed, 26 Mar 2003 18:22:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262627AbTCZXWr>; Wed, 26 Mar 2003 18:22:47 -0500
Received: from adsl-67-120-62-187.dsl.lsan03.pacbell.net ([67.120.62.187]:36357
	"EHLO exchange.macrolink.com") by vger.kernel.org with ESMTP
	id <S262624AbTCZXWo>; Wed, 26 Mar 2003 18:22:44 -0500
Message-ID: <11E89240C407D311958800A0C9ACF7D1A33E03@EXCHANGE>
From: Ed Vance <EdV@macrolink.com>
To: "'henrique.gobbi@cyclades.com'" <henrique.gobbi@cyclades.com>
Cc: linux-kernel@vger.kernel.org,
       "'linux-serial'" <linux-serial@vger.kernel.org>
Subject: RE: Interpretation of termios flags on a serial driver
Date: Wed, 26 Mar 2003 15:33:56 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 26, 2003 at 6:51 AM, Henrique Gobbi wrote:
> 
> I'm having some problems understanding three flags on the termios 
> struct: PARENB, INPCK, IGNPAR. After reading the termios 
> manual a couple 
> of times I'm still not able to understand the different purposes of 
> these flags.
> 
> What I understood:
> 
> 1 - PARENB: if this flag is set the serial chip must generate parity 
> (odd or even depending on the flag PARODD). If this flag is 
> not set, use 
> parity none.
> 
> 2 - IGNPAR: two cases here:
>     	2.1 - PARENB is set: if IGNPAR is set the driver should 
> ignore 			all 
> parity and framing errors and send the problematic bytes to 	
> 	tty flip 
> buffer as normal data. If this flag is not set the 		
> 	driver must send the 
> problematic data to the tty as problematic 		data.
> 
> 	2.2 - PARENB is not set: disregard IGNPAR
> 
> What I don't understand:
> 
> 3 - Did I really understand the items 1 and 2 ?
> 
> 4 - INPCK flag: What's the purpose of this flag. What's the 
> diference in 
> relation to IGNPAR;

     If INPCK is set, input parity checking  is  enabled.      If
     INPCK is  not  set, input parity checking is disabled.  This
     allows output parity generation without input parity errors.
     Note  that  whether input parity checking is enabled or dis-
     abled is independent of whether parity detection is  enabled
     or disabled. If parity detection is enabled but input parity
     checking is disabled, the hardware to which the terminal  is
     connected  will  recognize  the parity bit, but the terminal
     special file will not check whether this is set correctly or
     not.

     If IGNPAR is set, a  byte  with  framing  or  parity  errors
     (other than break) is ignored. This means that the data byte
     with the error is thrown away  by the  driver as if the byte
     had never been received. 

In short,
If INPCK is _not_ set, then all received data bytes will be delivered 
to the user level, regardless of parity errors.
If IGNPAR is set, then only received data bytes that do not have 
parity errors will be delivered to the user level.
If PARENB is _not_ set, then the receiver hardware will not detect 
bad parity, so all received data bytes are considered free of errors. 
Since there are no data bytes with associated error indications, 
setting IGNPAR would have no effect. All of the data are considered 
error free.

> 
> 5 - If the TTY knows the data status (PARITY, FRAMING, 
> OVERRUN, NORMAL), 
> why the driver has to deal with the flag IGNPAR. Shouldn't 
> the TTY being 
> doing it ?

Not sure I understand the question. Received data does not carry any
information about errors with it after it leaves the driver, unless 
PARMRK is set. 
> 
> Thanks in advance
> Henrique

Cheers,
Ed

---------------------------------------------------------------- 
Ed Vance              edv (at) macrolink (dot) com
Macrolink, Inc.       1500 N. Kellogg Dr  Anaheim, CA  92807
----------------------------------------------------------------
