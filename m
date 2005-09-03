Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750701AbVICGl0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750701AbVICGl0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Sep 2005 02:41:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751392AbVICGl0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Sep 2005 02:41:26 -0400
Received: from codepoet.org ([166.70.99.138]:1924 "EHLO codepoet.org")
	by vger.kernel.org with ESMTP id S1750701AbVICGlZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Sep 2005 02:41:25 -0400
Date: Sat, 3 Sep 2005 00:41:24 -0600
From: Erik Andersen <andersen@codepoet.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] Splitting out kernel<=>userspace ABI headers
Message-ID: <20050903064124.GA31400@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: andersen@codepoet.org,
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
References: <C670AD22-97CF-46AA-A527-965036D78667@mac.com> <20050902134108.GA16374@codepoet.org> <22D79100-00B5-44F6-992C-FFFEACA49E66@mac.com> <20050902235833.GA28238@codepoet.org> <dfapgu$dln$1@terminus.zytor.com> <20050903042859.GA30101@codepoet.org> <4319330C.5030404@zytor.com> <20050903055007.GA30966@codepoet.org> <43193A4F.5030906@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43193A4F.5030906@zytor.com>
X-No-Junk-Mail: I do not want to get *any* junk mail.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri Sep 02, 2005 at 10:53:19PM -0700, H. Peter Anvin wrote:
> Erik Andersen wrote:
> >On Fri Sep 02, 2005 at 10:22:20PM -0700, H. Peter Anvin wrote:
> >
> >>Exportable types need to be double-underscore types, because the header 
> >>files in user space that would include them can generally not include 
> >><stdint.h>.
> >
> >
> >I'm not talking about kernel headers that have to worry about
> >eventually being included in user space headers.  Those nearly
> >all live in include/asm.  I'm talking about the kernel headers
> >that define how userspace is supposed to interface with
> >particular kernel drivers or hardware.  Headers such as
> >linux/cdrom.h and linux/loop.h and linux/fb.h.
> >
> 
> What are you going to do with them if you're not going to include them 
> in userspace?!!!
> 
> If you're proposing one policy for linux/loop.h and one for sys/stat.h, 
> I would have to classify that as insane.  Everything that gets exported 
> to userspace should behave the same way, please.

That is certainly not what I was proposing.  Why are you bringing
sys/stat.h into this?  The contents of sys/stat.h are entirely up
to SUSv3 and the C library to worry about.  Nobody has proposed
mucking with that.  I dunno about your C library, but mine
doesn't include linux/* header files (not even sys/stat.h).  And
I'd really like to fix uClibc to not use any asm/* either, since
much of it is entirely unsuitable for user space.

I am proposing a single consistant policy for all of linux/* such
that all linux/* headers that need integer types of a specific
size shall #include unistd.h and use ISO C99 types rather that
the ad-hoc kernel types they now use.

The policy has _long_ been that user space must never include
linux/* header files.  Since we are now proposing a project to
reverse this policy, the long standing policy making linux/*
verboten now leaves us completely free to do pretty much anything
with linux/*.  And what I want is for linux/* to use the shiny
ISO C99 types.

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
