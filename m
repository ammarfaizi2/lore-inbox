Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279739AbRJYKCr>; Thu, 25 Oct 2001 06:02:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279741AbRJYKCi>; Thu, 25 Oct 2001 06:02:38 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:8717 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S279739AbRJYKCa>; Thu, 25 Oct 2001 06:02:30 -0400
Message-ID: <3BD7E327.C2D5B384@idb.hist.no>
Date: Thu, 25 Oct 2001 12:02:15 +0200
From: Helge Hafting <helgehaf@idb.hist.no>
X-Mailer: Mozilla 4.76 [no] (X11; U; Linux 2.4.13 i686)
X-Accept-Language: no, en
MIME-Version: 1.0
To: Rob Turk <r.turk@chello.nl>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] New Driver Model for 2.5
In-Reply-To: <20011024130408.23754@smtp.adsl.oleane.com> <Pine.LNX.4.33.0110240901350.8049-100000@penguin.transmeta.com> <9r8icv$ukh$1@ncc1701.cistron.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Turk wrote:

> Doing so will create havoc on sequential devices, such as tape drives. If
> your system simply suspends, then all is well. Any data that isn't flushed
> yet is buffered inside the tapedrive. But when the system resumes and resets
> the SCSI bus, it will cause all data in the tape drive to be lost, and for
> most tape systems it will also re-position them at LBOT. Any running
> tar/dump/whatever tape process would not survive such a suspend-resume
> cycle.
> 
Well, why reset the scsi bus on resume then?
That seems unnecessary.  At suspend time the devices simply 
don't get more requests. (Except perhaps spin-down 
requests for disks.)  Then nothing much happens.  Eventually
the system wakes up, and requests appear again.  First spin-up
requests, then ordinary io.

Quite a few scsi bioses have an option for not resetting
the bus when booting.  Less delay, and necessary for those
few with a shared scsi bus.  Seems a reset won't be
necessary for suspend/resume either, which is supposed to
be a lighter operation than a reboot.

If your scsi adapter don't support this - it isn't
suspend/resume compatible the way I see it.

Helge Hafting
