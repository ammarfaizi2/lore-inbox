Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131682AbRCQQDF>; Sat, 17 Mar 2001 11:03:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131680AbRCQQCz>; Sat, 17 Mar 2001 11:02:55 -0500
Received: from smtp06.wxs.nl ([195.121.6.58]:9974 "EHLO smtp06.wxs.nl")
	by vger.kernel.org with ESMTP id <S131679AbRCQQCh>;
	Sat, 17 Mar 2001 11:02:37 -0500
Message-ID: <3AB38A8D.6F96086@planet.nl>
Date: Sat, 17 Mar 2001 17:02:21 +0100
From: Erik van Asselt <e.van.asselt@planet.nl>
X-Mailer: Mozilla 4.7 [nl] (Win98; U)
X-Accept-Language: nl
MIME-Version: 1.0
To: Douglas Gilbert <dgilbert@interlog.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: problems compiling scsi_ioctl on kernels later 2.4.1
In-Reply-To: <3AB2F378.10D22DA5@interlog.com> <3AB35BE8.2E0EC8FA@planet.nl> <3AB36699.74AF1349@interlog.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i don't understand how it got corrupted but it looks like i'm missing a lot of things if
i compare it to your scsi_ioctl file
I will use your scsi_ioctl or i will untar kernel  2.4.2 again without patch pre4
i hope it will work

Erik


Douglas Gilbert schreef:

> Erik van Asselt wrote:
> >
> > I did link the usr/include/scsi to usr/srs/linux/include/scsi
> > isn't that the right way for compiling the new kernel?
>
> That link may be useful for running various apps but it
> is not recommended. It shouldn't make any difference to
> building a kernel.
>
> My scsi_ioctl.h file for lk 2.4.2 is attached.
>
> Doug Gilbert
>
> > Erik
> >
> > Douglas Gilbert schreef:
> >
> > > Erik,
> > > It looks like you are missing (or have a corrupted)
> > > include/scsi/scsi_ioctl.h header file. It contains
> > > the definition of the struct Scsi_Ioctl_Command .
> > >
> > > Doug Gilbert
>
>   ------------------------------------------------------------------------
> #ifndef _SCSI_IOCTL_H
> #define _SCSI_IOCTL_H
>
> #define SCSI_IOCTL_SEND_COMMAND 1
> #define SCSI_IOCTL_TEST_UNIT_READY 2
> #define SCSI_IOCTL_BENCHMARK_COMMAND 3
> #define SCSI_IOCTL_SYNC 4                       /* Request synchronous parameters */
> #define SCSI_IOCTL_START_UNIT 5
> #define SCSI_IOCTL_STOP_UNIT 6
> /* The door lock/unlock constants are compatible with Sun constants for
>    the cdrom */
> #define SCSI_IOCTL_DOORLOCK 0x5380              /* lock the eject mechanism */
> #define SCSI_IOCTL_DOORUNLOCK 0x5381            /* unlock the mechanism   */
>
> #define SCSI_REMOVAL_PREVENT    1
> #define SCSI_REMOVAL_ALLOW      0
>
> #ifdef __KERNEL__
>
> /*
>  * Structures used for scsi_ioctl et al.
>  */
>
> typedef struct scsi_ioctl_command {
>         unsigned int inlen;
>         unsigned int outlen;
>         unsigned char data[0];
> } Scsi_Ioctl_Command;
>
> typedef struct scsi_idlun {
>         __u32 dev_id;
>         __u32 host_unique_id;
> } Scsi_Idlun;
>
> /* Fibre Channel WWN, port_id struct */
> typedef struct scsi_fctargaddress
> {
>         __u32 host_port_id;
>         unsigned char host_wwn[8]; // include NULL term.
> } Scsi_FCTargAddress;
>
> extern int scsi_ioctl (Scsi_Device *dev, int cmd, void *arg);
> extern int kernel_scsi_ioctl (Scsi_Device *dev, int cmd, void *arg);
> extern int scsi_ioctl_send_command(Scsi_Device *dev,
>                                    Scsi_Ioctl_Command *arg);
>
> #endif
>
> #endif

