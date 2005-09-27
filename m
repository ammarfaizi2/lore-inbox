Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965155AbVI0VYP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965155AbVI0VYP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 17:24:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965152AbVI0VYO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 17:24:14 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:29911 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S965153AbVI0VYO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 17:24:14 -0400
Date: Tue, 27 Sep 2005 14:23:55 -0700
From: Paul Jackson <pj@sgi.com>
To: Joel Schopp <jschopp@austin.ibm.com>
Cc: haveblue@us.ibm.com, mrmacman_g4@mac.com, akpm@osdl.org,
       lhms-devel@lists.sourceforge.net, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, mel@csn.ul.ie, kravetz@us.ibm.com
Subject: Re: [Lhms-devel] Re: [PATCH 1/9] add defrag flags
Message-Id: <20050927142355.232f6e95.pj@sgi.com>
In-Reply-To: <4339B2F6.1070806@austin.ibm.com>
References: <4338537E.8070603@austin.ibm.com>
	<43385412.5080506@austin.ibm.com>
	<21024267-29C3-4657-9C45-17D186EAD808@mac.com>
	<1127780648.10315.12.camel@localhost>
	<20050926224439.056eaf8d.pj@sgi.com>
	<433991A0.7000803@austin.ibm.com>
	<20050927123055.0ad9c2b4.pj@sgi.com>
	<4339B2F6.1070806@austin.ibm.com>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> But for now I'm going to  leave it __GFP_USER.

Well, then, at least fix the comment, from the rather oddly phrased:

#define __GFP_USER	0x40000u /* User is a userspace user */

to something more accurate such as:

#define __GFP_USER	0x40000u /* User and other really easily reclaimed pages */

And consider adding a comment to its use in fs/buffer.c, where marking
a page obviously destined for kernel space __GFP_USER seems strange.
I doubt I will be the last person to look at the line of code and
scratch my head.

Nice clear simple names such as __GFP_USER (only a kernel hacker would
say that ;) should not be used if they are a flat out lie.  Better to
use some tongue twister acronym, such as

#define__GFP_RRE_RCLM 0x40000u /* Really Really Easy ReCLaiM (user, buffer) */

so that people don't think they know what something means when they don't.

And the one thing you could say that's useful in this name, that it has
something to do with the reclaim mechanism, is missing - no 'RCLM' in it.

Roses may smell sweet by other names, but kernel names for things do
matter.  Unlike classic flowers, we have an awful lot of colorless,
ordorless stuff in there that no one learns about in childhood (Linus's
child notwithstanding ;).  We desparately need names to tell the
essentials, and not lie.  __GFP_USER does neither.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
