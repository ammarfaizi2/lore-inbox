Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284118AbRLTK6e>; Thu, 20 Dec 2001 05:58:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284088AbRLTK6Y>; Thu, 20 Dec 2001 05:58:24 -0500
Received: from 213.237.12.194.adsl.brh.worldonline.dk ([213.237.12.194]:15329
	"HELO firewall.jaquet.dk") by vger.kernel.org with SMTP
	id <S284118AbRLTK6S>; Thu, 20 Dec 2001 05:58:18 -0500
Date: Thu, 20 Dec 2001 11:58:10 +0100
From: Rasmus Andersen <rasmus@jaquet.dk>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.17-rc2
Message-ID: <20011220115810.N825@jaquet.dk>
In-Reply-To: <Pine.LNX.4.21.0112181824020.4821-100000@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.21.0112181824020.4821-100000@freak.distro.conectiva>; from marcelo@conectiva.com.br on Tue, Dec 18, 2001 at 06:26:03PM -0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 18, 2001 at 06:26:03PM -0200, Marcelo Tosatti wrote:
> 
> Hi,
> 
> So here it goes 2.4.17-rc2... as expected, bugfixes only.


Hi.

Due to the (hideous) construct of multiple drivers in drivers/scsi
doing #include "NCR5380.c", we need the following patch to make
NCR5380_timer_fn static.

--- linux-2417r2/drivers/scsi/NCR5380.c.old	Thu Dec 20 11:50:43 2001
+++ linux-2417r2/drivers/scsi/NCR5380.c	Thu Dec 20 11:45:48 2001
@@ -612,7 +612,7 @@
  *	Locks: disables irqs, takes and frees io_request_lock
  */
  
-void NCR5380_timer_fn(unsigned long unused)
+static void NCR5380_timer_fn(unsigned long unused)
 {
 	struct Scsi_Host *instance;
 

-- 
        Rasmus(rasmus@jaquet.dk)

If at first you don't succeed, chainsaw juggling is not for you.
 -- Anonymous
