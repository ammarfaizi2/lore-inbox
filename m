Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314633AbSEBQTe>; Thu, 2 May 2002 12:19:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314635AbSEBQTd>; Thu, 2 May 2002 12:19:33 -0400
Received: from falstaff.iris-tech.net ([195.82.115.155]:63680 "HELO
	mail.iris-tech.net") by vger.kernel.org with SMTP
	id <S314633AbSEBQTd>; Thu, 2 May 2002 12:19:33 -0400
Date: Thu, 2 May 2002 17:20:11 +0000 (GMT)
From: Leo Liberti IrisTech <liberti@falstaff.iris-tech.net>
To: linux-kernel@vger.kernel.org
cc: liberti@iris-tech.net
Subject: aha152x.c incompatible with scatterlist in 2.5.12
Message-ID: <Pine.LNX.4.44.0205021715140.27983-100000@falstaff.iris-tech.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello, I am having problems building kernel 2.5.12 on an i686 arch - in
particular the aha152x module (built as a PCMCIA module) does not compile
because it depends on "struct scatterlist" (see include/asm/scatterlist.h)
having the member "char* address". Kernels 2.4.x had

struct scatterlist {
    char *  address;    /* Location data is to be transferred to */
    char * alt_address; /* Location of actual if address is a
                         * dma indirect buffer.  NULL otherwise */
    unsigned int length;
};

whereas kernels 2.5.x have a different declaration of scatterlist:

struct scatterlist {
    struct page         *page;
    unsigned int        offset;
    dma_addr_t          dma_address;
    unsigned int        length;
};

I don't know enough about the SCSI subsystem changes to fix this myself -
does anyone have a hint?

Could you please reply also to liberti@iris-tech.net as I am not
subscribed to the linux-kernel list.

Thanks,

Leo

