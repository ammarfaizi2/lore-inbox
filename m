Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932187AbWGGRAb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932187AbWGGRAb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 13:00:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932192AbWGGRAb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 13:00:31 -0400
Received: from web31814.mail.mud.yahoo.com ([68.142.206.167]:27737 "HELO
	web31814.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932187AbWGGRAa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 13:00:30 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=CxVcoaqOuA0sJPRYM0KYC4dAsXZ7iuJEyXyc9TyJpPjl8STmWPlUtu/CW45rWhHBo1H1O0KzO8VWigpLeNS9qQEyukh0pwhXjuCYOmf2IThbBbHyFqn/CTolr9LBM3ealxuWQYC9iEhKBRTJr1dXSdJjj02j9KFofMWs9YmDZAk=  ;
Message-ID: <20060707170029.18481.qmail@web31814.mail.mud.yahoo.com>
Date: Fri, 7 Jul 2006 10:00:29 -0700 (PDT)
From: Luben Tuikov <ltuikov@yahoo.com>
Reply-To: ltuikov@yahoo.com
Subject: Re: [PATCH] sched.h: increment TASK_COMM_LEN to 20 bytes
To: Andrew Morton <akpm@osdl.org>, Jeff Garzik <jeff@garzik.org>
Cc: ltuikov@yahoo.com, linux-kernel@vger.kernel.org
In-Reply-To: <20060630215312.b1389820.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Andrew Morton <akpm@osdl.org> wrote:
> On Sat, 01 Jul 2006 00:46:15 -0400
> Jeff Garzik <jeff@garzik.org> wrote:
> 
> > Andrew Morton wrote:
> > > Luben Tuikov <ltuikov@yahoo.com> wrote:
> > >>> We do occasionally hit task_struct.comm[] truncation, when people use
> > >>> "too-long-a-name%d" for their kernel thread names.  But we seem to manage.
> > >> It would be especially helpful if you want to name a task thread
> > >> the NAA IEEE Registered name format (16 chars, globally unique), for things
> > >> like FC, SAS, etc.  This way you can identify the task thread with
> > >> the device bearing the NAA IEEE name.
> > >>
> > >> Currently just last character is cut off, since TASK_COMM_LEN is 15+1.
> > >>
> > >> I think incrementing it would be a good thing, plus other things
> > >> may want to represent 8 bytes as a character array to be the name
> > >> of a task thread.
> > > 
> > > OK, that's a reason.  Being able to map a kernel thread onto a particular
> > > device is useful.
> > 
> > But will it wind up this way, when the does-not-exist-yet-upstream code 
> > appears?
> > 
> > I would think it would make more sense to increase the size of the key 
> > task structure only when there are justified, merged users in the kernel.
> > 
> 
> Well yes - I assumed that would be happening fairly soon.  Luben?

Andrew,

If this patch is so much affecting Garzik, please drop it.

As to "merged users in the kernel" -- my code is GPL, and at one point
was in the -mm tree as maintained by yourself.

Currently it also implements a SAT-r08a complient SCSI/ATA Translation
Layer for a SAS Stack including SATA capabilities adjustment as advertized
by the protocol, NCQ, passthrough, etc, etc. (Garzik may see this as
objectionable as it is not "libata", but it cannot be due to architectural
hurdles.)

Anyway, kernel threads bear the name of STP/SATA bridge which is representable
in 16+1 ASCII chars (IEEE NAA Registered format identifier, 8 bytes), and thus
the last character (4 bits of the name) are chopped off in a 15+1 char array.

So in effect, a kernel thread can be (WW-) uniquely identified with the device
it services.

In the (near) future, I can see other protocols wanting TASK_COMM_LEN to be larger
to accomodate this (e.g. any protocol which allows for IEEE NAA names).

Thank you for your time,
    Luben

