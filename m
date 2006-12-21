Return-Path: <linux-kernel-owner+w=401wt.eu-S1423081AbWLUUk0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423081AbWLUUk0 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 15:40:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423083AbWLUUk0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 15:40:26 -0500
Received: from smtp.osdl.org ([65.172.181.25]:38573 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423081AbWLUUkY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 15:40:24 -0500
Date: Thu, 21 Dec 2006 12:40:03 -0800
From: Andrew Morton <akpm@osdl.org>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Linus Torvalds <torvalds@osdl.org>, Nick Piggin <nickpiggin@yahoo.com.au>,
       andrei.popa@i-neo.ro,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Hugh Dickins <hugh@veritas.com>, Florian Weimer <fw@deneb.enyo.de>,
       Marc Haber <mh+linux-kernel@zugschlus.de>,
       Martin Michlmayr <tbm@cyrius.com>
Subject: Re: 2.6.19 file content corruption on ext3
Message-Id: <20061221124003.d19d4fe7.akpm@osdl.org>
In-Reply-To: <1166706200.32117.14.camel@twins>
References: <1166314399.7018.6.camel@localhost>
	<20061217040620.91dac272.akpm@osdl.org>
	<1166362772.8593.2.camel@localhost>
	<20061217154026.219b294f.akpm@osdl.org>
	<1166460945.10372.84.camel@twins>
	<Pine.LNX.4.64.0612180933560.3479@woody.osdl.org>
	<45876C65.7010301@yahoo.com.au>
	<Pine.LNX.4.64.0612182230301.3479@woody.osdl.org>
	<45878BE8.8010700@yahoo.com.au>
	<Pine.LNX.4.64.0612182313550.3479@woody.osdl.org>
	<Pine.LNX.4.64.0612182342030.3479@woody.osdl.org>
	<4587B762.2030603@yahoo.com.au>
	<Pine.LNX.4.64.0612190847270.3479@woody.osdl.org>
	<Pine.LNX.4.64.0612190929240.3483@woody.osdl.org>
	<1166706200.32117.14.camel@twins>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Dec 2006 14:03:20 +0100
Peter Zijlstra <a.p.zijlstra@chello.nl> wrote:

> On Tue, 2006-12-19 at 09:43 -0800, Linus Torvalds wrote:
> > 
> > Btw,
> >  here's a totally new tangent on this: it's possible that user code is 
> > simply BUGGY. 
> 
> depmod: BADNESS: written outside isize 22183

akpm:/usr/src/module-init-tools-3.3-pre1> grep -r mmap .
./zlibsupport.c:        map = mmap(0, *size, PROT_READ|PROT_WRITE, MAP_PRIVATE, fd, 0);

So presumably it's in a library.

akpm:/usr/src/25> ldd /sbin/depmod
        linux-gate.so.1 =>  (0xffffe000)
        libc.so.6 => /lib/tls/i686/cmov/libc.so.6 (0x46afa000)
        /lib/ld-linux.so.2 (0x4631d000)

worrisome.
