Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423390AbWJYMdx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423390AbWJYMdx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 08:33:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423394AbWJYMdx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 08:33:53 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:54995 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1423390AbWJYMdw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 08:33:52 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] Freeze bdevs when freezing processes.
Date: Wed, 25 Oct 2006 14:32:39 +0200
User-Agent: KMail/1.9.1
Cc: David Chinner <dgc@sgi.com>, Nigel Cunningham <ncunningham@linuxmail.org>,
       Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       xfs@oss.sgi.com
References: <1161576735.3466.7.camel@nigel.suspend2.net> <20061025083830.GI11034@melbourne.sgi.com> <20061025084714.GA7266@elf.ucw.cz>
In-Reply-To: <20061025084714.GA7266@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610251432.41958.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, 25 October 2006 10:47, Pavel Machek wrote:
> On Wed 2006-10-25 18:38:30, David Chinner wrote:
> > On Wed, Oct 25, 2006 at 10:10:01AM +0200, Pavel Machek wrote:
> > > > Hence the only way to correctly rebuild the XFS state on resume is
> > > > to quiesce the filesystem on suspend and thaw it on resume so as to
> > > > trigger log recovery.
> > > 
> > > No, during suspend/resume, memory image is saved, and no state is
> > > lost. We would not even have to do sys_sync(), and suspend/resume
> > > would still work properly.
> > 
> > It seems to me that you ensure the filesystem is synced to disk and
> > then at some point later you record the memory state of the
> > filesystem, but these happen at different times. That leaves a
> > window for things to get out of sync again, right?
> 
> I DO NOT HAVE TO ENSURE FILESYSTEM IS SYNCED. That sys_sync() is
> optional.
> 
> Recording of memory state is atomic, and as long as noone writes to
> the disk after atomic snapshot, memory image matches what is on disk.

Well, my impression is that this is exactly what happens here: Something
in the XFS code causes metadata to be written to disk _after_ the atomic
snapshot.

That's why I asked if the dirty XFS metadata were flushed by a kernel thread.

Greetings,
Rafael


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller
