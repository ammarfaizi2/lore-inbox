Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130157AbRAJAFK>; Tue, 9 Jan 2001 19:05:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132799AbRAJAFA>; Tue, 9 Jan 2001 19:05:00 -0500
Received: from oboe.it.uc3m.es ([163.117.139.101]:28431 "EHLO oboe.it.uc3m.es")
	by vger.kernel.org with ESMTP id <S130157AbRAJAEw>;
	Tue, 9 Jan 2001 19:04:52 -0500
From: "Peter T. Breuer" <ptb@oboe.it.uc3m.es>
Message-Id: <200101100004.f0A04j703901@oboe.it.uc3m.es>
Subject: Re: wild gettimeofday on smp under 2.2.18
In-Reply-To: From "(env:" "ptb)" at "Dec 28, 2000 11:26:12 pm"
To: ptb@it.uc3m.es
Date: Wed, 10 Jan 2001 01:04:45 +0100 (MET)
CC: "Alan Cox"@oboe.it.uc3m.es, alan@lxorguk.ukuu.org.uk,
        linux-kernel@vger.kernel.org
X-Anonymously-To: 
Reply-To: ptb@it.uc3m.es
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Alan Cox wrote:"
> Doesnt seem very wild to me, but something did go back 3uS which would imply
> the CPU tsc's are not synched. 2.2 doesnt like that, Boot with 'notsc' and
> repeat the experiment

No change with that, as you already know.  But I just noticed that the
ekernel was compiled for i386.  I've recompiled 2.2.18 for i686, and
this comes out of the boot messages:

  checking TSC synchronization across CPUs: 
  BIOS BUG: CPU#0 improperly initialized, has 2045320 usecs TSC skew!  FIXED.
  BIOS BUG: CPU#1 improperly initialized, has -2045320 usecs TSC skew!  FIXED.
  PCI: PCI BIOS revision 2.10 entry at 0xf0730

This is the ASUS BX dual board with onboard scsi.

But the FIXED above doesn't seem to be true. I still get results like
those below from gettimeofday calls every five seconds. Clearly two
mixed sequences ..

  978042124  !
  978042135    *
  978042134  !
  978042139  !
  978042144  !
  978042149  !
  978042158    *
  978042159  !
  978042164  !
  978042169  !
  978042176

Peter
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
