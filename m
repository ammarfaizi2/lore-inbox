Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318130AbSHQSI7>; Sat, 17 Aug 2002 14:08:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318133AbSHQSI7>; Sat, 17 Aug 2002 14:08:59 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:37649
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S318130AbSHQSI6>; Sat, 17 Aug 2002 14:08:58 -0400
Date: Sat, 17 Aug 2002 11:03:19 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Ruth Ivimey-Cook <Ruth.Ivimey-Cook@ivimey.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: IDE?  IDE-TNG driver
In-Reply-To: <Pine.LNX.4.44.0208171812400.2705-100000@sharra.ivimey.org>
Message-ID: <Pine.LNX.4.10.10208171057390.23171-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



ide_ioctl(fd, HDIO_SET_IDE_SCSI, bool)

Where bool does the subdriver switch.
Just that ioctl's are being blasted and people using are frowned upon.

This was a feature Alan Cox poked me for to try and move away from how
modules are basically an all or nothing grab-all.

Regards,

Andre Hedrick
LAD Storage Consulting Group

On Sat, 17 Aug 2002, Ruth Ivimey-Cook wrote:

> On Sat, 17 Aug 2002, Andre Hedrick wrote:
> 
> >
> >I will hand it to you guys on a silver platter IDE-TNG.
> >
> >Below yields modular chipsets and channel index registration.
> >Selectable IOPS for arch independent Taskfile Transport layers.
> ...
> >You have ide-cd registered on a cdrw and you want to burn a cd?
> >open(/dev/hdX) transform_subdriver_scsi close(/dev/hdX)
> >open(/dev/sg) and burn baby burn.
> >close(/dev/sg) releases transform_subdriver_scsi
> >open(/dev/hdX) load native atapi transport.
> 
> 
> Andre, I see the thought, but surely this is prine to races and other 
> difficulties.
> 
> Wouldn't it be better to provide an IDE ioctl() that enables the caller to use 
> set the SCSI transport on an open FD, so your sequence becomes:
> 
>  open(/dev/hdX)
>  ioctl(transform_subdriver_scsi)
>  ioctl(scsi_ops)
>  write(data)
>  close(/dev/hdX)
> 
> Ruth
> 
> -- 
> Ruth Ivimey-Cook
> Software engineer and technical writer.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

