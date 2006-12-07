Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031943AbWLGKaP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031943AbWLGKaP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 05:30:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031993AbWLGKaP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 05:30:15 -0500
Received: from mx1.redhat.com ([66.187.233.31]:43826 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1031943AbWLGKaM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 05:30:12 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20061206234942.79d6db01.akpm@osdl.org> 
References: <20061206234942.79d6db01.akpm@osdl.org>  <1165125055.5320.14.camel@gullible> <20061203011625.60268114.akpm@osdl.org> <Pine.LNX.4.64N.0612051642001.7108@blysk.ds.pg.gda.pl> <20061205123958.497a7bd6.akpm@osdl.org> <6FD5FD7A-4CC2-481A-BC87-B869F045B347@freescale.com> <20061205132643.d16db23b.akpm@osdl.org> <adaac22c9cu.fsf@cisco.com> <20061205135753.9c3844f8.akpm@osdl.org> <Pine.LNX.4.64N.0612061506460.29000@blysk.ds.pg.gda.pl> <20061206075729.b2b6aa52.akpm@osdl.org> <Pine.LNX.4.64.0612060822260.3542@woody.osdl.org> <Pine.LNX.4.64.0612061719420.3542@woody.osdl.org> <20061206224207.8a8335ee.akpm@osdl.org> 
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>, David Howells <dhowells@redhat.com>,
       "Maciej W. Rozycki" <macro@linux-mips.org>,
       Roland Dreier <rdreier@cisco.com>,
       Andy Fleming <afleming@freescale.com>,
       Ben Collins <ben.collins@ubuntu.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] Export current_is_keventd() for libphy 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Thu, 07 Dec 2006 10:29:39 +0000
Message-ID: <9392.1165487379@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:

> I guess I don't understand exactly what problem the noautorel stuff is
> trying to solve.  It _seems_ to me that in all cases we can simply stuff
> the old `data' field in alongside the controlling work_struct or
> delayed_work which wants to operate on it.

The problem is that you have to be able to guarantee that the data is still
accessible once you clear the pending bit.  The pending bit is your only
guaranteed protection, and once it is clear, the containing structure might be
deallocated.

I would like to be able to get rid of the NAR bit too, but I'm not confident
that in all cases I can.  It'll take a bit more study of the code to be able
to do that.

David
