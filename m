Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266552AbTBKWit>; Tue, 11 Feb 2003 17:38:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266638AbTBKWit>; Tue, 11 Feb 2003 17:38:49 -0500
Received: from packet.digeo.com ([12.110.80.53]:1976 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S266552AbTBKWip>;
	Tue, 11 Feb 2003 17:38:45 -0500
Date: Tue, 11 Feb 2003 14:47:24 -0800
From: Andrew Morton <akpm@digeo.com>
To: "Zephaniah E\. Hull" <warp@mercury.d2dc.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.5.60
Message-Id: <20030211144724.25de5820.akpm@digeo.com>
In-Reply-To: <20030211151615.GA1310@babylon.d2dc.net>
References: <Pine.LNX.4.44.0302101103570.1348-100000@penguin.transmeta.com>
	<20030211151615.GA1310@babylon.d2dc.net>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 11 Feb 2003 22:48:25.0285 (UTC) FILETIME=[AFAB3F50:01C2D21F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Zephaniah E\. Hull" <warp@mercury.d2dc.net> wrote:
>
> Interesting BUG() on boot up.
> 

The EATA driver's locking in there is so wrong I don't know how to begin to
describe it ;)  Looks like a misguided cli() conversion.

Does this get you up and running?

 scsi/eata.c |    4 ----
 1 files changed, 4 deletions(-)

diff -puN drivers/scsi/eata.c~eata-detect-fix drivers/scsi/eata.c
--- 25/drivers/scsi/eata.c~eata-detect-fix	2003-02-11 14:46:21.000000000 -0800
+++ 25-akpm/drivers/scsi/eata.c	2003-02-11 14:46:37.000000000 -0800
@@ -1450,9 +1450,6 @@ static void add_pci_ports(void) {
 
 static int eata2x_detect(Scsi_Host_Template *tpnt) {
    unsigned int j = 0, k;
-   unsigned long spin_flags;
-
-   spin_lock_irqsave(&driver_lock, spin_flags);
 
    tpnt->proc_name = "eata2x";
 
@@ -1490,7 +1487,6 @@ static int eata2x_detect(Scsi_Host_Templ
       }
 
    num_boards = j;
-   spin_unlock_irqrestore(&driver_lock, spin_flags);
    return j;
 }
 

_

