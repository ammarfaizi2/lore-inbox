Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272344AbRHXXW2>; Fri, 24 Aug 2001 19:22:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272343AbRHXXWU>; Fri, 24 Aug 2001 19:22:20 -0400
Received: from aslan.scsiguy.com ([63.229.232.106]:62736 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S272344AbRHXXV7>; Fri, 24 Aug 2001 19:21:59 -0400
Message-Id: <200108242322.f7ONM7Y53087@aslan.scsiguy.com>
To: "chen, xiangping" <chen_xiangping@emc.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: A bug in the new aic7xxx.o driver in kernel 2.4.7 
In-Reply-To: Your message of "Tue, 07 Aug 2001 16:21:09 EDT."
             <276737EB1EC5D311AB950090273BEFDD043BC557@elway.lss.emc.com> 
Date: Fri, 24 Aug 2001 17:22:07 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>It fails to detected all the external scsi devices, and communicate with
>devices when there is a gap between lun numbers. If there is a gap, it
>omits devices from the absent lun number to the next 2 power # lun number,
>and I/O error after that.
>For example, if device /dev/scsi/host1/bus0/target1/lun7 is taken out
>from the system, the aic7xxx driver fails to detect disks from
>/dev/scsi/host1/bus0/target1/lun8
>to /dev/scsi/host1/bus0/target1/lun31, in stead jumps to ..../lun32,
>and fails to talk to the device ever since.
>
>Old aic7xxx driver is OK. 

You'll need to enable additional SCSI logging to determine what is going
on here.  The aic7xxx driver doesn't care about lun numbers really, and
doesn't have any code to "willy-nilly" reject some subset of luns just
because one was not probed.  What I really need to see is what error
code was returned by the aic7xxx driver when the attempt to probe the
"not found" lun occurs.  You should be able to instrument the non
"hardcoded" section of drivers/scsi/scsi_scan.c:scan_scsis() to get
this information.

--
Justin
