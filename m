Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263735AbUHWMWe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263735AbUHWMWe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 08:22:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263772AbUHWMWe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 08:22:34 -0400
Received: from pils.us-lot.org ([212.67.207.13]:20489 "EHLO pils.us-lot.org")
	by vger.kernel.org with ESMTP id S263735AbUHWMWc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 08:22:32 -0400
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
From: Adam Sampson <azz@us-lot.org>
Organization: Things I did not know at first I learned by doing twice.
Date: Mon, 23 Aug 2004 13:22:19 +0100
In-Reply-To: <1093191541.24759.1.camel@localhost.localdomain> (Alan Cox's
 message of "Sun, 22 Aug 2004 17:19:11 +0100")
Message-ID: <y2azn4mgi2s.fsf@cartman.at.fivegeeks.net>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

>> Regarding the current 2.6.8 kernel, wouldn't it be a better idea to
>> move the CAP_SYS_RAWIO check to open time instead of when the ioctl is
>> called?
> This leads to all sorts of bugs where descriptors owned by one process
> are given to another less priviledged one.

Yes, but that's a class of bugs that are pretty well understood these
days; handing privileged FDs around is a moderately common and
pleasantly fine-grained way of doing things. Closing an FD is at least
as easy as dropping a capability, which is what you'd have to do
with the current scheme upon entering unprivileged code.

Besides, setuid CD-recording tools already have to worry about closing
unsafe FDs when they drop privileges, so this doesn't seem to add any
new security holes...

Thanks,

-- 
Adam Sampson <azz@us-lot.org>                        <http://offog.org/>
