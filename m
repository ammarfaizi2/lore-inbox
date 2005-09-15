Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965256AbVIOO3r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965256AbVIOO3r (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 10:29:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965263AbVIOO3r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 10:29:47 -0400
Received: from central-air-conditioning.toybox.cambridge.ma.us ([69.25.196.71]:61312
	"EHLO central-air-conditioning.toybox.cambridge.ma.us")
	by vger.kernel.org with ESMTP id S965256AbVIOO3r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 10:29:47 -0400
From: Marc Horowitz <marc@mit.edu>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Horms <horms@debian.org>, 328135@bugs.debian.org,
       linux-kernel@vger.kernel.org
Subject: Re: Bug#328135: kernel-image-2.6.11-1-686-smp: nfs reading process stuck in disk wait
References: <20050913194707.8C8C28E6F0@ayer.connecterra.net>
	<20050914025150.GR27828@verge.net.au>
	<1126742335.8807.74.camel@lade.trondhjem.org>
	<t533bo75e6t.fsf@central-air-conditioning.toybox.cambridge.ma.us>
	<1126773168.12556.13.camel@lade.trondhjem.org>
Date: Thu, 15 Sep 2005 10:29:38 -0400
In-Reply-To: <1126773168.12556.13.camel@lade.trondhjem.org> (Trond Myklebust's
	message of "Thu, 15 Sep 2005 09:32:47 +0100")
Message-ID: <t5364t2xv3h.fsf@central-air-conditioning.toybox.cambridge.ma.us>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust <trond.myklebust@fys.uio.no> writes:

>> on den 14.09.2005 Klokka 21:10 (-0400) skreiv Marc Horowitz:
>> > Trond Myklebust <trond.myklebust@fys.uio.no> writes:
>> > 
>> > >> on den 14.09.2005 Klokka 11:51 (+0900) skreiv Horms:
>> > >> I doubt this has anything to do with NFS. We should no longer have a
>> > >> sync_page VFS method in the 2.6 kernels. What other filesystems is the
>> > >> user running?
>> > 
>> > In the stack trace I sent, from a running 2.6.11 kernel, vfs_read
>> > appears to be the vfs method, not sync_page.  sync_page is called much
>> > deeper in the stack trace.
>> 
>> So? It is clearly the call to sync_page that is Oopsing.
>> 
>> The NFS call is just trying to lock a page that appears to be owned by
>> someone else. That triggers a call to that filesystem's sync_page, which
>> then goes on to do a page allocation, which again Oopses.

Ah, I understand now.  I misinterpreted what you said to mean you
didn't expect to see a sync_page call at all.

That said, I'd like to clarify one thing: there is no oops in the
dmesg output.  That stack trace comes from dmesg after I do
"echo t > /proc/sysrq_trigger".

I'll give the 2.6.12 kernel a try today or tomorrow, and see what
happens.

                Marc
