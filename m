Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130413AbQJ1DoS>; Fri, 27 Oct 2000 23:44:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130705AbQJ1DoI>; Fri, 27 Oct 2000 23:44:08 -0400
Received: from north.net.CSUChico.EDU ([132.241.66.18]:41228 "EHLO
	north.net.csuchico.edu") by vger.kernel.org with ESMTP
	id <S130413AbQJ1Dn6>; Fri, 27 Oct 2000 23:43:58 -0400
Date: Fri, 27 Oct 2000 20:43:45 -0700
From: John Kennedy <jk@csuchico.edu>
To: Jonathan Hudson <jonathan@daria.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: pcmcia in test10pre6
Message-ID: <20001027204345.A19055@north.csuchico.edu>
In-Reply-To: <648.39f967c2.1f52d@trespassersw.daria.co.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="UugvWAfsgieZRqgk"
X-Mailer: Mutt 1.0.1i
In-Reply-To: <648.39f967c2.1f52d@trespassersw.daria.co.uk>; from jonathan@daria.co.uk on Fri, Oct 27, 2000 at 11:32:18AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=us-ascii

On Fri, Oct 27, 2000 at 11:32:18AM +0000, Jonathan Hudson wrote:
> Previously working in test10pre*, now gives many unresolved symbols: ...

  I didn't get nearly that many.  In fact, I only got this one:

	...
	        -o vmlinux
	drivers/pcmcia/pcmcia.o: In function `CardServices':
	drivers/pcmcia/pcmcia.o(.text+0x3b53): undefined reference to `pcmcia_request_irq'
	drivers/pcmcia/pcmcia.o(__ksymtab+0x160): undefined reference to `pcmcia_request_irq'
	make: *** [vmlinux] Error 1

  This seems to be the fatal change:

    [diff -u linux-2.4.0-test10pre[56]/drivers/pcmcia/cs.c | grep _request_irq]
	-int pcmcia_request_irq(client_handle_t handle, irq_req_t *req)
	+static int cs_request_irq(client_handle_t handle, irq_req_t *req)

  I see it mentioned in a number of places:

	drivers/net/pcmcia/ray_cs.c
	drivers/pcmcia/cs.c
	include/pcmcia/cs.h

  This patch compiles, but I haven't tested it yet (not home with laptop).


--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=PATCH

--- ./drivers/pcmcia/cs.c.OLD	Fri Oct 27 10:14:53 2000
+++ ./drivers/pcmcia/cs.c	Fri Oct 27 20:39:55 2000
@@ -1836,7 +1836,7 @@
     
 ======================================================================*/
 
-static int cs_request_irq(client_handle_t handle, irq_req_t *req)
+int pcmcia_request_irq(client_handle_t handle, irq_req_t *req)
 {
     socket_info_t *s;
     config_t *c;

--UugvWAfsgieZRqgk--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
