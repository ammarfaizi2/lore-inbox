Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316878AbSILSPJ>; Thu, 12 Sep 2002 14:15:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316880AbSILSPJ>; Thu, 12 Sep 2002 14:15:09 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:46349 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S316878AbSILSPI>; Thu, 12 Sep 2002 14:15:08 -0400
Message-Id: <200209121815.g8CIFdp06612@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Jan Kasprzak <kas@informatics.muni.cz>, linux-kernel@vger.kernel.org
Subject: Re: AMD 760MPX DMA lockup
Date: Thu, 12 Sep 2002 21:10:47 -0200
X-Mailer: KMail [version 1.3.2]
References: <20020912161258.A9056@fi.muni.cz>
In-Reply-To: <20020912161258.A9056@fi.muni.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12 September 2002 12:12, Jan Kasprzak wrote:

> my dual athlon box is unstable in some situations. I can consistently
> lock it up by running the following code:
>
> fd = open("/dev/hda3", O_RDWR);
> for (i=0; i<1024*1024; i++) {
> 	read(fd, buffer, 8192);
> 	lseek(fd, -8192, SEEK_CUR);
> 	write(fd, buffer, 8192);
> }

8 GB... Can you make it loop over much lesser size?

for (j=0; j<1024; j++) {
  fd = open("/dev/hda3", O_RDWR);
  for (i=0; i<1024; i++) {
  	read(fd, buffer, 8192);
  	lseek(fd, -8192, SEEK_CUR);
  	write(fd, buffer, 8192);
  }
  close(fd);
  printf(<some stats>);
}

I assume removing read+lseek eliminates lockup?

> I tried to put the tested disk to a separate IDE controller
> (Promise PDC20269 PCI card) - then I do not get a complete lockup,
> just the drive starts to complain about the DMA timeout, and the kernel
> reesets the controller. However, DMA timeouts start to occur even on
> the primary controller.

Is it IDE related or not? 
If you can test it over SCSI/NFS/ramdisk/???...

> When I switch off the DMA (hdparm -d0 /dev/hda), the problem goes away
> (however, the disk is very slow, as expected).

At which DMA/UDMA mode it starts to fail?
--
vda
