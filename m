Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271239AbRICEtu>; Mon, 3 Sep 2001 00:49:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271246AbRICEtk>; Mon, 3 Sep 2001 00:49:40 -0400
Received: from rj.sgi.com ([204.94.215.100]:63453 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S271239AbRICEtZ>;
	Mon, 3 Sep 2001 00:49:25 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Adam Schrotenboer <ajschrotenboer@lycosmail.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: scsi_lib.c undefined symbol 
In-Reply-To: Your message of "Mon, 03 Sep 2001 00:19:17 -0400."
             <3B9304C5.4070006@lycosmail.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 03 Sep 2001 14:49:26 +1000
Message-ID: <5392.999492566@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 03 Sep 2001 00:19:17 -0400, 
Adam Schrotenboer <ajschrotenboer@lycosmail.com> wrote:
>I have gotten this a couple times w/ other versions of the kernel, but 
>this is 2.4.9-ac6. (2.4.8-ac12 worked, but that may be a fluke)
>
>gcc -D__KERNEL__ -I/mnt/hda3/kernel/2.4.9-ac6/linux/include -Wall 
>-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer 
>-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 
>-march=athlon  -DMODULE -DMODVERSIONS -include 
>/mnt/hda3/kernel/2.4.9-ac6/linux/include/linux/modversions.h   -c -o 
>scsi_lib.o scsi_lib.c
>scsi_lib.c: In function `__scsi_end_request':
>scsi_lib.c:379: `queued_sectors_Rc37b18c1' undeclared (first use in this 
>function)

It works for me on 2.4.9-ac6 using your .config.  I am using
egcs-2.91.66 which does not support -march=athlon so I get different
compiler flags, which compiler are you using?  There is no obvious
reason for this error, genksyms should pick up the same cflags as the
compile.

I need 'fgrep queued_sectors include/linux/modules/*'.  Also
  cd drivers/scsi
  gcc -D__KERNEL__ -I/mnt/hda3/kernel/2.4.9-ac6/linux/include -Wall \
      -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer \
      -fno-strict-aliasing -fno-common -pipe \
      -mpreferred-stack-boundary=2 -march=athlon -DMODULE -DMODVERSIONS \
      -include /mnt/hda3/kernel/2.4.9-ac6/linux/include/linux/modversions.h \
      -c -E -o scsi_lib.i scsi_lib.c
Send me scsi_lib.i.

