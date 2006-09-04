Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964819AbWIDMg2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964819AbWIDMg2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 08:36:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964803AbWIDMg2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 08:36:28 -0400
Received: from mx1.redhat.com ([66.187.233.31]:26585 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964819AbWIDMg1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 08:36:27 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20060904115845.GP4416@stusta.de> 
References: <20060904115845.GP4416@stusta.de>  <20060903220657.GG4416@stusta.de> <14367.1157361985@warthog.cambridge.redhat.com> 
To: Adrian Bunk <bunk@stusta.de>
Cc: David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: frv compile error in set_pte() 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Mon, 04 Sep 2006 13:35:23 +0100
Message-ID: <30253.1157373323@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@stusta.de> wrote:

> > Does your compiler support the 'M' and 'U' constraint modifiers on FRV?
> 
> It's a gcc 4.1.1 from ftp.gnu.org.

I presume this:

	#define set_pte(pteptr, pteval) \
	do {                                                    \
		*(pteptr) = (pteval);                           \
		asm volatile("dcf %M0" :: "U"(*pteptr));        \
	} while(0)

	void jump(unsigned long *ppte, unsigned long pte)
	{
		set_pte(ppte, pte);
	}

Shows the problem.


I was in the process of checking that all the FRV constraint stuff got
upstream, but was stalled by an ICE whilst building the gcc-4.2.  This logged
as gcc bug #28583 and not as yet fixed.

However, I've run the above test program with the xgcc intermediate compiler
built during the compilation of gcc, and that shows the problem you're
reporting.  I'll chase it up.


Meanwhile, if you want to use a working, though older gcc, you can find one in:

	ftp://ftp.ges.redhat.com/private/releng/frv-060512-Fc6734/tools.tar.bz2

David

-- 
VGER BF report: H 0.0672117
