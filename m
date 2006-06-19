Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750932AbWFSRe6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750932AbWFSRe6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 13:34:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751075AbWFSRe4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 13:34:56 -0400
Received: from barracuda.s2io.com ([72.1.205.138]:43443 "EHLO
	barracuda.mail.s2io.com") by vger.kernel.org with ESMTP
	id S1750744AbWFSRez (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 13:34:55 -0400
X-ASG-Debug-ID: 1150738493-21764-2-0
X-Barracuda-URL: http://72.1.205.138:8000/cgi-bin/mark.cgi
Reply-To: <ravinandan.arakali@neterion.com>
From: "Ravinandan Arakali" <ravinandan.arakali@neterion.com>
To: "'Andrew Morton'" <akpm@osdl.org>, <tglx@linutronix.de>
Cc: <dgc@sgi.com>, <mingo@elte.hu>, <neilb@suse.de>, <jblunck@suse.de>,
       <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
       <viro@zeniv.linux.org.uk>, <balbir@in.ibm.com>,
       "Ananda. Raju \(E-mail\)" <ananda.raju@neterion.com>,
       "Leonid. Grossman \(E-mail\)" <leonid.grossman@neterion.com>
X-ASG-Orig-Subj: RE: [patch 0/5] [PATCH,RFC] vfs: per-superblock unused dentries list (2nd version)
Subject: RE: [patch 0/5] [PATCH,RFC] vfs: per-superblock unused dentries list (2nd version)
Date: Mon, 19 Jun 2006 10:34:38 -0700
Message-ID: <000101c693c6$a46c5a90$3e10100a@pc.s2io.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.6604 (9.0.2911.0)
Importance: Normal
In-Reply-To: <20060619040110.03b39673.akpm@osdl.org>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2869
X-Barracuda-Spam-Score: 0.60
X-Barracuda-Spam-Status: No, SCORE=0.60 using global scores of TAG_LEVEL=3.5 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=7.0 tests=COMMA_SUBJECT
X-Barracuda-Spam-Report: Code version 3.02, rules version 3.0.15101
	Rule breakdown below pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.60 COMMA_SUBJECT          Subject is like 'Re: FDSDS, this is a subject'
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,
This is a known problem and has been fixed in our internal source tree. We
will be submitting the patch soon.

Ravi

-----Original Message-----
From: Andrew Morton [mailto:akpm@osdl.org]
Sent: Monday, June 19, 2006 4:01 AM
To: tglx@linutronix.de; Ravinandan Arakali
Cc: dgc@sgi.com; mingo@elte.hu; neilb@suse.de; jblunck@suse.de;
linux-kernel@vger.kernel.org; linux-fsdevel@vger.kernel.org;
viro@zeniv.linux.org.uk; balbir@in.ibm.com
Subject: Re: [patch 0/5] [PATCH,RFC] vfs: per-superblock unused dentries
list (2nd version)


On Mon, 19 Jun 2006 12:48:44 +0200
Thomas Gleixner <tglx@linutronix.de> wrote:

> On Sun, 2006-06-18 at 23:33 -0700, Andrew Morton wrote:
> > > ....
> > >     eth3      device: S2io Inc. Xframe 10 Gigabit Ethernet PCI-X (rev
03)
> > >     eth3      configuration: eth-id-00:0c:fc:00:02:c8
> > > irq 60, desc: a0000001009a2d00, depth: 1, count: 0, unhandled: 0
> > > ->handle_irq():  0000000000000000, 0x0
> > > ->chip(): a000000100a0fe40, irq_type_sn+0x0/0x80
> > > ->action(): e00000b007471b80
> > > ->action->handler(): a0000002059373d0, s2io_msi_handle+0x1510/0x660
[s2io]    eth3
> > > IP address: 192.168.1.248/24
> > > Unexpected irq vector 0x3c on CPU 3!
> >
> > I guess that's where things start to go bad.  genirq changes?
>
> Hmm, The extra noisy printout is from geirq. The unhandled interrupt
> should be unrelated.
>
> The s2io driver enables interrupts in the card in start_nic() before
> requesting the interrupt itself with request_irq(). So I suspect thats a
> problem which has been there already, just the noisy printout makes it
> more visible

OK, that's not good.  It would be strange for the NIC to be aserting an
interrupt in that window though - the machine would end up taking a zillion
interrupts and would disable the whole IRQ line.

Still.  Ravinandan, could you take a look at fixing that up, please?  Wire
up the IRQ handler before enabling interrupts?

We still don't know why these things happened.

