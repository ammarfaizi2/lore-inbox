Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268049AbUHVRcH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268049AbUHVRcH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Aug 2004 13:32:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268053AbUHVRcH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Aug 2004 13:32:07 -0400
Received: from as8-6-1.ens.s.bonet.se ([217.215.92.25]:37802 "EHLO
	zoo.weinigel.se") by vger.kernel.org with ESMTP id S268054AbUHVRbH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Aug 2004 13:31:07 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Christer Weinigel <christer@weinigel.se>,
       Pascal Schmidt <der.eremit@email.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jens Axboe <axboe@suse.de>
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
References: <2ptdY-42Y-55@gated-at.bofh.it> <2uPdM-380-11@gated-at.bofh.it>
	<2uUwL-6VP-11@gated-at.bofh.it> <2uWfh-8jo-29@gated-at.bofh.it>
	<2uXl0-Gt-27@gated-at.bofh.it> <2vge2-63k-15@gated-at.bofh.it>
	<2vgQF-6Ai-39@gated-at.bofh.it> <2vipq-7O8-15@gated-at.bofh.it>
	<2vj2b-8md-9@gated-at.bofh.it> <2vDtS-bq-19@gated-at.bofh.it>
	<E1ByXMd-00007M-4A@localhost> <412770EA.nail9DO11D18Y@burner>
	<412889FC.nail9MX1X3XW5@burner>
	<Pine.LNX.4.58.0408221450540.297@neptune.local>
	<m37jrr40zi.fsf@zoo.weinigel.se> <m33c2f3zg1.fsf@zoo.weinigel.se>
	<1093191541.24759.1.camel@localhost.localdomain>
From: Christer Weinigel <christer@weinigel.se>
Organization: Weinigel Ingenjorsbyra AB
Date: 22 Aug 2004 19:31:06 +0200
In-Reply-To: <1093191541.24759.1.camel@localhost.localdomain>
Message-ID: <m3pt5j2i79.fsf@zoo.weinigel.se>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> On Sul, 2004-08-22 at 17:33, Christer Weinigel wrote:
> > Regarding the current 2.6.8 kernel, wouldn't it be a better idea to
> > move the CAP_SYS_RAWIO check to open time instead of when the ioctl is
> > called?  This would require a new flag somewhere in the file structure
> > I suppose, e.g. file->f_mode & FMODE_RAWIO.  
> 
> This leads to all sorts of bugs where descriptors owned by one process
> are given to another less priviledged one. In the networking world
> similar logic led to holes because rsh for example gave root opened fd's
> to users.

On the other hand a bug in my favourite cd burner application could
give away SYS_CAP_RAWIO instead, and I think that is even worse.

Besides, checking SYS_CAP_RAWIO at open time is the way /dev/mem
works.  OTOH applications don't normally hand over /dev/mem to other
applications I suppose.  

I'm just tossing ideas around, please ignore me if they are stuipd :-)

  /Christer

-- 
"Just how much can I get away with and still go to heaven?"

Freelance consultant specializing in device driver programming for Linux 
Christer Weinigel <christer@weinigel.se>  http://www.weinigel.se
