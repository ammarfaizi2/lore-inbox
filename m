Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932606AbWJFUjb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932606AbWJFUjb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 16:39:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932623AbWJFUjb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 16:39:31 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:721 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932612AbWJFUj2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 16:39:28 -0400
Subject: Re: [PATCH] Cast removal
From: Arjan van de Ven <arjan@infradead.org>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Muli Ben-Yehuda <muli@il.ibm.com>,
       "Moore, Robert" <robert.moore@intel.com>, Andrew Morton <akpm@osdl.org>,
       Len Brown <lenb@kernel.org>, "Brown, Len" <len.brown@intel.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ACPI List <linux-acpi@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0610062211220.30417@yvahk01.tjqt.qr>
References: <B28E9812BAF6E2498B7EC5C427F293A40114A6CB@orsmsx415.amr.corp.intel.com>
	 <20061006143555.GC14186@rhun.haifa.ibm.com>
	 <Pine.LNX.4.61.0610062211220.30417@yvahk01.tjqt.qr>
Content-Type: text/plain; charset=UTF-8
Organization: Intel International BV
Date: Fri, 06 Oct 2006 22:39:13 +0200
Message-Id: <1160167153.3000.118.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-10-06 at 22:18 +0200, Jan Engelhardt wrote:
> >> -	(void) kmem_cache_destroy(cache);
> >> +	kmem_cache_destroy(cache);
> >> 
> >> I believe that the point of the (void) is to prevent lint from
> >> squawking, and perhaps some picky ANSI-C compilers. What is the overall
> >> Linux policy on this?
> >
> >IMHO there's another reason to do this which is much more relevant: it
> >tells the reader that whoever wrote it knows that it returns a value
> >and ignores it on purpose.
> 
> And GCC does not care about that, i.e. it still prints foritfy warnings, 
> as in:
> 
> $ svn co https://svn.sourceforge.net/svnroot/ttyrpld/trunk a && cd a
> $ make user/rpld.o EXT_CFLAGS="-D_FORTIFY_SOURCE=2"
> user/rpld.c:425: warning: ignoring return value of ‘write’, declared 
> with attribute warn_unused_result

this is by design. __must_check means you MUST do it.


