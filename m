Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262265AbRE2EVD>; Tue, 29 May 2001 00:21:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262269AbRE2EUy>; Tue, 29 May 2001 00:20:54 -0400
Received: from [216.6.80.34] ([216.6.80.34]:63506 "EHLO
	dcmtechdom.dcmtech.co.in") by vger.kernel.org with ESMTP
	id <S262265AbRE2EUl>; Tue, 29 May 2001 00:20:41 -0400
Message-ID: <7FADCB99FC82D41199F9000629A85D1A01459A19@dcmtechdom.dcmtech.co.in>
From: "Harivansh S. Mehta" <harivansh@dcmtech.co.in>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Serial Programming
Date: Tue, 29 May 2001 09:54:47 +0530
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I am developing a driver which reads some data from the serial port in the
raw mode. For doing the same i do a call to which fails. The call to
our_ioctl for get serial data fails with return value -14 which is EBADADDR.

The same read works if we send a direct read request from an application to
our driver. However when we call the same thing from within the driver
module, it fails .
Please suggest  a way for this.


The code is something like this 

FILE * fp;
init_module()
{
fp = filp_open ("/dev/ttyS0", O_RDWR);
}


int  our_read(struct file *filp, char *buf, size_t size, loff_t *off)  
{ 
	if (fp)
	{
	    if (fp->f_op && fp->f_op->read)
 		retval =  fp->f_op->read(filep,buf,size,&filep->f_pos); 
	}
}


int  our_ioctl(struct inode *in, struct file *f, unsigned int cmd,
                 unsigned long arg)  
{
	switch (cmd)
	{
		case GET_SERIAL_DATA : return our_read(NULL, (char * ) arg,
MAX_READ, NULL);
		break;
	}
}


TIA
Harivansh S. Mehta
DCM Technologies Ltd.
India
