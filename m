Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965049AbVI0TbZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965049AbVI0TbZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 15:31:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965053AbVI0TbZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 15:31:25 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:32232 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S965049AbVI0TbY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 15:31:24 -0400
Date: Tue, 27 Sep 2005 12:30:55 -0700
From: Paul Jackson <pj@sgi.com>
To: Joel Schopp <jschopp@austin.ibm.com>
Cc: haveblue@us.ibm.com, mrmacman_g4@mac.com, akpm@osdl.org,
       lhms-devel@lists.sourceforge.net, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, mel@csn.ul.ie, kravetz@us.ibm.com
Subject: Re: [PATCH 1/9] add defrag flags
Message-Id: <20050927123055.0ad9c2b4.pj@sgi.com>
In-Reply-To: <433991A0.7000803@austin.ibm.com>
References: <4338537E.8070603@austin.ibm.com>
	<43385412.5080506@austin.ibm.com>
	<21024267-29C3-4657-9C45-17D186EAD808@mac.com>
	<1127780648.10315.12.camel@localhost>
	<20050926224439.056eaf8d.pj@sgi.com>
	<433991A0.7000803@austin.ibm.com>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joel wrote:
> We may not be able to use the same flag after all due to our need to mark buffer 
> pages as user.

Agreed - we have separate flags.  I want exactly user address space
pages.  You want really easy to reclaim pages.  You have good
performance justifications for your choice.  I have just "design
purity", so if for some reason there was a dire shortage of GFP bits,
I suspect it is I who should give, not you.

> > +#define __GFP_BITS_SHIFT 21	/* Room for 20 __GFP_FOO bits */
> 
> Yep.

Once this is merged with current Linux, which already has GFP_HARDWALL,
I presume you will be back up to 21 bits, code and comment.

As I noted in another message the "USER" and the comment in:

#define __GFP_USER	0x40000u /* User is a userspace user */

are a bit misleading now.  Perhaps GFP_EASYRCLM?

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
