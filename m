Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932386AbWDBQVz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932386AbWDBQVz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Apr 2006 12:21:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932384AbWDBQVz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Apr 2006 12:21:55 -0400
Received: from rtr.ca ([64.26.128.89]:53958 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S932385AbWDBQVz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Apr 2006 12:21:55 -0400
Message-ID: <442FFA0E.4070101@rtr.ca>
Date: Sun, 02 Apr 2006 12:21:34 -0400
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8) Gecko/20060305 SeaMonkey/1.1a
MIME-Version: 1.0
To: Dan Aloni <da-x@monatomic.org>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@pobox.com>,
       IDE/ATA development list <linux-ide@vger.kernel.org>
Subject: Re: sata_mv: module reloading doesn't work
References: <20060402155647.GB20270@localdomain> <442FF65A.6020209@rtr.ca> <20060402161449.GA21822@localdomain>
In-Reply-To: <20060402161449.GA21822@localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Aloni wrote:
> On Sun, Apr 02, 2006 at 12:05:46PM -0400, Mark Lord wrote:
>
>> What kernel?  Any patches applied to sata_mv.c ??
> 
> 2.6.16 + ncq branch. sata_mv.c was modified by me - I'll retry
> with a cleaner configuration, sorry.

The NCQ stuff is *unsafe* with the existing sata_mv.c,
as there are known (to me, at least) bugs that prevent it
from working reliably after the first I/O error of any kind.

The 2.6.16.1 branch is slightly better,
and there is also the "three bug fixes" update
that's in upstream to help things further.

With all of those fixes, the module loads/unloads/reloads fine for me.

If you want to use NCQ more safely, then you'll need to modify
the mv_start_dma() routine to reinitialize the queue pointers
each time, as they can get out of sync after an error.

There are still other bugs to be worked out and fixed, though.

I'll have a patch or two this week for the ones I know about.

Cheers

