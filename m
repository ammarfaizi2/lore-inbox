Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129047AbRBHAEx>; Wed, 7 Feb 2001 19:04:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129169AbRBHAEn>; Wed, 7 Feb 2001 19:04:43 -0500
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:22336 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S129047AbRBHAEZ>; Wed, 7 Feb 2001 19:04:25 -0500
Message-ID: <3A81E230.E0482280@redhat.com>
Date: Wed, 07 Feb 2001 19:02:56 -0500
From: Doug Ledford <dledford@redhat.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.17-11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "J . A . Magallon" <jamagallon@able.es>
CC: Tigran Aivazian <tigran@veritas.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: [bug] aic7xxx panic Re: Linux 2.4.1-ac5
In-Reply-To: <E14QbMw-0001JD-00@the-village.bc.nu> <Pine.LNX.4.21.0102072113080.1699-100000@penguin.homenet> <20010208002950.A1254@werewolf.able.es>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"J . A . Magallon" wrote:
> 
> On 02.07 Tigran Aivazian wrote:
> > Alan, Doug,
> >
> > If this is a known problem -- ignore. Otherwise, I will gladly assist as
> > much as you need.
> >
> > Just tried ac5 kernel and, behold (btw, why does serial console not work
> > anymore, I had to copy these by hand):
> >
> > (scsi0) BRKADRINT error(0x44):
> >   Illegal Opcode in sequencer program
> >   PCI Error detected
> > (scsi0)  SEQADDR=0x58
> > Kernel panic: aic7xxx: unrecoverable BRKADRINT
> >
> > The Linux 2.4.2-pre1 works fine. Next thing I was thinking was to try ac4
> > and also to try on a different machine which has a different revision of
> > the same type of aic7xxx HBA.
> >
> 
> I am running ac5 on a  AHA-2940U2/W, no problem.
> 
> I patched the kernel with a patch from Doug Ledford posted in the list.

Problems with disks and CD-ROMs connected to non-Ultra2 controllers is
confirmed and I think my fix is just about done (currently testing a minor
sequencer change to solve the problem, I cleared SG_COUNT when I shouldn't
have, which meant disconnects in the middle of a transfer spelled death for
the transfer, resulting in a data overrun on reconnect, and this problem only
shows up on non-Ultra2 controllers under real transfers scenarios, which my
testing missed because I was using all Ultra2 controllers, so I built another
test machine with non-Ultra2 controllers to check my fix)

-- 

 Doug Ledford <dledford@redhat.com>  http://people.redhat.com/dledford
      Please check my web site for aic7xxx updates/answers before
                      e-mailing me about problems
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
