Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161360AbWJYNXp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161360AbWJYNXp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 09:23:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161362AbWJYNXp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 09:23:45 -0400
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:46216 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S1161360AbWJYNXo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 09:23:44 -0400
Subject: Re: [PATCH] Freeze bdevs when freezing processes.
From: Nigel Cunningham <ncunningham@linuxmail.org>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Pavel Machek <pavel@ucw.cz>, David Chinner <dgc@sgi.com>,
       Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       xfs@oss.sgi.com
In-Reply-To: <200610251432.41958.rjw@sisk.pl>
References: <1161576735.3466.7.camel@nigel.suspend2.net>
	 <20061025083830.GI11034@melbourne.sgi.com>
	 <20061025084714.GA7266@elf.ucw.cz>  <200610251432.41958.rjw@sisk.pl>
Content-Type: text/plain
Date: Wed, 25 Oct 2006 23:23:40 +1000
Message-Id: <1161782620.3638.0.camel@nigel.suspend2.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Wed, 2006-10-25 at 14:32 +0200, Rafael J. Wysocki wrote:
> On Wednesday, 25 October 2006 10:47, Pavel Machek wrote:
> > On Wed 2006-10-25 18:38:30, David Chinner wrote:
> > > On Wed, Oct 25, 2006 at 10:10:01AM +0200, Pavel Machek wrote:
> > > > > Hence the only way to correctly rebuild the XFS state on resume is
> > > > > to quiesce the filesystem on suspend and thaw it on resume so as to
> > > > > trigger log recovery.
> > > > 
> > > > No, during suspend/resume, memory image is saved, and no state is
> > > > lost. We would not even have to do sys_sync(), and suspend/resume
> > > > would still work properly.
> > > 
> > > It seems to me that you ensure the filesystem is synced to disk and
> > > then at some point later you record the memory state of the
> > > filesystem, but these happen at different times. That leaves a
> > > window for things to get out of sync again, right?
> > 
> > I DO NOT HAVE TO ENSURE FILESYSTEM IS SYNCED. That sys_sync() is
> > optional.
> > 
> > Recording of memory state is atomic, and as long as noone writes to
> > the disk after atomic snapshot, memory image matches what is on disk.
> 
> Well, my impression is that this is exactly what happens here: Something
> in the XFS code causes metadata to be written to disk _after_ the atomic
> snapshot.
> 
> That's why I asked if the dirty XFS metadata were flushed by a kernel thread.

When I first added bdev freezing it was because there was an XFS timer
doing writes.

Regards,

Nigel

