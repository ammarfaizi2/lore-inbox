Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130157AbRAFI6O>; Sat, 6 Jan 2001 03:58:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130200AbRAFI6E>; Sat, 6 Jan 2001 03:58:04 -0500
Received: from austin.jhcloos.com ([206.224.83.202]:19216 "HELO
	austin.jhcloos.com") by vger.kernel.org with SMTP
	id <S130157AbRAFI5q>; Sat, 6 Jan 2001 03:57:46 -0500
To: linux-kernel@vger.kernel.org
Subject: ixj.o vs ixj_cs.o
From: "James H. Cloos Jr." <cloos@jhcloos.com>
Date: 06 Jan 2001 02:57:45 -0600
Message-ID: <m3zoh5njli.fsf@austin.jhcloos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If CONFIG_PCMCIA=y, CONFIG_PHONE!=n and CONFIG_IXJ=m, the resultant
ixj.o will support the (PCMCIA) internet phonecard, provided it is
insmod(8)ed as ixj_cs.o.

As such, were make modules_install (iff the above config) to:

  mkdir $(MODDIR)/kernel/drivers/telephony/pcmcia
  ln -s ../ixj.o $(MODDIR)/kernel/drivers/telephony/pcmcia/ixj_cs.o

things would Just Work.

But that just doesn't seem like the right solution.

Looks like were $(TOPDIR)/drivers/telephon/pcmcia to exist with
a suitable makefile to cp ../ixj.o ixj_cs.o iff the above config
things would also just work.

But I suspect ixj.c needs to be broken out, perhaps to ixj.c,
ixj-main.c and pcmcia/ixj_cs.c?  Or just a pcmcia/ixj_cs.c which
links against ../ixj.o?

What is the proper solution?

(And, for that matter, is this essentially the same problem the drm
tree has wrt modules?)

-JimC
-- 
James H. Cloos, Jr.  <http://jhcloos.com/public_key>     1024D/ED7DAEA6 
<cloos@jhcloos.com>  E9E9 F828 61A4 6EA9 0F2B  63E7 997A 9F17 ED7D AEA6

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
