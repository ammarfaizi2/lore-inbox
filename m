Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262183AbTJJBKW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 21:10:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262690AbTJJBKW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 21:10:22 -0400
Received: from dci.doncaster.on.ca ([66.11.168.194]:38073 "EHLO smtp.istop.com")
	by vger.kernel.org with ESMTP id S262183AbTJJBKT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 21:10:19 -0400
To: "Mudama, Eric" <eric_mudama@Maxtor.com>
Cc: "'Daniel B.'" <dsb@smart.net>, linux-kernel@vger.kernel.org
Subject: Re: IDE DMA errors, massive disk corruption:  Why?  Fixed Yet?  W hy not  re-do failed op?
References: <785F348679A4D5119A0C009027DE33C105CDB20A@mcoexc04.mlm.maxtor.com>
In-Reply-To: <785F348679A4D5119A0C009027DE33C105CDB20A@mcoexc04.mlm.maxtor.com>
From: Greg Stark <gsstark@mit.edu>
Organization: The Emacs Conspiracy; member since 1992
Date: 09 Oct 2003 21:10:18 -0400
Message-ID: <87llrt99tx.fsf@stark.dyndns.tv>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


"Mudama, Eric" <eric_mudama@Maxtor.com> writes:

> If the disk has write cache enabled, this isn't necessarilly possible, since
> there's nothing in the IDE specification that guarantees the order of writes
> to the media without a FLUSH CACHE (EXT) command.

So, uhm, is there an interface exporting this command to applications?
Databases like Postgres would love to be able to issue such a command.

As it stands they have to do some awful hacks with fsync and sync. Postgres in
particular at certain points just calls sync and then waits an arbitrary time
hoping that that should be enough to get everything to disk.

Some users have in fact resorted to disabling the cache on their ide drives.
And of course it absolutely demolishes performance. Having it be disabled just
at the few points in time when it actually matters would be a huge improvement.

-- 
greg

