Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266263AbRH0Tj1>; Mon, 27 Aug 2001 15:39:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266977AbRH0TjR>; Mon, 27 Aug 2001 15:39:17 -0400
Received: from urc1.cc.kuleuven.ac.be ([134.58.10.3]:3215 "EHLO
	urc1.cc.kuleuven.ac.be") by vger.kernel.org with ESMTP
	id <S266263AbRH0TjJ>; Mon, 27 Aug 2001 15:39:09 -0400
Message-ID: <3B8AA1EC.9ECD94BD@pandora.be>
Date: Mon, 27 Aug 2001 21:39:24 +0200
From: Bart Vandewoestyne <Bart.Vandewoestyne@pandora.be>
Organization: MyHome
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.9 i686)
X-Accept-Language: nl-BE, nl, en, de
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: DOS2linux
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a routine from a DOS driver that looks like this:

static int getslotinfo( void )
{
  static char buff[320], *s=&buff[0]; int valid;

  inregs.h.ah=0xd8; inregs.h.al=0x1; inregs.h.cl=DiSC_Id.slot>>12;
inregs.h.ch=0;
  sregs.ds=FP_SEG(s); inregs.x.si=FP_OFF(s);
  int86x(0x15, &inregs, &outregs, &sregs);
  valid=outregs.h.ah;
  if(!valid) { DiSC_Id.it=buff[itconf]; DiSC_Id.dma=buff[dmachd]; }
  return(valid);
}

(full DOS-code is at http://mc303.ulyssis.org/heim/downloads/DISCDRV.C
)

Doing some research learned me that this piece of code does the
following things (according to http://www.ctyme.com/intr/rb-1641.htm
):

1) set AX register to 0xd800
2) set slot number to DiSC_Id.slot, (eg. 1 in my case -> base is
0x1000)
3) set function number to read
4) assign a 320-byte buffer for standard configuration data block
5) execute a software interrupt via the DOS specific int86x function,
this puts configuration data into the 320-byte buffer.
6) check if we get a valid return
7) if we have a valid situation, assign values from the configuration
block to DiSC_Id.it (it level) and DiSC_Id.dma (dma level)


So here's my question:

On http://www.ctyme.com/intr/rb-1641.htm I can see that this is all
about reading data from an EISA SYSTEM ROM.  I can't imagine there
doesn't exist some linux-API that allows me to do just the same.

What function calls and header files should I use in order to read
this 'EISA SYSTEM ROM' and assign the correct values to DiSC_Id.it and
DiSC_Id.dma ?

If there doesn't exist an API for this, what memory ranges should i
probe in order to get these values?


Thanks for answers,
mc303

-- 
Ing. Bart Vandewoestyne			 Bart.Vandewoestyne@pandora.be
Hugo Verrieststraat 48			       GSM: +32 (0)478 397 697
B-8550 Zwevegem			 http://users.pandora.be/vandewoestyne
----------------------------------------------------------------------
"Any fool can know, the point is to understand." - Albert Einstein
