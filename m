Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261369AbUFJNfk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261369AbUFJNfk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jun 2004 09:35:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261347AbUFJNfk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jun 2004 09:35:40 -0400
Received: from 34.mufa.noln.chcgil24.dsl.att.net ([12.100.181.34]:9982 "EHLO
	tabby.cats.internal") by vger.kernel.org with ESMTP id S261321AbUFJNfb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jun 2004 09:35:31 -0400
Content-Type: text/plain;
  charset="CP 1252"
From: Jesse Pollard <jesse@cats-chateau.net>
To: "Robert White" <rwhite@casabyte.com>, "'Ingo Molnar'" <mingo@elte.hu>,
       "'Christoph Hellwig'" <hch@infradead.org>,
       "'Mike McCormack'" <mike@codeweavers.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: WINE + NX (No eXecute) support for x86, 2.6.7-rc2-bk2
Date: Thu, 10 Jun 2004 08:35:17 -0500
X-Mailer: KMail [version 1.2]
References: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA2ZSI4XW+fk25FhAf9BqjtMKAAAAQAAAAdFYhVEbxb0Kgbx4hvCgIkQEAAAAA@casabyte.com>
In-Reply-To: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA2ZSI4XW+fk25FhAf9BqjtMKAAAAQAAAAdFYhVEbxb0Kgbx4hvCgIkQEAAAAA@casabyte.com>
MIME-Version: 1.0
Message-Id: <04061008351700.11472@tabby>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 09 June 2004 15:53, Robert White wrote:
> Which is why I, later in the same message, wrote:
>
> Architecturally the easy-application-accessible switch should be something
> more than a syscall to prevent a return-address-twiddle invoking the call
> directly.  I'd make it a /proc/self something, or put it in a separate
> include-only-if-used shared library or something.  If the minimal distance
> is opening and writing a normally-untouched file then you get a nice
> support matrix.  (e.g. no file means no feature, file plus action means
> executable stack, no action means system default (old can, new cannot),
> hacks would require a variable (fd) and executing arbitrary code to open
> and write that file, programs/programmers that want/need the old behavior
> can achieve it without having to know how to manipulate their ELF headers
> or tool-chains, etc.)
>
> Which is not susceptible to the 1-2 attack you mention below because the
> open and write cannot be done on a protected stack or heap, since it would
> then have to be (er... ) executed to perform the hack.
>
> Ahhhh, yes...

no. This only means the 1-2 attack must be done in two steps (maybe three).

1. create the file (first buffer overflow)
2. write? (second buffer overflow - depends on whether file must have value)
3. disable NX (third)
