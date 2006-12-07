Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1032006AbWLGKnP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1032006AbWLGKnP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 05:43:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759431AbWLGKnP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 05:43:15 -0500
Received: from smtp.osdl.org ([65.172.181.25]:42777 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759420AbWLGKnO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 05:43:14 -0500
Date: Thu, 7 Dec 2006 02:42:11 -0800
From: Andrew Morton <akpm@osdl.org>
To: David Howells <dhowells@redhat.com>
Cc: torvalds@osdl.org, dhowells@redhat.com, macro@linux-mips.org,
       rdreier@cisco.com, afleming@freescale.com, ben.collins@ubuntu.com,
       linux-kernel@vger.kernel.org, jeff@garzik.org
Subject: Re: [PATCH] Export current_is_keventd() for libphy
Message-Id: <20061207024211.be739a4a.akpm@osdl.org>
In-Reply-To: <9392.1165487379@redhat.com>
References: <20061206234942.79d6db01.akpm@osdl.org>
	<1165125055.5320.14.camel@gullible>
	<20061203011625.60268114.akpm@osdl.org>
	<Pine.LNX.4.64N.0612051642001.7108@blysk.ds.pg.gda.pl>
	<20061205123958.497a7bd6.akpm@osdl.org>
	<6FD5FD7A-4CC2-481A-BC87-B869F045B347@freescale.com>
	<20061205132643.d16db23b.akpm@osdl.org>
	<adaac22c9cu.fsf@cisco.com>
	<20061205135753.9c3844f8.akpm@osdl.org>
	<Pine.LNX.4.64N.0612061506460.29000@blysk.ds.pg.gda.pl>
	<20061206075729.b2b6aa52.akpm@osdl.org>
	<Pine.LNX.4.64.0612060822260.3542@woody.osdl.org>
	<Pine.LNX.4.64.0612061719420.3542@woody.osdl.org>
	<20061206224207.8a8335ee.akpm@osdl.org>
	<9392.1165487379@redhat.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.19; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Thu, 07 Dec 2006 10:29:39 +0000 David Howells <dhowells@redhat.com> wrote:
> Andrew Morton <akpm@osdl.org> wrote:
> 
> > I guess I don't understand exactly what problem the noautorel stuff is
> > trying to solve.  It _seems_ to me that in all cases we can simply stuff
> > the old `data' field in alongside the controlling work_struct or
> > delayed_work which wants to operate on it.
> 
> The problem is that you have to be able to guarantee that the data is still
> accessible once you clear the pending bit.  The pending bit is your only
> guaranteed protection, and once it is clear, the containing structure might be
> deallocated.
> 
> I would like to be able to get rid of the NAR bit too, but I'm not confident
> that in all cases I can.  It'll take a bit more study of the code to be able
> to do that.
> 

But anyone who is going to free the structure which contains the
work_struct would need to run flush_workqueue() beforehand, after having
ensured that the work won't reschedule itself.  So the
struct-which-contains-the-work_struct is safe during the callback's
execution.

If that's not being done then the code was buggy in 2.6.19, too..
