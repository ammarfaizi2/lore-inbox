Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265225AbRGBOEP>; Mon, 2 Jul 2001 10:04:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265237AbRGBOEF>; Mon, 2 Jul 2001 10:04:05 -0400
Received: from ausmtp02.au.ibm.COM ([202.135.136.105]:1446 "EHLO
	ausmtp02.au.ibm.com") by vger.kernel.org with ESMTP
	id <S265225AbRGBODx>; Mon, 2 Jul 2001 10:03:53 -0400
From: mdaljeet@in.ibm.com
X-Lotus-FromDomain: IBMIN@IBMAU
To: Gerd Knorr <kraxel@bytesex.org>
cc: linux-kernel@vger.kernel.org
Message-ID: <CA256A7D.004D2B0F.00@d73mta01.au.ibm.com>
Date: Mon, 2 Jul 2001 19:30:44 +0530
Subject: Re: mmap
Mime-Version: 1.0
Content-type: multipart/mixed; 
	Boundary="0__=y76NQQffAK1hg3uTyCuhJDiZQi5Cquunhdx4HgRiuE40PUTA70MQuoxC"
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--0__=y76NQQffAK1hg3uTyCuhJDiZQi5Cquunhdx4HgRiuE40PUTA70MQuoxC
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline

I use the 'map_user_kiobuf' and 'lock_kiovec' kernel routines in a module
for 'user space memory'. After that if I pass the
'(iobuf->maplist[0])-mem_map) <<  PAGE_SHIFT)' to the hardware for DMA
operations and it works fine for Intel platforms. Now how can I use the
'iobuf' struct obtained after lock_kiovec operation to get a PCI bus
address that I can pass to hardware for DMA operations on my Apple
machine.?

thanks,
Daljeet.


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
  >-----------------------------------------------------------------------|
  |                                                                       |
  |       To:     linux-kernel@vger.kernel.org                            |
  |       cc:     (bcc: Daljeet Maini/India/IBM)                          |
  |       Subject:     Re: mmap                                           |
  >-----------------------------------------------------------------------|





--0__=y76NQQffAK1hg3uTyCuhJDiZQi5Cquunhdx4HgRiuE40PUTA70MQuoxC
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

--0__=y76NQQffAK1hg3uTyCuhJDiZQi5Cquunhdx4HgRiuE40PUTA70MQuoxC--

