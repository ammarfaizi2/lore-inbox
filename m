Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751189AbWA0EHz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751189AbWA0EHz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 23:07:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751199AbWA0EHz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 23:07:55 -0500
Received: from [202.53.187.9] ([202.53.187.9]:13198 "EHLO
	cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S1751189AbWA0EHy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 23:07:54 -0500
From: Nigel Cunningham <nigel@suspend2.net>
Organization: Suspend2.net
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [ 00/23] [Suspend2] Freezer Upgrade Patches
Date: Fri, 27 Jan 2006 14:04:08 +1000
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, Pavel Machek <pavel@suse.cz>
References: <20060126034518.3178.55397.stgit@localhost.localdomain> <200601270010.22702.rjw@sisk.pl>
In-Reply-To: <200601270010.22702.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601271404.08680.nigel@suspend2.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Friday 27 January 2006 09:10, Rafael J. Wysocki wrote:
> Hi,
>
> On Thursday, 26 January 2006 04:45, Nigel Cunningham wrote:
> > Hi everyone.
> >
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
> Could you please describe specific situation?

The simplest example would be:

dd if=/dev/hda of=/dev/null
echo disk > /sys/power/state

> > - The use of bdev freezing to ensure filesystems are properly frozen,
> >   thereby increasing the integrity of on-disk data in the case where
> >   a resume doesn't occur. This is also helpful in the case of Suspend2,
> >   where we don't atomically copy all memory, instead writing LRU pages
> >   separately.
>
> Is this also needed when we do atomically copy all memory?

I'm not thawing the bdevs until the end of resuming, so no.

Regards,

Nigel

-- 
See our web page for Howtos, FAQs, the Wiki and mailing list info.
http://www.suspend2.net                IRC: #suspend2 on Freenode
