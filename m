Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129055AbQJ3TgC>; Mon, 30 Oct 2000 14:36:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129362AbQJ3Tfw>; Mon, 30 Oct 2000 14:35:52 -0500
Received: from virgo.cus.cam.ac.uk ([131.111.8.20]:53483 "EHLO
	virgo.cus.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S129055AbQJ3Tfp>; Mon, 30 Oct 2000 14:35:45 -0500
Message-Id: <5.0.0.25.2.20001030193142.03b54b50@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.0
Date: Mon, 30 Oct 2000 19:35:51 +0000
To: Brett Smith <brett.smith@bktech.com>
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: installing an ISR from user code
Cc: linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <39FDAE74.2AED0C74@bktech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 17:23 30/10/2000, Brett Smith wrote:
>We have written a char driver for our proprietary h/w.  This driver
>handles a multitude of interrupts from the h/w in the following 
>fashion:  The ISR reads/saves the status register (indication of which int 
>was hit) in
>global, and the marks the BH to run.  The BH uses the global to call one
>of 32 "ISRs" (an array of func ptrs).  I would like to be able to
>install an "ISR" dynamically from user code (the module has already been
>installed).  Is this possible?
>
>If it is possible, how does the build/link work?

Of course it is possible. - There are drivers out there doing similar 
things. - Unfortunately while the one I actually know is open source the 
program attaching to this driver is not open source so you can only see the 
kernel side of the solution. )-:

Download: ftp://ftp.sigmadesigns.com/NetStr_2000/NetStream2000-0.1.033.0.tar.gz

Gunzip/Untar the archive and look in the Barbados/kernelmode directory in 
the file quasar.c. - In that file you will find the implementation of some 
IOCTLs and the one you will find most interesting is IOCTL_SEND_PID which 
is used for the purpose of registering a user space ISR with the kernel 
mode driver.

This concept can easily be extended by another passed in argument 
containing which ISR to register with this call or you could do them all at 
once whatever suits you.

Hope this helps.

Regards,

         Anton

>thanks,
>brett.smith@bktech.com
>
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>Please read the FAQ at http://www.tux.org/lkml/

-- 
      "Education is what remains after one has forgotten everything he 
learned in school." - Albert Einstein
-- 
Anton Altaparmakov  Voice: +44-(0)1223-333541(lab) / +44-(0)7712-632205(mobile)
Christ's College    eMail: AntonA@bigfoot.com / aia21@cam.ac.uk
Cambridge CB2 3BU    ICQ: 8561279
United Kingdom       WWW: http://www-stu.christs.cam.ac.uk/~aia21/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
