Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265332AbSKAQXG>; Fri, 1 Nov 2002 11:23:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265337AbSKAQXF>; Fri, 1 Nov 2002 11:23:05 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:62599 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S265332AbSKAQXF>; Fri, 1 Nov 2002 11:23:05 -0500
Subject: Re: [STATUS 2.5]  October 30, 2002
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Pavel Machek <pavel@ucw.cz>, Dave Jones <davej@codemonkey.org.uk>,
       boissiere@adiglobal.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <m1ela5gzb5.fsf@frodo.biederman.org>
References: <20021030161708.GA8321@suse.de>
	<m1iszjgmaz.fsf@frodo.biederman.org> <20021031230136.GE4331@elf.ucw.cz> 
	<m1ela5gzb5.fsf@frodo.biederman.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 01 Nov 2002 16:49:48 +0000
Message-Id: <1036169388.12534.48.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-11-01 at 14:05, Eric W. Biederman wrote:
> When you have a correctable ECC error on a page you need to rewrite the
> memory to remove the error.  This prevents the correctable error from becoming
> an uncorrectable error if another bit goes bad.  Also if you have a
> working software memory scrub routine you can be certain multiple
> errors from the same address are actually distinct.  As opposed to
> multiple reports of the same error.

Note that this area has some extremely "interesting" properties. For one
you have to be very careful what operation you use to scrub and its
platform specific. On x86 for example you want to do something like lock
addl $0, mem. A simple read/write isnt safe because if the memory area
is a DMA target your read then write just corrupted data and made the
problem worse not better!

