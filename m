Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265646AbUBBPVf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 10:21:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265677AbUBBPVd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 10:21:33 -0500
Received: from gprs147-64.eurotel.cz ([160.218.147.64]:57472 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S265646AbUBBPVc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 10:21:32 -0500
Date: Mon, 2 Feb 2004 16:19:53 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Miklos Szeredi <Miklos.Szeredi@eth.ericsson.se>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Userspace filesystems (WAS: Encrypted Filesystem)
Message-ID: <20040202151953.GA262@elf.ucw.cz>
References: <OFA97B290B.67DE842E-ON87256E27.0061728C-86256E27.0061BB0E@us.ibm.com> <y2ar7xmkyqe.fsf@cartman.at.fivegeeks.net> <200401281350.i0SDo2I03247@duna48.eth.ericsson.se> <20040130170610.GB625@elf.ucw.cz> <200402020942.i129gHf15172@duna48.eth.ericsson.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200402020942.i129gHf15172@duna48.eth.ericsson.se>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > >    app wants to read data from a file ->
> > >    userspace application requires memory allocation to provide this data ->
> > >    VM tries to write out dirty data associated with the Coda mountpoint ==
> > >    deadlock
> > 
> > How do you solve this one?
> 
> 1) In FUSE normal writes go through the cache, so no dirty pages are
>    created.  The only possibility to create dirty pages is with shared
>    writable mapping, and this is rare
> 
> 2) Userspace filesystem app can be multithreaded, so probably write
>    can be satisfied even if read is pending.
> 
> 3) The 2.6 kernel provides asynchronous page writeback, so even if a
>    writeback is blocking forever the VM will continue to try to free
>    up memory.
> 
> 4) If no memory can be freed, then the allocation will fail, so the
>    read will fail: no deadlock.

Transient real failure looks pretty ugly. I'd not expect
read(/etc/passwd) to return -ENOMEM, and read(/#ftp:somewhere/passwd)
should be the same, but as this is basically "can not happen"... I
guess that's enough.
								Pavel

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
