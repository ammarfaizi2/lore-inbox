Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261898AbVGVBVM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261898AbVGVBVM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Jul 2005 21:21:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261970AbVGVBVM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Jul 2005 21:21:12 -0400
Received: from zproxy.gmail.com ([64.233.162.202]:5391 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261898AbVGVBVL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Jul 2005 21:21:11 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=s+miuJVGUVV/8lIZZdt7eVuTtNoe5AKJsvz36cGT1nXoSau79Ef951jNm/OmAn9kk77jZLaVsr+bc1Qa+WKLylUkFfG2e8JpQKlobh+AgophmY2hglgL6ero4R0BJzaceNw6a6IPHk597rduZ98npIu12mWnFtqxQxeSLf+g1vk=
Message-ID: <9a87484905072118207a85970e@mail.gmail.com>
Date: Fri, 22 Jul 2005 03:20:16 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
Reply-To: Jesper Juhl <jesper.juhl@gmail.com>
To: gbakos@cfa.harvard.edu
Subject: Re: kernel page size explanation
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.SOL.4.58.0507211925170.28852@titan.cfa.harvard.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <Pine.SOL.4.58.0507211925170.28852@titan.cfa.harvard.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/22/05, Gaspar Bakos <gbakos@cfa.harvard.edu> wrote:
> Hi,
> 
> Sorry for this nursery-school question.
> 
> Could someone briefly explain me :
> 1. what is the kernel page size (any _useful_ pointer on the web is fine),

Depends on arch. Take a look at PAGE_SIZE and PAGE_SHIFT - look in
include/asm-*/page.h
Here's a nice web interface for browsing the source and quickly
finding the info you need :)  : http://lxr.linux.no/ident?i=PAGE_SIZE

> 2. how can one tune it (for 2.6.*)?

For some archs the page size can be set at compile-time with
CONFIG_PAGE_SIZE_4KB, CONFIG_PAGE_SIZE_8KB etc - mips is an example of
such an arch (also take a look at CONFIG_HUGETLB_PAGE and friends).

> 3. what kind of effect does it have on system performance, if it is
> tuneable, and if it worth changing this at all?
> 
Depends on your workload.

> I am a bit confused; at one place i see someone saying that the kernel
> page size is 4kb for i386.
> At another place I see a statement:
> "I tried all four possible page sizes on Itanium (4k, 8k, 16k and 64k)"
> 
That makes perfect sense - i386 uses a 4K page size, ia64 is one of
the archs that support different page sizes (via
CONFIG_IA64_PAGE_SIZE_* ).
some i386 machines can also use 4MB pages IIRC, but I don't think
Linux lets you configure that for i386, but I'm not entirely sure.

> How can i figure out the page size of the kernel i am currently using?
> 
You can
 A) look in the .config file for your current kernel (if your arch
supports different page sizes at all).
 B) You can use the  getpagesize(2) syscall at runtime. getpagesize()
returns the nr of bytes in a page - man getpagesize - I'm not sure
that's universally supported though.
 C) You can look at /proc/cpuinfo or /proc/meminfo , IIRC some archs
report page size there - not quite sure, can't remember...


-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
