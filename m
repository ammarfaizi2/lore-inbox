Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751272AbWCQOfv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751272AbWCQOfv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 09:35:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751278AbWCQOfv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 09:35:51 -0500
Received: from pproxy.gmail.com ([64.233.166.181]:49924 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751272AbWCQOfu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 09:35:50 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=g5TL0m8x182Gz94xJFrrU9GJyaqlE1DX/sPem75j++Aq+bgL5ncK4vjJVyiVMhO6hKa3CcL43E9tvA2k4rEW1m3JimRlIsky6oIi+MyEgw/h2qCZjuyf8oSi/HBrK/SQux/v/g/XmYcf6OkK/k6Ltbf+pMMjfbdeb8RsrDgy0bk=
Message-ID: <93564eb70603170635s4d3c8c3o@mail.gmail.com>
Date: Fri, 17 Mar 2006 23:35:48 +0900
From: "Samuel Masham" <samuel.masham@gmail.com>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Subject: Re: libata/sata errors on ich[?]/maxtor
Cc: "Mauro Tassinari" <mtassinari@cmanet.it>, linux-kernel@vger.kernel.org
In-Reply-To: <1142595294.28614.3.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA//gP36uv0hG9NQDAJogAp8KAAAAQAAAAoSG5sanwXkG4qxYkj76rcgEAAAAA@cmanet.it>
	 <93564eb70603162037g1856b7eey@mail.gmail.com>
	 <1142595294.28614.3.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

On 17/03/06, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> On Gwe, 2006-03-17 at 13:37 +0900, Samuel Masham wrote:
> > As you can see from the printk's here this error continues and the for
> > every access (write?) to the drive you just have to wait for a
> > timeout.
>
> Eventually the drive will be offlined.

really? I can test that easily enough if nothing else :)

> > ata1: command 0x35 timeout, stat 0xd1 host_stat 0x61
> > ata1: translated ATA stat/err 0xd1/00 to SCSI SK/ASC/ASCQ 0xb/47/00
> > ata1: status=0xd1 { Busy }
> > SCSI disk error : host 0 channel 0 id 1 lun 0 return code = 8000002
> > Current sd08:12: sense key Aborted Command
> > Additional sense indicates Scsi parity error
>
> It thinks there is a communication (eg cable problem), at least that is
> how it has mapped the error report. Not something I'd expect to see in
> the SATA case on several machines so it could be some kind of setup
> error or timing incompatibility in the driver.

Well Its cheep enough to get another cable and test that. But as the
failure is repeatable in nearly (but not quite) down to the block for
a given build then i don't have so much hope.

> What is attached to that controller (SATA and PATA items)

It being the weekend here i don't now have access to the box... but
from the rhn page (linked in the bugzilla entry if anyone can follow
that) it says

Ata Maxtor 6Y080M0  SCSI  sda 0
Ata Maxtor 6V250F0   SCSI  sdb 0

I thought they had a ide (normal ata) cddrive on board as well but
cant see that on the hardware info page...

I will check on Monday and report back.

Since posting this i have tried one more thing

I had a look at the data sheet for the sata control er and it said
that it supported the SATA 1 (150) mode  and the drive supports SATA 2
(300) i think (names maybe confused here).

So I tried moving the jumper on the drive to the 150 mode position but
this made no difference.

Could the drive have some functions (NCQ?) enabled by default that the
controller cant handle? (and we dont turn off when we initialise the
drive as we have no support yet?)... ok that's reaching...

Any ideas of what I can check or tryout would be great!

Thanks

Samuel

ps Mauro, yep I am quite convinced we are seeing the same thing
here... I will let you know how it turns out for us
