Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287212AbSANMTB>; Mon, 14 Jan 2002 07:19:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287200AbSANMSl>; Mon, 14 Jan 2002 07:18:41 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:3858 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S274862AbSANMSd>; Mon, 14 Jan 2002 07:18:33 -0500
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
To: skraw@ithnet.com (Stephan von Krawczynski)
Date: Mon, 14 Jan 2002 12:29:53 +0000 (GMT)
Cc: akpm@zip.com.au (Andrew Morton), alan@lxorguk.ukuu.org.uk,
        zippel@linux-m68k.org, rml@tech9.net, ken@canit.se,
        arjan@fenrus.demon.nl, landley@trommello.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20020114124755.3b2d6a4d.skraw@ithnet.com> from "Stephan von Krawczynski" at Jan 14, 2002 12:47:55 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16Q6FN-0001bD-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > In eepro100.c, wait_for_cmd_done() can busywait for one millisecond
> > and is called multiple times under spinlock.
> 
> Did I get that right, as long as spinlocked no sense in conditional_schedule()
> ?

No conditional schedule, no pre-emption. You would need to rewrite that code
to do something like try for 100uS then queue a 1 tick timer to retry
asynchronously. That makes the code vastly more complex for an error case and
for some drivers where irq mask is required during reset waits won't help.

Yet again there are basically 1mS limitations buried in the hardware.
