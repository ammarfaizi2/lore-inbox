Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267790AbRGZNwd>; Thu, 26 Jul 2001 09:52:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267961AbRGZNwM>; Thu, 26 Jul 2001 09:52:12 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:61196 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S267790AbRGZNwF>; Thu, 26 Jul 2001 09:52:05 -0400
Subject: Re: ext3-2.4-0.9.4
To: matthias.andree@stud.uni-dortmund.de (Matthias Andree)
Date: Thu, 26 Jul 2001 14:52:21 +0100 (BST)
Cc: riel@conectiva.com.br (Rik van Riel),
        matthias.andree@stud.uni-dortmund.de (Matthias Andree),
        akpm@zip.com.au (Andrew Morton), linux-kernel@vger.kernel.org (lkml),
        ext3-users@redhat.com (ext3-users@redhat.com)
In-Reply-To: <20010726151749.M17244@emma1.emma.line.org> from "Matthias Andree" at Jul 26, 2001 03:17:49 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15PlYr-0003mr-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

> On Thu, 26 Jul 2001, Rik van Riel wrote:
> > In fact, knowing how hard disks work mechanically, only
> > journaling filesystems could have an extention to make
> > this work.  Ie. this is NOT something you can rely on ;)
> 
> This is not about failing hard disks. It is about premature
> acknowledgment of something which has not happened at that time.

Rik is right. It isnt just about premature notification - its about 
atomicity. At the point you are notified the data has been queued for disk
I/O. Even on traditional BSD ufs with synchronous metadata you still had
points where a crash left the rename partially complete and nothing but a
log or an atomic update system is going to fix that.

> The competition is there and it has names: BSD + ufs + softupdates,
> Solaris + logging ufs. Read MTA mailing lists before obstructing.

All of which are - not unsuprisingly - using a log. In fact Solaris logging
ufs and ext3 are very similar ideas - adding a log to an existing fs.

Alan
