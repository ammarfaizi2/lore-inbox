Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932071AbVILQej@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932071AbVILQej (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 12:34:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932074AbVILQej
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 12:34:39 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:60098 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932071AbVILQei (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 12:34:38 -0400
Date: Mon, 12 Sep 2005 11:34:32 -0500
From: serue@us.ibm.com
To: Alan Cox <alan@redhat.com>
Cc: Joel Schopp <jschopp@austin.ibm.com>,
       "Martin J. Bligh" <mbligh@mbligh.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: tty patches in 2.6.13-mm3 (was Re: 2.6.13-mm1)
Message-ID: <20050912163432.GA6119@sergelap.austin.ibm.com>
References: <20050901035542.1c621af6.akpm@osdl.org> <6970000.1125584568@[10.10.2.4]> <20050901145006.GF5427@devserv.devel.redhat.com> <43176AE8.8060105@austin.ibm.com> <20050901211647.GC25405@devserv.devel.redhat.com> <431771EA.4030809@austin.ibm.com> <20050901214411.GD25405@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050901214411.GD25405@devserv.devel.redhat.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Alan Cox (alan@redhat.com):
> On Thu, Sep 01, 2005 at 04:26:02PM -0500, Joel Schopp wrote:
> > It's like whack a mole.  30 more now in drivers/serial/jsm/jsm_tty.c and 
> >  drivers/serial/icom.c

Hi,

I'm not sure whether these are going in through some other channel,
but I notice neither the Alan's hvcs.c or icom.c patches are in
2.6.13-mm3.  In addition, hvc_console.c needs yet another...

> Keep whacking - obviously I don't have a PPC64 (*and please don't send
> me one*)

I do have one, but have been gone for awhile.  But am willing and
eager to test (and get it working again :)

thanks,
-serge

Signed-off-by: Serge Hallyn <serue@us.ibm.com>

Index: linux-2.6.12/drivers/char/hvc_console.c
===================================================================
--- linux-2.6.12.orig/drivers/char/hvc_console.c	2005-09-12 15:08:41.000000000 -0500
+++ linux-2.6.12/drivers/char/hvc_console.c	2005-09-12 15:52:08.000000000 -0500
@@ -597,7 +597,7 @@ static int hvc_poll(struct hvc_struct *h
 
 	/* Read data if any */
 	for (;;) {
-		count = tty_buffer_request_room(tty, N_INBUF);
+		int count = tty_buffer_request_room(tty, N_INBUF);
 
 		/* If flip is full, just reschedule a later read */
 		if (count == 0) {
@@ -633,7 +633,7 @@ static int hvc_poll(struct hvc_struct *h
 			tty_insert_flip_char(tty, buf[i], 0);
 		}
 
-		if (tty->flip.count)
+		if (tty_buffer_request_room(tty, 1))
 			tty_schedule_flip(tty);
 
 		/*
