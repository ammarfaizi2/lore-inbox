Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315631AbSFERVc>; Wed, 5 Jun 2002 13:21:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315630AbSFERVb>; Wed, 5 Jun 2002 13:21:31 -0400
Received: from grunt.ksu.ksu.edu ([129.130.12.17]:30913 "EHLO
	mailhub.cns.ksu.edu") by vger.kernel.org with ESMTP
	id <S315631AbSFERV3>; Wed, 5 Jun 2002 13:21:29 -0400
Date: Wed, 5 Jun 2002 12:21:29 -0500
From: Joseph Pingenot <trelane@digitasaru.net>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Build error on 2.5.20 under unstable debian
Message-ID: <20020605122129.A14027@ksu.edu>
Mail-Followup-To: Adrian Bunk <bunk@fs.tum.de>,
	linux-kernel@vger.kernel.org
In-Reply-To: <23055.1023262706@kao2.melbourne.sgi.com> <Pine.NEB.4.44.0206050958190.9994-100000@mimas.fachschaften.tu-muenchen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
X-School: Kansas State University
X-vi-or-emacs: vi
X-MSMail-Priority: High
X-Priority: 1 (Highest)
X-MS-TNEF-Correlator: <AFJAUFHRUOGRESULWAOIHFEAUIOFBVHSHNRAIU.monkey@spamcentral.invalid>
X-MimeOLE: Not Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From Adrian Bunk on Wednesday, 05 June, 2002:
>On Wed, 5 Jun 2002, Keith Owens wrote:
>uhci_stop is __devexit but the pointer to it doesn't use __devexit_p.
>The fix is simple:
>--- drivers/usb/host/uhci-hcd.c.old	Wed Jun  5 09:59:00 2002
>+++ drivers/usb/host/uhci-hcd.c	Wed Jun  5 10:13:09 2002
>@@ -2515,7 +2515,7 @@
> 	suspend:		uhci_suspend,
> 	resume:			uhci_resume,
> #endif
>-	stop:			uhci_stop,
>+	stop:			__devexit_p(uhci_stop),
>
> 	hcd_alloc:		uhci_hcd_alloc,
> 	hcd_free:		uhci_hcd_free,

Ah.  What does __devexit_p() do?  It looks to be some sort of macro,
  doing a cast?
And thanks, the patch solved the problem.  I'm currently running 2.5.20. :)

-Joseph
-- 
Joseph======================================================jap3003@ksu.edu
"Ich bin ein Penguin."  --/. poster mmarlett, responding to news that the
  Bundestag will move to IBM/SuSE Linux.  
                      http://slashdot.org/comments.pl?sid=33588&cid=3631032
