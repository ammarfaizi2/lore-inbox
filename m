Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310190AbSHVQW6>; Thu, 22 Aug 2002 12:22:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312560AbSHVQW6>; Thu, 22 Aug 2002 12:22:58 -0400
Received: from codepoet.org ([166.70.99.138]:18922 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id <S310190AbSHVQW5>;
	Thu, 22 Aug 2002 12:22:57 -0400
Date: Thu, 22 Aug 2002 10:27:05 -0600
From: Erik Andersen <andersen@codepoet.org>
To: Alan Cox <alan@redhat.com>
Cc: Andre Hedrick <andre@linux-ide.org>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.20-pre2-ac6
Message-ID: <20020822162705.GA7510@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Alan Cox <alan@redhat.com>, Andre Hedrick <andre@linux-ide.org>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.10.10208211828570.10353-100000@master.linux-ide.org> <200208221606.g7MG6uF24237@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200208221606.g7MG6uF24237@devserv.devel.redhat.com>
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux 2.4.18-rmk7, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu Aug 22, 2002 at 12:06:56PM -0400, Alan Cox wrote:
> > Erm Alan, what happened boss ?
> > Lemme resend that jewel.
> 
> I dont think you ever sent me code with that one included


I believe it was supposed to be this patch I wrote up a while
back.  Though I can't imagine it needing a config option...

--- orig/drivers/ide/ide-cd.c	Sat Aug 10 23:40:44 2002
+++ linux-2.4.19/drivers/ide/ide-cd.c	Sat Aug 10 23:40:44 2002
@@ -768,6 +768,11 @@
 			   for other errors. */
 			*startstop = DRIVER(drive)->error(drive, "cdrom_decode_status", stat);
 			return 1;
+		} else if (sense_key == MEDIUM_ERROR) {
+			/* No point in re-trying a zillion times on a bad 
+			 * sector...  If we got here the error is not correctable */
+			ide_dump_status (drive, "media error (bad sector)", stat);
+			cdrom_end_request(drive, 0);
 		} else if ((++rq->errors > ERROR_MAX)) {
 			/* We've racked up too many retries.  Abort. */
 			cdrom_end_request(drive, 0);

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
