Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261832AbULQN0f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261832AbULQN0f (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 08:26:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262061AbULQN0d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 08:26:33 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:14517 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S261832AbULQN0a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 08:26:30 -0500
Date: Fri, 17 Dec 2004 14:26:11 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Dave Hansen <haveblue@us.ibm.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       geert@linux-m68k.org, ralf@linux-mips.org,
       linux-mm <linux-mm@kvack.org>
Subject: Re: [patch] [RFC] make WANT_PAGE_VIRTUAL a config option
In-Reply-To: <1103257482.13614.2817.camel@localhost>
Message-ID: <Pine.LNX.4.61.0412171132560.793@scrub.home>
References: <E1Cf3bP-0002el-00@kernel.beaverton.ibm.com> 
 <Pine.LNX.4.61.0412170133560.793@scrub.home>  <1103244171.13614.2525.camel@localhost>
  <Pine.LNX.4.61.0412170150080.793@scrub.home>  <1103246050.13614.2571.camel@localhost>
  <Pine.LNX.4.61.0412170256500.793@scrub.home> <1103257482.13614.2817.camel@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 16 Dec 2004, Dave Hansen wrote:

> Sorry I didn't provide this.  My recent effort started to clean up some
> ugliness in some current patches that worked around this actually
> happening a few months ago.  The original example didn't survive :)

There are two points, which did originally catch my attention.
1) Where/why do you want to remove the dependency on asm/page.h?
2) Does every structure really needs its own header?

If you want to do such a cleanup, it would be helpful to have some more 
information about where you want to go, otherwise you may create a more 
twisted maze of header files. The big question here is what further 
cleanups are possible in this area?
What basically needs to be done is to separate the definitions from its 
users, that doesn't mean every definition needs its own header file. Why 
not create a single header file which collects a number of mm related 
definitions? E.g. struct vm_area_struct is also used by a number of header 
files, although its main users have already been separated into 
asm/tlbflush.h and so created even more headers.
So to allow further header cleanup, we should look what other definitions 
can be pulled out of mm.h and related headers. mm.h should probably stay a 
high level header, but I'd also like to see a cleanup of asm/page.h. The 
page table definitions in there should be available to every mm related 
header.
I had to look closer at this, but I did this for struct task_struct and 
making it available for lowlevel header files. I rediffed the patches and 
put them at http://www.xs4all.nl/~zippel/task_patches/

bye, Roman
