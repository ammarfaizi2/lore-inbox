Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266940AbTAISqu>; Thu, 9 Jan 2003 13:46:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266941AbTAISqt>; Thu, 9 Jan 2003 13:46:49 -0500
Received: from bi01p1.co.us.ibm.com ([32.97.110.142]:8393 "EHLO w-patman.des")
	by vger.kernel.org with ESMTP id <S266940AbTAISqs>;
	Thu, 9 Jan 2003 13:46:48 -0500
Date: Thu, 9 Jan 2003 10:53:29 -0800
From: Patrick Mansfield <patmans@us.ibm.com>
To: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: USB-storage/SCSI panic/error writing CF card
Message-ID: <20030109105329.A8326@beaverton.ibm.com>
References: <20030109183614.GA1167@Master.Wizards>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030109183614.GA1167@Master.Wizards>; from murrayr@brain.org on Thu, Jan 09, 2003 at 01:36:14PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 09, 2003 at 01:36:14PM -0500, Murray J. Root wrote:

> Writing to the card sometimes hangs the process when unmounting 
> 
> Sometimes the data IS written to the card first, then it hangs the process.
> 
> Sometimes the card is corrupt (cannot cd to the mountpoint -I/O error)
>   /var/log/messages has several lines like:
>   Jan  9 13:08:51 Master kernel: FAT: Filesystem panic (dev sd(8,1))
>   Jan  9 13:08:51 Master kernel:     Directory 4: invalid cluster chain
>   
> Sometimes get kernel panic with ONLY these 2 lines:
>   "Error handler thread not present at f7a57000 f7bf0d80 drivers/scsi/scsi-error.c 154"
>   "In interrupt handler - not syncing"
>   No messages in logs

The panic is caused by timeout on a scsi command when the error handler
has unexpectedly gone away, possibly because of this bug, where the erorr
handler exits early because of a SIGHUP:

http://marc.theaimsgroup.com/?l=linux-scsi&m=104145526331820&w=2

Fixing the panic won't fix the corruption. scsi should really offline the
adapter and scsi devices on the adapter rather than panic.

-- Patrick Mansfield
