Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265263AbSKFBLF>; Tue, 5 Nov 2002 20:11:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265264AbSKFBLF>; Tue, 5 Nov 2002 20:11:05 -0500
Received: from packet.digeo.com ([12.110.80.53]:56487 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S265263AbSKFBLC>;
	Tue, 5 Nov 2002 20:11:02 -0500
Message-ID: <3DC86DAC.4EBB59C8@digeo.com>
Date: Tue, 05 Nov 2002 17:17:32 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.46 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Badari Pulavarty <pbadari@us.ibm.com>
CC: linux-aio@kvack.org, lkml <linux-kernel@vger.kernel.org>, bcrl@redhat.com
Subject: Re: [PATCH 2/2] 2.5.46 AIO support for raw/O_DIRECT
References: <200211060103.gA613a321256@eng2.beaverton.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 06 Nov 2002 01:17:32.0113 (UTC) FILETIME=[47E95C10:01C28532]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Badari Pulavarty wrote:
> 
> Hi,
> 
> This is (part 2/2) 2.5.46 patch to support AIO for raw/O_DIRECT.
> 
> This patch adds AIO support for DIO code path. This patch also
> has a work around for calling set_page_dirty() from interrupt
> context problem.
> 
> Andrew, could you please check to see if I did "set_page_dirty()"
> hack (you suggested) correctly (in the right place) ?
> 

Looks like it.  It's such a hack, I want to hide ;)

Sigh.  I think I'd prefer to just go and make ->page_lock
and ->private_lock irq-safe.

Or not proceed with this patch at all.  If this is to be the
only code which wishes to perform page list motion at interrupt
time, perhaps it's not justifiable?

I really don't have a feeling for how valuable this is, nor
do I know whether there will be other code which wants to
perform page list manipulation at interrupt time.

In fact I also don't know where the whole AIO thing sits at
present.  Is it all done and finished?  Is there more to come,
and if so, what??
