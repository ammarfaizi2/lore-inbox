Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129431AbRAIU4r>; Tue, 9 Jan 2001 15:56:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129562AbRAIU4i>; Tue, 9 Jan 2001 15:56:38 -0500
Received: from gear.torque.net ([204.138.244.1]:55055 "EHLO gear.torque.net")
	by vger.kernel.org with ESMTP id <S129431AbRAIU4Y>;
	Tue, 9 Jan 2001 15:56:24 -0500
Message-ID: <3A5B7A2E.E3F964A8@torque.net>
Date: Tue, 09 Jan 2001 15:53:02 -0500
From: Douglas Gilbert <dougg@torque.net>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.4.0 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: linux-scsi@vger.kernel.org
Subject: Re: SCSI scanner problem with all kernels since 2.3.42
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Waugh wrote:
> I'm having problems with using xsane to acquire a preview from an HP
> ScanJet 5P connected to an AHA-2940.  2.3.42 is the last kernel that
> works right for me.
> 
> The symptom is that the scanner starts to make scanning sounds, then
> stops, and xsane says 'Error during read: Error during device I/O'.

Tim and I have been looking at this offline. The significance
of lk 2.3.43 was the addition of a new sg driver that has an
additional interface. Recent versions of SANE use that newer
sg interface. The problem that Tim reported seemed to be caused
by timeouts ** resulting in scsi bus resets. Anyway the problem
seems to disappear with the recently released SANE 1.0.4 .
[The original report was based on SANE 1.0.3 and earlier.]

There is also a problem report with the  SnapScan 1236 <--> aha152x 
combination also based on SANE 1.0.3 . This one is looking 
like an "uninitialized errno" bug fixed in SANE 1.0.4 .

** SANE's newer sg interface shortens the per command timeout
from 10 minutes to 10 seconds. Most other OSes interfaces in
SANE have a timeout value of 1 minute or more. I suspect 10 
seconds may be too short.

Doug Gilbert
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
