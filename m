Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964993AbWD0Its@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964993AbWD0Its (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 04:49:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964994AbWD0Its
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 04:49:48 -0400
Received: from khc.piap.pl ([195.187.100.11]:43281 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S964993AbWD0Itr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 04:49:47 -0400
To: Denis Vlasenko <vda@ilport.com.ua>
Cc: Linus Torvalds <torvalds@osdl.org>, David Woodhouse <dwmw2@infradead.org>,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: Simple header cleanups
References: <1146104023.2885.15.camel@hades.cambridge.redhat.com>
	<1146107871.2885.60.camel@hades.cambridge.redhat.com>
	<Pine.LNX.4.64.0604262028130.3701@g5.osdl.org>
	<200604271010.06711.vda@ilport.com.ua>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Thu, 27 Apr 2006 10:49:42 +0200
In-Reply-To: <200604271010.06711.vda@ilport.com.ua> (Denis Vlasenko's message of "Thu, 27 Apr 2006 10:10:06 +0300")
Message-ID: <m3fyjze72x.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Denis Vlasenko <vda@ilport.com.ua> writes:

> Maybe we should have a script which processes kernel's include/linux/*
> files and produces sanitized set of headers (by deleting
> "#ifdef __KERNEL__" blocks, etc), which will be treated at
> *the* official kernel<->userspace API and will be used by glibc etc?

It would really be better to create "ABI/API" header set in the
kernel at last. Glibc people, Linux-only kernel utils and of course
the rest of the kernel could just #include the API files (a copy
probably).

We _do_ have a stable userspace ABI and API, and contrary to the popular
belief the header set would be quite small (probably an order of magnitude
smaller than the "sanitized headers" package). What we need to export is
the actual API (including things like ioctl, netlink, SG_IO etc), most
things should be kept private to the kernel (and never copied anywhere
etc).

I realize this is completely uninteresting job. Perhaps someone wants
to pay a bit for having done it?

Why do we need, for example, /usr/include/linux/sc26198.h (FC5's
glibc-kernheaders-3.0-5.2)?

 *      sc26198.h  -- SC26198 UART hardware info.
...
/*
 *      Global register definitions. These registers are global to each 26198
 *      device, not specific ports on it.
 */
#define TSTR            0x0d
#define GCCR            0x0f
#define ICR             0x1b
-- 
Krzysztof Halasa
