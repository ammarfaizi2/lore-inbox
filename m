Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262174AbSIZDnV>; Wed, 25 Sep 2002 23:43:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262175AbSIZDnV>; Wed, 25 Sep 2002 23:43:21 -0400
Received: from ausadmmsps306.aus.amer.dell.com ([143.166.224.101]:18182 "HELO
	AUSADMMSPS306.aus.amer.dell.com") by vger.kernel.org with SMTP
	id <S262174AbSIZDnU>; Wed, 25 Sep 2002 23:43:20 -0400
X-Server-Uuid: c21c953d-96eb-4242-880f-19bdb46bc876
Message-ID: <20BF5713E14D5B48AA289F72BD372D68C1E8C2@AUSXMPC122.aus.amer.dell.com>
From: Matt_Domsch@Dell.com
To: greg@kroah.com
cc: mochel@osdl.org, linux-kernel@vger.kernel.org
Subject: RE: devicefs requests
Date: Wed, 25 Sep 2002 22:48:31 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
X-WSS-ID: 118C5C1A890286-01-01
Content-Type: text/plain; 
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Um, what 64-bit unique id?  USB devices do not have such a thing.

The EDD spec (http://www.t13.org/docs2002/d1572r0.pdf - T13 committee
project 1572D BIOS Enhanced Disk Drive Services - 3) says:
USB identifier:  64-bit Serial Number as defined in the USB Mass Storage
specifications

I assume that they mean the USB Mass Storage spec v1.0
(http://www.usb.org/developers/data/devclass/usbmassbulk_10.pdf) section
4.1.1 - Serial Number, which is 12-16 bytes long.  drivers/usb/storage/usb.c
turns that into a 16-byte GUID in storage_probe().  I hadn't gotten so far
as to see that these two specs don't agree for USB - I'd been looking at the
IDE and SCSI descriptions so far.  It wouldn't be the first time the EDD
spec needed editing, and given that few (if any) BIOSs yet implement it
apart from SCSI, is reason for the confusion.

I don't think Dell has a T13 committee representative right now, but I'll
see if we have a process for getting this cleared up through official
channels.  As I'm not a USB expert, would you care to comment on the right
way to handle this (i.e. instead of a 64-bit serial number, use the 16-byte
GUID)?

Thanks,
Matt

--
Matt Domsch
Sr. Software Engineer, Lead Engineer, Architect
Dell Linux Solutions www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com
#1 US Linux Server provider for 2001 and Q1/2002! (IDC May 2002)

