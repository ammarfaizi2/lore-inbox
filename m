Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262706AbTELVBK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 17:01:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262709AbTELVBK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 17:01:10 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:9424 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262706AbTELVBI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 17:01:08 -0400
Date: Mon, 12 May 2003 14:09:59 -0700
From: Patrick Mansfield <patmans@us.ibm.com>
To: Douglas Gilbert <dgilbert@interlog.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: removing a single device?
Message-ID: <20030512140959.A2762@beaverton.ibm.com>
References: <3EBC43CC.3090808@interlog.com> <20030512141255.GA30094@rdlg.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030512141255.GA30094@rdlg.net>; from Robert.L.Harris@rdlg.net on Mon, May 12, 2003 at 10:12:55AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert -

On Mon, May 12, 2003 at 10:12:55AM -0400, Robert L. Harris wrote:

> /proc/scsi/scsi does still show the device:
> 
> Host: scsi1 Channel: 00 Id: 01 Lun: 00
>   Vendor: 3ware    Model: 3w-xxxx          Rev: 1.0 
>   Type:   Direct-Access                    ANSI SCSI revision: ffffffff
> 
> and the echo, remove below doesn't remove it.  It does happily though
> work on some other systems with SCA interfaces.

> > > echo "scsi add-single-device 0 0 11 0" > /proc/scsi/scsi
> > > echo "scsi remove-single-device 0 0 11 0" > /proc/scsi/scsi

If this is for the host/channel/id/lun as per your cat /proc/scsi/scsi,
you are specifying id (target) 11, where you should have used 1.

You can also check the result of the write to see if it worked, not sure
if it does anything on 2.4 when the device does not exist, on 2.5 trying to
remove a non-existent device gives me:

[root@elm3b79 root]# echo "scsi remove-single-device 1 2 3 4" > /proc/scsi/scsi
[root@elm3b79 root]# echo $?
1

-- Patrick Mansfield
