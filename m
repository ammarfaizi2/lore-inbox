Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289113AbSA1E7f>; Sun, 27 Jan 2002 23:59:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289114AbSA1E7R>; Sun, 27 Jan 2002 23:59:17 -0500
Received: from gear.torque.net ([204.138.244.1]:14858 "EHLO gear.torque.net")
	by vger.kernel.org with ESMTP id <S289113AbSA1E7A>;
	Sun, 27 Jan 2002 23:59:00 -0500
Message-ID: <3C54DA60.B78092E7@torque.net>
Date: Sun, 27 Jan 2002 23:58:08 -0500
From: Douglas Gilbert <dougg@torque.net>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Can't compile Symbios 53c416 SCSI support
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2002.01.28 01:41 Evgeniy Polyakov wrote:
> 
> > So i hope this patch will help a bit in this direction.
> 
> Ooops, forgot to attach.
> 
>       Evgeniy Polyakov ( s0mbre ).

Only the callbacks to scsi_done() need to be protected by
a spin_lock on host_lock. You may need to set up another
lock (driver or host specific) for the other case(s).

Unfortunately there are more problems with this driver
because it uses the old error handler scheme which has
been dropped in the lk 2.5 series. Compare the scsi_debug
driver in lk 2.5.2 with the one in lk 2.5.3-pre5 for an
example of what is involved. Start with the header and
look at the "eh_..." entries.

Good luck.

Doug Gilbert
