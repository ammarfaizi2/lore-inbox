Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286403AbSAIN2Q>; Wed, 9 Jan 2002 08:28:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286411AbSAIN2J>; Wed, 9 Jan 2002 08:28:09 -0500
Received: from ns1.yggdrasil.com ([209.249.10.20]:54482 "EHLO
	ns1.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S286403AbSAIN2C>; Wed, 9 Jan 2002 08:28:02 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Wed, 9 Jan 2002 05:28:00 -0800
Message-Id: <200201091328.FAA07632@adam.yggdrasil.com>
To: admin@nextframe.net
Subject: Re: [PATCH] drivers/scsi/psi240i.c - io_request_lock fix
Cc: axboe@suse.de, dougg@torque.net, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> = Morten Helgesen
>  = Douglas Gilbert

>From the look of this line in the patch:
>> +       struct Scsi_Host *host = PsiHost[irq - 10];
>
>It will work if the first controller is allocated irq 10,
>the second one irq 11, etc.   Unlikely ...

	No, I think Morten has the use of PsiHost right.  The
entries in PsiHost are apparently stored by IRQ.  It is not generally
the case that the first controller is at PsiHost[0], the second at
PsiHost[1], etc.

	I agree with Jens in that the practice is rather ugly, but that
is the way the driver worked before io_request_lock disappeared and
I think that improving that stylistic issue is not a prerequisite
for conversion from io_request_lock to host->host_lock.

	If I were you, Morten, I would go ahead with your patch
that makes the minimal changes and then, if you want, make stylistic
improvements as one or more separate patches, which are something
that you may want to talk over with the mainter of that driver, if
there currently is one.

Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."
