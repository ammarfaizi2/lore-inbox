Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270727AbTHCCMj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Aug 2003 22:12:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270810AbTHCCMi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Aug 2003 22:12:38 -0400
Received: from codepoet.org ([166.70.99.138]:35037 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id S270727AbTHCCMf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Aug 2003 22:12:35 -0400
Date: Sat, 2 Aug 2003 20:12:39 -0600
From: Erik Andersen <andersen@codepoet.org>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       axboe@suse.de, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: [PATCH] ide-disk.c rev 1.13 killed CONFIG_IDEDISK_STROKE
Message-ID: <20030803021238.GA8824@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Andries Brouwer <aebr@win.tue.nl>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
	axboe@suse.de,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Marcelo Tosatti <marcelo@conectiva.com.br>
References: <20030802124536.GB3689@win.tue.nl> <Pine.SOL.4.30.0308021506550.7779-100000@mion.elka.pw.edu.pl> <20030802174229.GA3741@win.tue.nl> <1059858379.20305.23.camel@dhcp22.swansea.linux.org.uk> <20030802233438.GA7652@codepoet.org> <20030803012659.GA3933@win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030803012659.GA3933@win.tue.nl>
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux 2.4.19-rmk7, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun Aug 03, 2003 at 03:26:59AM +0200, Andries Brouwer wrote:
> On Sat, Aug 02, 2003 at 05:34:38PM -0600, Erik Andersen wrote:
> 
> > I have rewritten the init_idedisk_capacity() function and taught
> > it to behave itself.  It is now much cleaner IMHO
> 
> Yes, nice cleanup.

Thanks.  :-)

> Some comments for later - the patch can be applied as it is:
> 
> The assignment
> 	drive->select.b.lba = 0/1;
> is done in the first half of init_idedisk_capacity().
> I don't think the presence or disabling of HPA has any effect
> on b.lba, so there should not be such assignments in the
> second, HPA, half.

Yes, you are right.  This is garbage leftover from the previous
implementation.  It should not change anything, but that would 
be a nice additional cleanup.

> My standard muttering: id->... should not be modified.

Agreed, but that is best left for another patch, since I did not
want to walk through the whole ide stack checking for things that
depends on this behavior.  Hopefully nothing, but you never know.

> In my source I test drive->head * drive->sect for being nonzero
> before dividing.

That would also be a nice additional cleanup.

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
