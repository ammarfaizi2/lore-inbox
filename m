Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268217AbRH0UGA>; Mon, 27 Aug 2001 16:06:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268286AbRH0UFu>; Mon, 27 Aug 2001 16:05:50 -0400
Received: from archive.osdlab.org ([65.201.151.11]:8673 "EHLO fire.osdlab.org")
	by vger.kernel.org with ESMTP id <S268217AbRH0UFc>;
	Mon, 27 Aug 2001 16:05:32 -0400
Message-ID: <3B8AA6AE.975DD35F@osdlab.org>
Date: Mon, 27 Aug 2001 12:59:42 -0700
From: "Randy.Dunlap" <rddunlap@osdlab.org>
Organization: OSDL
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-20mdk i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Bart Vandewoestyne <Bart.Vandewoestyne@pandora.be>
CC: linux-kernel@vger.kernel.org
Subject: Re: DOS2linux
In-Reply-To: <3B8AA1EC.9ECD94BD@pandora.be>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bart Vandewoestyne wrote:
> 
> I have a routine from a DOS driver that looks like this:
> 
> static int getslotinfo( void )
> {
>   static char buff[320], *s=&buff[0]; int valid;
> 
>   inregs.h.ah=0xd8; inregs.h.al=0x1; inregs.h.cl=DiSC_Id.slot>>12;
> inregs.h.ch=0;
>   sregs.ds=FP_SEG(s); inregs.x.si=FP_OFF(s);
>   int86x(0x15, &inregs, &outregs, &sregs);
>   valid=outregs.h.ah;
>   if(!valid) { DiSC_Id.it=buff[itconf]; DiSC_Id.dma=buff[dmachd]; }
>   return(valid);
> }
> 
> (full DOS-code is at http://mc303.ulyssis.org/heim/downloads/DISCDRV.C
> )
> 
> Doing some research learned me that this piece of code does the
> following things (according to http://www.ctyme.com/intr/rb-1641.htm
> ):
> 
> 1) set AX register to 0xd800
                        ^^^^^^ actually to 0xd801

> 2) set slot number to DiSC_Id.slot, (eg. 1 in my case -> base is
> 0x1000)
> 3) set function number to read
> 4) assign a 320-byte buffer for standard configuration data block
> 5) execute a software interrupt via the DOS specific int86x function,
> this puts configuration data into the 320-byte buffer.
> 6) check if we get a valid return
> 7) if we have a valid situation, assign values from the configuration
> block to DiSC_Id.it (it level) and DiSC_Id.dma (dma level)
> 
> So here's my question:
> 
> On http://www.ctyme.com/intr/rb-1641.htm I can see that this is all
> about reading data from an EISA SYSTEM ROM.  I can't imagine there
> doesn't exist some linux-API that allows me to do just the same.

I don't have any direct EISA experience on Linux, but the
Linux Device Drivers book (remember that one?) says:

"EISA devices are configured by software, but they don't need any
particular operating system
support. EISA drivers already exist in the Linux kernel for Ethernet
devices and SCSI controllers."

and

"As far as the driver is concerned, there is no special support for
EISA in the kernel, and the
programmer must deal with ISA extensions by himself. The driver uses
standard EISA I/O
operations to access the EISA registers. The drivers that are already
in the kernel can be used as
sample code."

See (and read) http://www.xml.com/ldd/chapter/book/ch15.html
and some drivers that already do this.


> What function calls and header files should I use in order to read
> this 'EISA SYSTEM ROM' and assign the correct values to DiSC_Id.it and
> DiSC_Id.dma ?
> 
> If there doesn't exist an API for this, what memory ranges should i
> probe in order to get these values?

~Randy
