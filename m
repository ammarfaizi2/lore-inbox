Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132737AbRDXDlw>; Mon, 23 Apr 2001 23:41:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132738AbRDXDlm>; Mon, 23 Apr 2001 23:41:42 -0400
Received: from gear.torque.net ([204.138.244.1]:58378 "EHLO gear.torque.net")
	by vger.kernel.org with ESMTP id <S132737AbRDXDld>;
	Mon, 23 Apr 2001 23:41:33 -0400
Message-ID: <3AE4F3D2.6ACA810D@torque.net>
Date: Mon, 23 Apr 2001 23:32:34 -0400
From: Douglas Gilbert <dougg@torque.net>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3-ac11 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Matt_Domsch@Dell.com
CC: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk, jlundell@pobox.com
Subject: Re: [RFC][PATCH] adding PCI bus information to SCSI layer
In-Reply-To: <CDF99E351003D311A8B0009027457F140810E265@ausxmrr501.us.dell.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt_Domsch@Dell.com wrote:
> 
> [snip]
> 
> Doug suggested looking at extending scsimon.  This is a fine idea, and I've
> made proposed changes available at http://domsch.com/linux/scsi/.  (Doug may
> want to clean this up).  However, this, like my earlier changes to
> /proc/scsi/scsi, doesn't actually show the relationship between /dev/sda and
> a particular PCI controller and SCSI channel,bus,lun tuple.

Changes look ok. One suggestion: if a #define SCSI_PCI_INFO
(or some such) is defined in driver/scsi/scsi.h as part of
the patch then code like Matt is suggesting can be safely 
added, protected by "#ifdef SCSI_PCI_INFO ... #endif" blocks. 
I have used this technique in sg to support the scsi 
"reset+reservation" patch which still hasn't made it into 
the mid level (but is available in many distros).

The scsimon driver is just a window through to the information
held in the mid level structures. The information printed by
'cat /proc/scsi/scsi' also comes from the mid level. The scsi 
minor device numbers (e.g. /dev/sda) are allocated by each upper 
level driver  (e.g. sd_attach() in the case of sd) and are held 
in upper level driver data structures. Hence they are not 
visible to the mid-level or to other upper level drivers.

As an example of the latter point, using st and sg on the same 
tape device at the same time will most likely confuse st 
(since it maintains a state machine). However there is no 
simple way for the sg or st drivers to detect (or supply
information flagging) this conflict.

Doug Gilbert

