Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932237AbWAPHqp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932237AbWAPHqp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 02:46:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932241AbWAPHqp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 02:46:45 -0500
Received: from smtp.osdl.org ([65.172.181.4]:17288 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932237AbWAPHqp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 02:46:45 -0500
Date: Sun, 15 Jan 2006 23:46:18 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Jan Beulich" <JBeulich@novell.com>
Cc: sam@ravnborg.org, benh@kernel.crashing.org, ak@muc.de, paulus@samba.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] CONFIG_UNWIND_INFO
Message-Id: <20060115234618.6745a7c8.akpm@osdl.org>
In-Reply-To: <43CB5B15.76F0.0078.0@novell.com>
References: <4370AF4A.76F0.0078.0@novell.com>
	<20060114045635.1462fb9e.akpm@osdl.org>
	<20060114140301.GA8443@mars.ravnborg.org>
	<43CB5B15.76F0.0078.0@novell.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Jan Beulich" <JBeulich@novell.com> wrote:
>
> >>> Sam Ravnborg <sam@ravnborg.org> 14.01.06 15:03:01 >>>
> >On Sat, Jan 14, 2006 at 04:56:35AM -0800, Andrew Morton wrote:
> >> 
> >> > Index: linux/Makefile
> >> > ===================================================================
> >> > --- linux.orig/Makefile
> >> > +++ linux/Makefile
> >> > @@ -502,6 +502,10 @@ CFLAGS		+= $(call add-align,CONFIG_CC_AL
> >> >  CFLAGS		+= $(call add-align,CONFIG_CC_ALIGN_LOOPS,-loops)
> >> >  CFLAGS		+= $(call add-align,CONFIG_CC_ALIGN_JUMPS,-jumps)
> >> >  
> >> > +ifdef CONFIG_UNWIND_INFO
> >> > +CFLAGS		+= -fasynchronous-unwind-tables
> >> > +endif
> >Is this option available on all gcc's for all archs?
> >Otherwise you have to do:
> >CFLAGS		+= $(call cc-option,-fasynchronous-unwind-tables,)
> 
> Yes, it is (and it has been at least since 3.2.x). Apparently the PPC backend doesn't fully support this...
> 

And others might not support it either.  We don't know.

Perhaps this option should be enabled only on architectures where it's known
to work, rather than disabled only on ppc64, as my fix does.
