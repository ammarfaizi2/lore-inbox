Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316892AbSFKHpX>; Tue, 11 Jun 2002 03:45:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316895AbSFKHpW>; Tue, 11 Jun 2002 03:45:22 -0400
Received: from mail.medav.de ([213.95.12.190]:8714 "HELO mail.medav.de")
	by vger.kernel.org with SMTP id <S316892AbSFKHpP> convert rfc822-to-8bit;
	Tue, 11 Jun 2002 03:45:15 -0400
From: "Daniela Engert" <dani@ngrt.de>
To: "Martin Wilck" <Martin.Wilck@Fujitsu-Siemens.com>
Cc: "Linux Kernel mailing list" <linux-kernel@vger.kernel.org>
Date: Tue, 11 Jun 2002 09:45:20 +0200 (CDT)
Reply-To: "Daniela Engert" <dani@ngrt.de>
X-Mailer: PMMail 2.00.1500 for OS/2 Warp 4.05
In-Reply-To: <1023780145.23733.352.camel@biker.pdb.fsc.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Subject: Re: Serverworks OSB4 in impossible state
Message-Id: <20020611064201.9F55DEDBE@mail.medav.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11 Jun 2002 09:22:24 +0200, Martin Wilck wrote:

>Am Mon, 2002-06-10 um 18.41 schrieb Daniela Engert:

>> The intersting bits of the DMA status register are bits 0 though 2. A
>> value of 5 indicates the condition "interrupt from unit, DMA state
>> machine active". This is a valid status! It basically means the unit
>> issued an interrupt before the PRD table is exhausted. This makes sense
>> because the CD-ROM units fails to transfer the amount of data described
>> by the PRD table because of the non-recoverable read error.
>
>Shouldn't the error bit be set too? (But that wouldn't make any
>difference with the current driver ...)

No it shouldn't. The error is happening on the unit side and not on the
host side of the bus. Thus it is correct that the host is *not*
reporting an error (which is true) but only the CD-ROM unit.

>> What you makes sense (the next DMA transfer is scheduled but never
>> carried out by the CD-ROM unit) except for the panic, ofcoz. The
>> correct driver action in this case were stopping the DMA engine and
>> issuing a reset of the state machines involved (both on the host and
>> the unit side).
>
>The message, the comments in the code, and what Alan wrote here:
>http://groups.google.com/groups?hl=de&lr=&threadm=linux.kernel.Pine.LNX.4.31.0206031234370.12103-100000%40boxer.fnal.gov&rnum=2&prev=/groups%3Fq%3Dosb4-bug%2540ide.cabal.tm%26hl%3Dde%26lr%3D%26selm%3Dlinux.kernel.Pine.LNX.4.31.0206031234370.12103-100000%2540boxer.fnal.gov%26rnum%3D2
>suggest that trying to recover from this condition is extremely
>dangerous (note that the kernel doesn't even panic(), because
>a sync() may kill a disk, the comments say).

I'm aware of all of that. By pure chance I have a machine with an OSB4
sitting on my desk for a couple of days. May be I can find a defect
CD-ROM to test it with my driver and see if it manages to recover from
errors like these. Hopefully, the PCI tracer gives some more insight.

Ciao,
  Dani

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Daniela Engert, systems engineer at MEDAV GmbH
Gräfenberger Str. 34, 91080 Uttenreuth, Germany
Phone ++49-9131-583-348, Fax ++49-9131-583-11


