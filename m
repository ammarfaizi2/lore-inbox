Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750958AbVIVSnb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750958AbVIVSnb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 14:43:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751096AbVIVSnb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 14:43:31 -0400
Received: from web34409.mail.mud.yahoo.com ([66.163.178.158]:33653 "HELO
	web34409.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750958AbVIVSna (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 14:43:30 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=X9eQupOrnyj0CvluxPaSMRMyFqaE5MR/d3bYsxnLP3hEqOBZ0sUXdevG6aVqBU/lT6R5oTjzWCKTW5P/lb5rFw+xy8vQvTKE9xtU+oasOyoHZOUIuBuALuQIX1cboXFWwiGuARVOVrBQ1RcB6CEyycojH7QJywwR+qF11U9i+ZE=  ;
Message-ID: <20050922184324.235.qmail@web34409.mail.mud.yahoo.com>
Date: Thu, 22 Sep 2005 11:43:24 -0700 (PDT)
From: <jscottkasten@yahoo.com>
Subject: Re: data loss on jffs2 filesystem on dataflash
To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>,
       "Artem B. Bityutskiy" <dedekind@yandex.ru>
Cc: Valdis.Kletnieks@vt.edu, Pavel Machek <pavel@ucw.cz>,
       J Engel <joern@wohnheim.fh-wedel.de>,
       Peter Menzebach <pm-mtd@mw-itcon.de>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0509221306350.4631@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Actually, 3 years ago, I researched this in my
company's lab.  There is about a 1 in 180 probability
of the power to the read/write head failing before the
sector write is complete.

The end result is a sector that fails ECC check.  The
linux kernel reports this and your I/O operation
returns with an error.

Not easy, but if you force a rewrite of the sector,
the problem cures itself.  Not easy to do through the
VFS though.  I was only able to make it happen by
using dd if=/dev/zero on the unmounted device node. 
After that, the sector read just fine.

-Scott Kasten-

--- "linux-os (Dick Johnson)" <linux-os@analogic.com>
wrote:

> 
> On Thu, 22 Sep 2005, Artem B. Bityutskiy wrote:
> 
> > Valdis.Kletnieks@vt.edu wrote:
> >> On Thu, 22 Sep 2005 14:48:39 +0400, "Artem B.
> Bityutskiy" said:
> >>
> >>> Joern meant that if HDD starts a block write
> operation, it will
> >>> accomplish it even if power-fail happens
> (probably there are some
> >>> capacitors there). So, it is impossible, say,
> that HDD has written one
> >>> half of a sector and has not written the other
> half.
> >>
> >> Hard drives contain capacitors to prevent writing
> of runt sectors on
> >> a powerfail?  Didn't we go around this a while
> ago and decide it's mostly
> >> urban legend, and that plenty of people have seen
> runt/bad sectors?
> >
> > No idea. But theoretically it should be so, at
> least "good" drives
> > should. May be a competent person will comment on
> this, that's quite
> > interesting.
> >
> > --
> > Best Regards,
> > Artem B. Bityuckiy,
> > St.-Petersburg, Russia.
> 
> The only significant energy storage that hard disks
> contain
> is the inertia of the rotating disk assembly. Since
> the platter
> motor is not a generator it doesn't help. Those tiny
> bypass
> capacitors you see can't store enough energy to do
> anything
> useful during a power failure.
> 
> BUT... The PC/AT power supplies store a lot of
> energy and
> they run for many milliseconds after a power fail.
> 2-100 uF in series = 50 uF @ 300 v.
> J = 1/2 CV^2
> 
> J = 50uF * 300^2 / 2 =  2.25 joules (lots of
> energy).
> 
> If the power-fail line is properly connected and if
> the
> power fail line operates at the correct time, the
> CPU
> will be halted while there is still enough energy
> available
> to complete any write that has gotten to the
> disk-drives sector
> buffer. This does not protect data, but it should
> certainly
> protect the sectors which might now contain header,
> good data
> or junk, and a proper CRC. IOW a good sector.
> 
> Cheers,
> Dick Johnson
> Penguin : Linux version 2.6.13 on an i686 machine
> (5589.55 BogoMips).
> Warning : 98.36% of all statistics are fiction.
> 
>
****************************************************************
> The information transmitted in this message is
> confidential and may be privileged.  Any review,
> retransmission, dissemination, or other use of this
> information by persons or entities other than the
> intended recipient is prohibited.  If you are not
> the intended recipient, please notify Analogic
> Corporation immediately - by replying to this
> message or by sending an email to
> DeliveryErrors@analogic.com - and destroy all copies
> of this information, including any attachments,
> without reading or disclosing them.
> 
> Thank you.
> -
> To unsubscribe from this list: send the line
> "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at 
> http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

