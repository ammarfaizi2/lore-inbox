Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262719AbREOKMc>; Tue, 15 May 2001 06:12:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262724AbREOKMW>; Tue, 15 May 2001 06:12:22 -0400
Received: from ausmtp02.au.ibm.COM ([202.135.136.105]:46086 "EHLO
	ausmtp02.au.ibm.com") by vger.kernel.org with ESMTP
	id <S262719AbREOKMH>; Tue, 15 May 2001 06:12:07 -0400
From: mdaljeet@in.ibm.com
X-Lotus-FromDomain: IBMIN@IBMAU
To: Gerd Knorr <kraxel@bytesex.org>
cc: linux-kernel@vger.kernel.org
Message-ID: <CA256A4D.0037EAF4.00@d73mta05.au.ibm.com>
Date: Tue, 15 May 2001 15:38:40 +0530
Subject: Re: mmap
Mime-Version: 1.0
Content-type: multipart/mixed; 
	Boundary="0__=iWFCKZEuj2HflbVPTbFguJYs7DI6kYTBZZCRZA3IdO1Y9z8OSSFxCxIY"
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--0__=iWFCKZEuj2HflbVPTbFguJYs7DI6kYTBZZCRZA3IdO1Y9z8OSSFxCxIY
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline

When I malloc the memory in user space, the memory may be discontinuous for
large chunks of memory say 16k or 32k. Does the 'kiobuf' interface take
care of this or it assumes it to be continuous?

regards,
Daljeet Maini
IBM Global Services Ltd. - Bangalore
Ph. No. - 5267117 Extn 2954


|--------+----------------------->
|        |          Gerd Knorr   |
|        |          <kraxel@bytes|
|        |          ex.org>      |
|        |                       |
|        |          05/15/01     |
|        |          01:03 PM     |
|        |          Please       |
|        |          respond to   |
|        |          Gerd Knorr   |
|        |                       |
|--------+----------------------->
  >--------------------------------------------------------|
  |                                                        |
  |       To:     linux-kernel@vger.kernel.org             |
  |       cc:     (bcc: Daljeet Maini/India/IBM)           |
  |       Subject:     Re: mmap                            |
  >--------------------------------------------------------|





--0__=iWFCKZEuj2HflbVPTbFguJYs7DI6kYTBZZCRZA3IdO1Y9z8OSSFxCxIY
Content-type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-transfer-encoding: quoted-printable



mdaljeet@in.ibm.com wrote:
>  I am doing the following:
>
>     malloc some memory is user space
>     pass its pointer to some kernel module
>     in the kernel module...do a pci_alloc_consistent so that i get a
memory
>     region for PCI DMA operations

Wrong approach, you can use kiobufs if you want DMA to the malloc()ed
userspace memory:

 * lock down the user memory using map_user_kiobuf() + lock_kiovec()
   (see linux/iobuf.h).
 * translate the iobuf->maplist into a scatterlist [1]
 * feed pci_map_sg() with the scatterlist to get DMA addresses.
   you can pass to the hardware.

And the reverse to free everything when you are done of course.

  Gerd

[1] IMHO it would be more useful if iobufs would use a scatterlist
    instead of an struct page* array.


--
Gerd Knorr <kraxel@bytesex.org>  --  SuSE Labs, Au=DFenstelle Berlin
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

=

--0__=iWFCKZEuj2HflbVPTbFguJYs7DI6kYTBZZCRZA3IdO1Y9z8OSSFxCxIY--

