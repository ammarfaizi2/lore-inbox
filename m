Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264320AbTLBSvY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Dec 2003 13:51:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264321AbTLBSvY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Dec 2003 13:51:24 -0500
Received: from dci.doncaster.on.ca ([66.11.168.194]:20108 "EHLO smtp.istop.com")
	by vger.kernel.org with ESMTP id S264320AbTLBSvW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Dec 2003 13:51:22 -0500
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Greg Stark <gsstark@mit.edu>, Mike Fedyk <mfedyk@matchmail.com>,
       Erik Steffl <steffl@bigfoot.com>, linux-kernel@vger.kernel.org
Subject: Re: libata in 2.4.24?
References: <Pine.LNX.4.44.0312010836130.13692-100000@logos.cnet>
	<3FCB8312.3050703@rackable.com> <87fzg4ckej.fsf@stark.dyndns.tv>
	<3FCBB15F.7050505@rackable.com> <3FCBB9F1.2080300@bigfoot.com>
	<87n0abbx2k.fsf@stark.dyndns.tv>
	<20031202055336.GO1566@mis-mike-wstn.matchmail.com>
	<20031202055852.GP1566@mis-mike-wstn.matchmail.com>
	<87zneb9o5q.fsf@stark.dyndns.tv> <20031202180241.GB1990@gtf.org>
In-Reply-To: <20031202180241.GB1990@gtf.org>
From: Greg Stark <gsstark@mit.edu>
Organization: The Emacs Conspiracy; member since 1992
Date: 02 Dec 2003 13:51:17 -0500
Message-ID: <87iskz9hp6.fsf@stark.dyndns.tv>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Jeff Garzik <jgarzik@pobox.com> writes:

> If true, this is an IDE driver bug...  assuming the drive itself
> doesn't lie about FLUSH CACHE results (a few do).

I don't think the IDE drivers issue FLUSH CACHE after every write on O_SYNC,
or after fsync calls. The "lying" discussed on the database lists is when a
normal write is issued, IDE disks report immediate success even before the
write hits disk. As far as I know from the lists it seems *all* IDE disks
behave this way unless write caching is disabled.

This doesn't happen with SCSI disks where multiple requests can be pending so
there's no urgency to reporting a false success. The request doesn't complete
until the write hits disk. As a result SCSI disks are reliable for database
operation and IDE disks aren't unless write caching is disabled.

> If the drive lies, there isn't a darned thing we can do about it...
>
> If the drive lies, there isn't a darned thing the controller can do
> about it, either ;-)

Of course not, but the assumption is that they're only lying because of the
lack of a TCQ interface. If they could have multiple requests pending there
would be no need to lie any more at all.

I'm unclear on which of your #2 or #3 will be the solution though. Do either
or both of them require that writes actually hit disk before the drive reports
success? Do either of them allow that semantic without destroying concurrent
performance?

-- 
greg

