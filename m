Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264352AbTLBUin (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Dec 2003 15:38:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264373AbTLBUiL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Dec 2003 15:38:11 -0500
Received: from dci.doncaster.on.ca ([66.11.168.194]:48545 "EHLO smtp.istop.com")
	by vger.kernel.org with ESMTP id S264352AbTLBUe5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Dec 2003 15:34:57 -0500
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Greg Stark <gsstark@mit.edu>, Mike Fedyk <mfedyk@matchmail.com>,
       Erik Steffl <steffl@bigfoot.com>, linux-kernel@vger.kernel.org
Subject: Re: libata in 2.4.24?
References: <3FCBB15F.7050505@rackable.com> <3FCBB9F1.2080300@bigfoot.com>
	<87n0abbx2k.fsf@stark.dyndns.tv>
	<20031202055336.GO1566@mis-mike-wstn.matchmail.com>
	<20031202055852.GP1566@mis-mike-wstn.matchmail.com>
	<87zneb9o5q.fsf@stark.dyndns.tv> <20031202180241.GB1990@gtf.org>
	<87iskz9hp6.fsf@stark.dyndns.tv> <20031202190646.GA9043@gtf.org>
	<877k1f9e1g.fsf@stark.dyndns.tv> <20031202201649.GB17779@gtf.org>
In-Reply-To: <20031202201649.GB17779@gtf.org>
From: Greg Stark <gsstark@mit.edu>
Organization: The Emacs Conspiracy; member since 1992
Date: 02 Dec 2003 15:34:56 -0500
Message-ID: <87vfoz7ybz.fsf@stark.dyndns.tv>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@pobox.com> writes:

> Some IDE _and/or_ SCSI drives do not cache writes.  For these drives,
> the _absence_ of an OS flush-cache command still means your data gets
> to the platter.

In theory you could have an IDE drive that didn't cache writes, or a SCSI
drive that did. Except in practice it seems all IDE drives cache writes by
default and perform like dogs if they don't. And in practice all SCSI drives
appear to not cache writes and perform fine.

I guess my question is whether a new round of ATA drives will be coming out
where you can turn off write caching and still get decent performance because
the interface is more SCSI-like with deep enough queues. If so they'll
probably disable write caching altogether, but if they don't the user could
always do it.

And if such a new round of ATA drives will be coming out, exactly what should
I be watching for. SATA alone isn't enough, what featureset will this feature
come along with? 

> The core problem is not issuing a flush-cache command, it sounds like.
> The drive technology (wcache, or no) is largely irrelevant.

Well issuing a flush-cache is a much bigger performance hit than merely not
caching the writes in the first place. There could be lots of other writes to
other files in the system. In fact it's likely there are lots of other writes
to other files in postgres itself, most of the time it's only fsyncing the
transaction log.

-- 
greg

