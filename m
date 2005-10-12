Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751073AbVJLRez@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751073AbVJLRez (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 13:34:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751097AbVJLRez
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 13:34:55 -0400
Received: from eurogra4543-2.clients.easynet.fr ([212.180.52.86]:64670 "HELO
	briare1.heliogroup.fr") by vger.kernel.org with SMTP
	id S1751073AbVJLRey (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 13:34:54 -0400
From: Hubert Tonneau <hubert.tonneau@fullpliant.org>
To: linux-kernel@vger.kernel.org
Subject: Re: MPT fusion driver, better but still buggy at errors handling under 2.6
Date: Wed, 12 Oct 2005 17:30:47 GMT
Message-ID: <05EN9ZB11@briare1.heliogroup.fr>
X-Mailer: Pliant 94
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hubert Tonneau wrote:
>
> 2.4.xx  recovers gracefully (only reading the kernel log will enable
>         to discover that a tiny problem did append).

Here is the report of the gracefull recovery the Linux 2.4.31 does as
opposed to Linux 2.6:

<4>scsi : aborting command due to timeout : pid 2232433, scsi0, channel 0, id 0, lun 0 0x2a 00 05 b6 3d 3f 00 00 80 00 
<4>mptscsih: OldAbort scheduling ABORT SCSI IO (sc=f79af800)
<4>scsi : aborting command due to timeout : pid 2232436, scsi0, channel 0, id 0, lun 0 0x2a 00 05 b6 3d bf 00 00 38 00 
<4>mptscsih: OldAbort scheduling ABORT SCSI IO (sc=f79af600)
<4>scsi : aborting command due to timeout : pid 2232437, scsi0, channel 0, id 0, lun 0 0x2a 00 05 b6 3d f7 00 00 48 00 
<4>mptscsih: OldAbort scheduling ABORT SCSI IO (sc=f79afa00)
<4>SCSI host 0 abort (pid 2232433) timed out - resetting
<4>SCSI bus is being reset for host 0 channel 0.
<4>mptscsih: OldReset scheduling BUS_RESET (sc=f79af800)
<4>SCSI host 0 abort (pid 2232436) timed out - resetting
<4>SCSI bus is being reset for host 0 channel 0.
<4>mptscsih: OldReset scheduling BUS_RESET (sc=f79af600)
<4>SCSI host 0 abort (pid 2232437) timed out - resetting
<4>SCSI bus is being reset for host 0 channel 0.
<4>mptscsih: OldReset scheduling BUS_RESET (sc=f79afa00)
<4>SCSI host 0 channel 0 reset (pid 2232433) timed out - trying harder
<4>SCSI bus is being reset for host 0 channel 0.
<4>mptscsih: OldReset scheduling BUS_RESET (sc=f79af800)
<4>SCSI host 0 channel 0 reset (pid 2232437) timed out - trying harder
<4>SCSI bus is being reset for host 0 channel 0.
<4>mptscsih: OldReset scheduling BUS_RESET (sc=f79afa00)
<4>SCSI host 0 reset (pid 2232433) timed out again -
<4>probably an unrecoverable SCSI bus or device hang.
<4>SCSI host 0 reset (pid 2232437) timed out again -
<4>probably an unrecoverable SCSI bus or device hang.
<4>SCSI Error: (0:0:0) Status=02h (CHECK CONDITION)
<4> Key=6h (UNIT ATTENTION); FRU=00h
<4> ASC/ASCQ=29h/02h "SCSI BUS RESET OCCURRED"
<4> CDB: 2A 00 05 B6 3D BF 00 00 38 00
<4>
<4>SCSI Error: (0:1:0) Status=02h (CHECK CONDITION)
<4> Key=6h (UNIT ATTENTION); FRU=00h
<4> ASC/ASCQ=29h/02h "SCSI BUS RESET OCCURRED"
<4> CDB: 28 00 05 B6 3E 3F 00 00 80 00
<4>
<4>scsi : aborting command due to timeout : pid 2232577, scsi0, channel 0, id 0, lun 0 0x2a 00 05 b6 41 3f 00 00 80 00 
<4>mptscsih: OldAbort scheduling ABORT SCSI IO (sc=f79af600)
<4>scsi : aborting command due to timeout : pid 2232580, scsi0, channel 0, id 0, lun 0 0x2a 00 05 b6 41 bf 00 00 18 00 
<4>mptscsih: OldAbort scheduling ABORT SCSI IO (sc=f79af800)
<4>scsi : aborting command due to timeout : pid 2232581, scsi0, channel 0, id 0, lun 0 0x2a 00 05 b6 41 d7 00 00 68 00 
<4>mptscsih: OldAbort scheduling ABORT SCSI IO (sc=f79afa00)
<4>SCSI host 0 abort (pid 2232577) timed out - resetting
<4>SCSI bus is being reset for host 0 channel 0.
<4>mptscsih: OldReset scheduling BUS_RESET (sc=f79af600)
<4>SCSI host 0 abort (pid 2232580) timed out - resetting
<4>SCSI bus is being reset for host 0 channel 0.
<4>mptscsih: OldReset scheduling BUS_RESET (sc=f79af800)
<4>SCSI host 0 abort (pid 2232581) timed out - resetting
<4>SCSI bus is being reset for host 0 channel 0.
<4>mptscsih: OldReset scheduling BUS_RESET (sc=f79afa00)
<4>SCSI host 0 channel 0 reset (pid 2232577) timed out - trying harder
<4>SCSI bus is being reset for host 0 channel 0.
<4>mptscsih: OldReset scheduling BUS_RESET (sc=f79af600)
<4>SCSI host 0 channel 0 reset (pid 2232580) timed out - trying harder
<4>SCSI bus is being reset for host 0 channel 0.
<4>mptscsih: OldReset scheduling BUS_RESET (sc=f79af800)
<4>SCSI host 0 channel 0 reset (pid 2232581) timed out - trying harder
<4>SCSI bus is being reset for host 0 channel 0.
<4>mptscsih: OldReset scheduling BUS_RESET (sc=f79afa00)
<4>SCSI host 0 reset (pid 2232577) timed out again -
<4>probably an unrecoverable SCSI bus or device hang.
<4>SCSI host 0 reset (pid 2232580) timed out again -
<4>probably an unrecoverable SCSI bus or device hang.
<4>SCSI host 0 reset (pid 2232581) timed out again -
<4>probably an unrecoverable SCSI bus or device hang.
<4>SCSI Error: (0:0:0) Status=02h (CHECK CONDITION)
<4> Key=6h (UNIT ATTENTION); FRU=00h
<4> ASC/ASCQ=29h/02h "SCSI BUS RESET OCCURRED"
<4> CDB: 2A 00 0D 38 DB 87 00 00 08 00
<4>
<4>SCSI Error: (0:1:0) Status=02h (CHECK CONDITION)
<4> Key=6h (UNIT ATTENTION); FRU=00h
<4> ASC/ASCQ=29h/02h "SCSI BUS RESET OCCURRED"
<4> CDB: 2A 00 0D 38 E2 C7 00 00 10 00
<4>

