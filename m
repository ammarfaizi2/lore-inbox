Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316878AbSFKHVh>; Tue, 11 Jun 2002 03:21:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316880AbSFKHVg>; Tue, 11 Jun 2002 03:21:36 -0400
Received: from nixpbe.pdb.siemens.de ([192.109.2.33]:25771 "EHLO
	nixpbe.pdb.sbs.de") by vger.kernel.org with ESMTP
	id <S316878AbSFKHVf>; Tue, 11 Jun 2002 03:21:35 -0400
Subject: Re: Serverworks OSB4 in impossible state
From: Martin Wilck <Martin.Wilck@Fujitsu-Siemens.com>
To: Daniela Engert <dani@ngrt.de>
Cc: Linux Kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <200206101642.SAA30947@myway.myway.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 11 Jun 2002 09:22:24 +0200
Message-Id: <1023780145.23733.352.camel@biker.pdb.fsc.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mon, 2002-06-10 um 18.41 schrieb Daniela Engert:

> The intersting bits of the DMA status register are bits 0 though 2. A
> value of 5 indicates the condition "interrupt from unit, DMA state
> machine active". This is a valid status! It basically means the unit
> issued an interrupt before the PRD table is exhausted. This makes sense
> because the CD-ROM units fails to transfer the amount of data described
> by the PRD table because of the non-recoverable read error.

Shouldn't the error bit be set too? (But that wouldn't make any
difference with the current driver ...)

> What you makes sense (the next DMA transfer is scheduled but never
> carried out by the CD-ROM unit) except for the panic, ofcoz. The
> correct driver action in this case were stopping the DMA engine and
> issuing a reset of the state machines involved (both on the host and
> the unit side).

The message, the comments in the code, and what Alan wrote here:
http://groups.google.com/groups?hl=de&lr=&threadm=linux.kernel.Pine.LNX.4.31.0206031234370.12103-100000%40boxer.fnal.gov&rnum=2&prev=/groups%3Fq%3Dosb4-bug%2540ide.cabal.tm%26hl%3Dde%26lr%3D%26selm%3Dlinux.kernel.Pine.LNX.4.31.0206031234370.12103-100000%2540boxer.fnal.gov%26rnum%3D2
suggest that trying to recover from this condition is extremely
dangerous (note that the kernel doesn't even panic(), because
a sync() may kill a disk, the comments say).

Anyway, thanks a lot for your insightful comments.
Martin

-- 
Martin Wilck                Phone: +49 5251 8 15113
Fujitsu Siemens Computers   Fax:   +49 5251 8 20409
Heinz-Nixdorf-Ring 1	    mailto:Martin.Wilck@Fujitsu-Siemens.com
D-33106 Paderborn           http://www.fujitsu-siemens.com/primergy





