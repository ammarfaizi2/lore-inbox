Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964930AbWD0EdJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964930AbWD0EdJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 00:33:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964931AbWD0EdJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 00:33:09 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:22722 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S964930AbWD0EdH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 00:33:07 -0400
To: David Woodhouse <dwmw2@infradead.org>
cc: Linus Torvalds <torvalds@osdl.org>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Reply-To: Gerrit Huizenga <gh@us.ibm.com>
From: Gerrit Huizenga <gh@us.ibm.com>
Subject: Re: Simple header cleanups 
In-reply-to: Your message of Thu, 27 Apr 2006 04:00:30 BST.
             <1146106830.2885.44.camel@hades.cambridge.redhat.com> 
Date: Wed, 26 Apr 2006 21:32:47 -0700
Message-Id: <E1FYyBL-0007NT-00@w-gerrit.beaverton.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 27 Apr 2006 04:00:30 BST, David Woodhouse wrote:
> On Wed, 2006-04-26 at 19:27 -0700, Gerrit Huizenga wrote:
> > Plus, do we really want Apache or other licensed software directly
> > including GPL header files?  Oh what a tangled web we weave when we
> > suck GPL headers into other applications. 
> 
> libstdc++ is GPL too. Why's that not a problem? Because it has an
> exception explicitly allowing you to use it _without_ becoming covered
> by the GPL, in certain circumstances. A bit like this one:
> 
>    NOTE! This copyright does *not* cover user programs that use kernel
>  services by normal system calls - this is merely considered normal use
>  of the kernel, and does *not* fall under the heading of "derived work".
 
 This is not in conflict with the GPL in any way - just a clarification
 of the address boundary between running applications and the kernel
 address space.  In other words, if running any application on a GPL
 kernel virally infected those applications, very few people would ever
 use a GPL'd kernel.  Same is true with a GPL application - it clearly
 could not infect the kernel it was running on.  I believe this is
 nothing but a clarification of an interpretation of the GPL as it
 stands today (well, GPL and copyright law).

 This does not say that you can #include files from any source, including
 the kernel, which are released/licensed under the GPL.  The GPL
 specifically locks out any changes to the GPL so even if you wanted
 to provide an exception.  Keep in mind that this is inclusion into
 a source from which you build a binary and then redistribute that
 binary, such as in an rpm.  That is different from the libstdc++
 exception below, which is a *runtime* exception, not a compile time
 exception.

> Of course, the libstdc++ exception was written a bit more carefully than
> ours, but ours seems to be perfectly sufficient.
> 
> http://gcc.gnu.org/onlinedocs/libstdc++/17_intro/license.html

 The little suggestion of speaking to a lawyer (since I am not one,
 have never played one on TV, and would never admit to speaking to
 one) is a good suggestion.  However, note that you can build a
 free software *library* with this code because of this exception
 (which is purportedly replicated in every related header file)
 but this does not mean that you could include those files directly
 in an application.  Also, this is not the exception that is currently
 associated with the kernel header files so I'm not sure that I
 see a way to retroactively apply it.

 I think the technically correct "legal" approach is to create a
 set of header files which contain only user level APIs, release those
 under the LGPL as part of the kernel tree (I don't know if they need
 to be dual licensed LGPL/GPL but I think not) and maintain them as
 though they are the published, official API to the kernel.  Typically,
 structure definition, trival #define's and the like are not usually
 viewed as something that can be copyrighted (my believe, confirm with
 someone who actually knows something about copyright law).  Those
 new header files are not subject to copyright at least and I'm
 not sure that they would necessarily count as a "derived" work.

 This stuff is ugly.

gerrit
