Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262089AbUK0F7K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262089AbUK0F7K (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Nov 2004 00:59:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262088AbUK0Dtu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 22:49:50 -0500
Received: from zeus.kernel.org ([204.152.189.113]:5572 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262540AbUKZTdo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:33:44 -0500
To: Matthew Wilcox <matthew@wil.cx>
Cc: David Howells <dhowells@redhat.com>, torvalds@osdl.org, hch@infradead.org,
       dwmw2@infradead.org, linux-kernel@vger.kernel.org,
       libc-alpha@sources.redhat.com
Subject: Re: [RFC] Splitting kernel headers and deprecating __KERNEL__
References: <19865.1101395592@redhat.com>
	<orvfbtzt7t.fsf@livre.redhat.lsd.ic.unicamp.br>
	<20041125210137.GD2849@parcelfarce.linux.theplanet.co.uk>
From: Alexandre Oliva <aoliva@redhat.com>
Organization: Red Hat Global Engineering Services Compiler Team
Date: 26 Nov 2004 09:47:44 -0200
In-Reply-To: <20041125210137.GD2849@parcelfarce.linux.theplanet.co.uk>
Message-ID: <ory8goygpr.fsf@livre.redhat.lsd.ic.unicamp.br>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 25, 2004, Matthew Wilcox <matthew@wil.cx> wrote:

> On Thu, Nov 25, 2004 at 04:20:06PM -0200, Alexandre Oliva wrote:
>> This means these headers shouldn't reference each other as
>> linux/user/something.h, but rather as linux/something.h, such that
>> they still work when installed in /usr/include/linux.  This may
>> require headers include/linux/something.h to include
>> linux/user/something.h, but that's already part of the proposal.

> That's going to take severe brain-ache to get right ... and worse,
> keep right.  These headers aren't going to get tested outside the kernel
> tree often.  So we'll have missing includes and files that only work if
> the <linux/> they're including is a kernel one rather than a user one.

How about moving the internals (i.e., what's not to be exported to
userland) from linux and asm elsewhere, then?

Sure, it means significantly more churn in the kernel, but there's
going to be a lot of moving stuff around one way or the other.

While at that, we could also split what's kernel internal for real and
what's to be visible to external kernel modules as well.  So we'd have
3 layers of headers, instead of two.  I'm not sure this actually makes
any sense though, since there might be lots of dependencies of headers
for modules on internal headers.

-- 
Alexandre Oliva             http://www.ic.unicamp.br/~oliva/
Red Hat Compiler Engineer   aoliva@{redhat.com, gcc.gnu.org}
Free Software Evangelist  oliva@{lsd.ic.unicamp.br, gnu.org}
