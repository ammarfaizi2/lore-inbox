Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751426AbWAZVxU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751426AbWAZVxU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 16:53:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751427AbWAZVxU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 16:53:20 -0500
Received: from [202.53.187.9] ([202.53.187.9]:27577 "EHLO
	cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S1751426AbWAZVxU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 16:53:20 -0500
From: Nigel Cunningham <nigel@suspend2.net>
Organization: Suspend2.net
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: [ 00/23] [Suspend2] Freezer Upgrade Patches
Date: Fri, 27 Jan 2006 07:49:43 +1000
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
References: <20060126034518.3178.55397.stgit@localhost.localdomain> <20060126115500.GA1609@elf.ucw.cz>
In-Reply-To: <20060126115500.GA1609@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601270749.43387.nigel@suspend2.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Thursday 26 January 2006 21:55, Pavel Machek wrote:
> Hi!
>
> > This set of patches represents the freezer upgrade patches from Suspend2.
> >
> > The key features of this changeset are:
> >
> > - Use of Christoph Lameter's todo list notifiers, which help with SMP
> >   cleanness.
> > - Splitting the freezing of kernel and userspace processes. Freezing
> >   currently suffers from a race because userspace processes can be
> >   submitting work for kernel threads, thereby stopping them from
> >   responding to freeze messages in a timely manner. The freezer can
> >   thus give up when it doesn't really need to. (This is not normally
> >   a problem only because load is not usually high).
>
> Exactly. 6 seconds should be enough for signal to be delivered.
>
> > - The use of bdev freezing to ensure filesystems are properly frozen,
> >   thereby increasing the integrity of on-disk data in the case where
> >   a resume doesn't occur. This is also helpful in the case of Suspend2,
> >   where we don't atomically copy all memory, instead writing LRU pages
> >   separately.
>
> We have talked about this before... we alredy have sync there, and
> that's enough. Your patch only makes code more complex for no gain.

Yes, we have. Sorry for failing to back up my statement of the need for the 
changes with numbers. I'll do a couple of hundred attempts under load with 
and without the changes, and send a further message saying how many times the 
current implementation fails.

Regards,

Nigel
-- 
See our web page for Howtos, FAQs, the Wiki and mailing list info.
http://www.suspend2.net                IRC: #suspend2 on Freenode
