Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261594AbREURM7>; Mon, 21 May 2001 13:12:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261596AbREURMt>; Mon, 21 May 2001 13:12:49 -0400
Received: from supelec.supelec.fr ([160.228.120.192]:17415 "EHLO
	supelec.supelec.fr") by vger.kernel.org with ESMTP
	id <S261594AbREURMh>; Mon, 21 May 2001 13:12:37 -0400
Message-ID: <3B094CBF.A1F36F3D@supelec.fr>
Date: Mon, 21 May 2001 19:13:35 +0200
From: francois.cami@supelec.fr
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Andrew Morton <andrewm@uow.edu.au>, linux-kernel@vger.kernel.org
Subject: 3C905C and error e401 : problem solved
In-Reply-To: <20010521090946.D769@ipex.cz> <3B08C15E.264AE074@uow.edu.au>,
			<3B08C15E.264AE074@uow.edu.au> <20010521140443.C8397@ipex.cz> <3B090645.9D54574F@uow.edu.au>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Mr Morton and all linux-kernel,

I have been experimenting with the 3C905C, trying
to get rid of the annoying e401 error (too much work
in interrupt).

I've tried using 64 as max_interrupt_work 
and it solves completely
the e401 problem on this particular machine :

- yoda.rez-gif.supelec.fr (dns/proxy for 500 clients,
  on a 10Mbits/s direct Internet connexion, local
  network is 100Mbits/s)
	ASUS P2B-DS
	dual PII-350
	512MB RAM (2*128+1*256)
	3*IBM 18GB 10KT U2W SCSI 
	3C905C
	S3 Virge
Linux Slackware-current, 2.2.19 or 2.4.4 both built for smp
with APIC. 

Before setting max_interrupt_work at 64, the e401 error
could occur 20 times a day.
Now it doesn't occur anymore.

I have waited for a long time to test that on the
SMP PC because it is critical for our network.
I have tried to link these e401 messages with another
activity on the PC, like heavy I/O, to no avail. The
3C905C does 10 times as many interruptions as the SCSI
controller does. Lowering the max_interrupt_work creates
a lot more errors in the logs (all are e401).


On that second PC, the message still appears (very rarely though,
about once in two or three days. I cannot relate those
occurences to anything). It used to appear very often
(about 40 times a day).
I have tried to put the machine under stress (4 heavy FTP
transfers at once, each 400MB long, with 4 different
clients, connected in 100 MBits FD). The e401 message
has not appeared... I'm a bit at a loss here.

- lando.rez-gif.supelec.fr (FTP for the same network)
	ABIT LX6
	PII300
	128MB RAM
	IBM 8.4GB IDE (1st Master) 
         + Maxtor 60GB IDE (2nd Master)
	3C905C
	S3 Virge
Linux Slackware-current, 2.4.4, ProFTPD

All our network is 100MBits Full Duplex, switched
with 3COM switches.

Best regards, thanks for all your work

François Cami
