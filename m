Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318022AbSHQRPG>; Sat, 17 Aug 2002 13:15:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318026AbSHQRPG>; Sat, 17 Aug 2002 13:15:06 -0400
Received: from www.wotug.org ([194.106.52.201]:61496 "EHLO
	gatemaster.ivimey.org") by vger.kernel.org with ESMTP
	id <S318022AbSHQRPC>; Sat, 17 Aug 2002 13:15:02 -0400
Date: Sat, 17 Aug 2002 18:16:34 +0100 (BST)
From: Ruth Ivimey-Cook <Ruth.Ivimey-Cook@ivimey.org>
X-X-Sender: ruthc@sharra.ivimey.org
To: Andre Hedrick <andre@linux-ide.org>
cc: Matthias Andree <matthias.andree@stud.uni-dortmund.de>,
       <linux-kernel@vger.kernel.org>
Subject: Re: IDE?  IDE-TNG driver
In-Reply-To: <Pine.LNX.4.10.10208170455050.23171-100000@master.linux-ide.org>
Message-ID: <Pine.LNX.4.44.0208171812400.2705-100000@sharra.ivimey.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 17 Aug 2002, Andre Hedrick wrote:

>
>I will hand it to you guys on a silver platter IDE-TNG.
>
>Below yields modular chipsets and channel index registration.
>Selectable IOPS for arch independent Taskfile Transport layers.
...
>You have ide-cd registered on a cdrw and you want to burn a cd?
>open(/dev/hdX) transform_subdriver_scsi close(/dev/hdX)
>open(/dev/sg) and burn baby burn.
>close(/dev/sg) releases transform_subdriver_scsi
>open(/dev/hdX) load native atapi transport.


Andre, I see the thought, but surely this is prine to races and other 
difficulties.

Wouldn't it be better to provide an IDE ioctl() that enables the caller to use 
set the SCSI transport on an open FD, so your sequence becomes:

 open(/dev/hdX)
 ioctl(transform_subdriver_scsi)
 ioctl(scsi_ops)
 write(data)
 close(/dev/hdX)

Ruth

-- 
Ruth Ivimey-Cook
Software engineer and technical writer.

