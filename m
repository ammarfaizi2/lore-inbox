Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261628AbULNT7R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261628AbULNT7R (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 14:59:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261634AbULNT7R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 14:59:17 -0500
Received: from fw.osdl.org ([65.172.181.6]:58860 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261628AbULNT7N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 14:59:13 -0500
Date: Tue, 14 Dec 2004 11:58:47 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Sam Ravnborg <sam@ravnborg.org>
cc: Horst von Brand <vonbrand@inf.utfsm.cl>,
       Werner Almesberger <wa@almesberger.net>,
       Paul Mackerras <paulus@samba.org>, Greg KH <greg@kroah.com>,
       David Woodhouse <dwmw2@infradead.org>, Matthew Wilcox <matthew@wil.cx>,
       David Howells <dhowells@redhat.com>, hch@infradead.org,
       aoliva@redhat.com, linux-kernel@vger.kernel.org,
       libc-hacker@sources.redhat.com
Subject: Re: [RFC] Splitting kernel headers and deprecating __KERNEL__
In-Reply-To: <20041214194531.GB13811@mars.ravnborg.org>
Message-ID: <Pine.LNX.4.58.0412141150460.3279@ppc970.osdl.org>
References: <20041214135029.A1271@almesberger.net>
 <200412141923.iBEJNCY9011317@laptop11.inf.utfsm.cl> <20041214194531.GB13811@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 14 Dec 2004, Sam Ravnborg wrote:
> 
> Today we only pull in stdarg.h from userspace - actually a compiler
> dependent file.

Indeed. You'll notice that gcc doesn't even put stdarg.h in /usr/include, 
it's in the compiler-specific header file directory, usually something 
like /usr/lib/gcc-lib/<vendor>/<version>/include.

We used to compile with "-nostdinc" to make sure that you couldn't include 
user files even by mistake, but that was removed for some reason I can't 
for the life of me remember any more.

We probably should do it again. Something vaguely like

	CFLAGS += -nostdinc -I $(CC -print-file-name=include)

should do it (and still pick up "stdarg.h").

		Linus
