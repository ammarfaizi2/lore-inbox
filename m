Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129965AbQLYObP>; Mon, 25 Dec 2000 09:31:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129880AbQLYObG>; Mon, 25 Dec 2000 09:31:06 -0500
Received: from cicero0.cybercity.dk ([212.242.40.52]:28178 "HELO
	cicero0.cybercity.dk") by vger.kernel.org with SMTP
	id <S130635AbQLYOax>; Mon, 25 Dec 2000 09:30:53 -0500
Date: Mon, 25 Dec 2000 15:01:07 +0100
From: Jens Axboe <axboe@suse.de>
To: Dave Gilbert <gilbertd@treblig.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: css hang; somewhere between test12 and test13pre4ac2
Message-ID: <20001225150107.D303@suse.de>
In-Reply-To: <20001225121037.B303@suse.de> <Pine.LNX.4.10.10012251336230.666-100000@tardis.home.dave>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="LQksG6bCIzRHxTLp"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.10.10012251336230.666-100000@tardis.home.dave>; from gilbertd@treblig.org on Mon, Dec 25, 2000 at 01:38:46PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--LQksG6bCIzRHxTLp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 25 2000, Dave Gilbert wrote:
> > The most likely suspect (as someone else pointed out) is not at
> > all css (I'm not even sure what you mean by css hang?) but UDF.
> 
> I mean a complete system hang when playing a CSS disc - doesn't even ping.
> Doesn't recover.

Hmm

> > Given the fs changes. Since sysrq still works, it would help a
> > lot if you could capture sysrq-p repeatedly and send it in.
> 
> I think at this point the only thing that works is sysrq-b - at least the
> sysrq-u's and sysrq-s's that I've given don't seem to have cleanly
> unmounted the file system.

Could you at least check? You may need some sort of serial console too..

> > Do you have any non-css discs to beat on UDF?
> 
> Yep one disc (Scanners) - it is fine - hence my reason for beleiving it is
> a CSSism (although I guess CSS makes other demands on the UDF code).

Not so. Once a css "session" has been established, data is read just
like off any other CD. But try with this patch applied, it could be
a NULL pointer deref at the wrong time.

-- 
* Jens Axboe <axboe@suse.de>
* SuSE Labs

--LQksG6bCIzRHxTLp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=idecd_log-2

--- drivers/ide/ide-cd.c~	Sat Dec 23 23:59:52 2000
+++ drivers/ide/ide-cd.c	Sun Dec 24 00:03:38 2000
@@ -333,7 +333,7 @@
 {
 	int log = 0;
 
-	if (sense == NULL || pc->quiet)
+	if (sense == NULL || pc == NULL || pc->quiet)
 		return 0;
 
 	switch (sense->sense_key) {

--LQksG6bCIzRHxTLp--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
