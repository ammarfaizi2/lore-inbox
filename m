Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945986AbWBDJgh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945986AbWBDJgh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Feb 2006 04:36:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945987AbWBDJgh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Feb 2006 04:36:37 -0500
Received: from smtp.osdl.org ([65.172.181.4]:14042 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1945986AbWBDJgg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Feb 2006 04:36:36 -0500
Date: Sat, 4 Feb 2006 01:36:13 -0800
From: Andrew Morton <akpm@osdl.org>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc1-mm5
Message-Id: <20060204013613.0567ff5a.akpm@osdl.org>
In-Reply-To: <20060204092941.GB9275@mars.ravnborg.org>
References: <20060203000704.3964a39f.akpm@osdl.org>
	<20060204092941.GB9275@mars.ravnborg.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Ravnborg <sam@ravnborg.org> wrote:
>
> On Fri, Feb 03, 2006 at 12:07:04AM -0800, Andrew Morton wrote:
>  > 
>  > Known problems:
>  > 
>  > - Sam has added a new check in the kbuild tree.  It detects multiple
>  >   instances of EXPORT_SYMBOL(foo) across separate .o files.
>  > 
>  >   It catches a _lot_ of problems.   You'll see something like this:
> 
>  Sigh. I did a 'make allmodconfig' on x86_64 and found to my suprise only
>  a sinlge symbol being exported more than one time.
> 
>  This is purely a consistency check introduced by commit:
>  http://www.kernel.org/git/?p=linux/kernel/git/sam/kbuild.git;a=commit;h=cd1f125e5808203d3bf58f1d04a9cbd33f60fdb6

There were several tens on powerpc, sparc64, etc.

>  I can rip it out again if the noise/value ratio is too high.

No, let's keep it.  We're wasting memory on this stuff.

> We should IMO try to keep the exports in generic code.

Yes, I guess so.  It gets tricky when you get onto things like the string
functions, most of which may be impemented in generic code or may be in
arch code, depending on __ARCH_HAVE_stuff.
