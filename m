Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261812AbRESO6q>; Sat, 19 May 2001 10:58:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261813AbRESO61>; Sat, 19 May 2001 10:58:27 -0400
Received: from osc.edu ([192.148.249.4]:56570 "EHLO osc.edu")
	by vger.kernel.org with ESMTP id <S261812AbRESO6Y>;
	Sat, 19 May 2001 10:58:24 -0400
Date: Sat, 19 May 2001 10:58:20 -0400
From: Pete Wyckoff <pw@osc.edu>
To: Tigran Aivazian <tigran@veritas.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: dget()
Message-ID: <20010519105820.B29838@bigger.osc.edu>
In-Reply-To: <989917611.27689.9.camel@nomade> <Pine.LNX.4.21.0105151012470.1705-100000@penguin.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0105151012470.1705-100000@penguin.homenet>; from tigran@veritas.com on Tue, May 15, 2001 at 10:14:47AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

tigran@veritas.com said:
> # cd /usr/src/linux
> # find -name '*.[ch]' | ctags -L- &
>
> On 15 May 2001, Xavier Bestel wrote:
> > # cd /usr/src/linux
> > # make tags
> 
> No, I never use that one because it skips very useful entries like the
> ones from EXPORT_SYMBOL etc. Also, it only shows the current architecture.
> So, the tags target in the Makefile would only become useful when it is
> stripped of extra (unnecessary, imho) logic and turned into a plain one I
> suggested above.

You can use the -I feature to ignore some keywords, but not the
functions they modify.  Without ignoring __initdata, for instance, you
get a couple hundred tags for it, and none for the actual variable,
e.g. cpu_vendor_names.  My current ignore list for the kernel is at
http://www.osc.edu/~pw/ctags-ignore .
If you really want to see the EXPORT_SYMBOL(tag) lines, you'll want
to remove that one from the list (and be sure to do the sorting...),

Next, the wonderful editor Vim doesn't read my mind quite well enough.
When I want to see the tag for "page", for example, I really
want to look at the definition of the struct in include/linux/mm.h, not
at any of the 16 other places which declare a variable struct page *page;.
So I run the tags file through a perl script which percolates those
interesting items to the top when there are multiple entries for the
same identifier.  It's here: http://www.osc.edu/~pw/sort-tags .

Finally, I modify the Makefile to generate tags with these
modifications. Here's the snippet: 

tags: dummy
	( find include/asm-$(ARCH) -name "*.h" ;\
	  find include -type d \( -name "asm-*" -o -name config \) -prune \
	  -o -name "*.h" -print ; find $(SUBDIRS) init -name '*.[chS]' ) |\
	ctags -I../ctags-ignore -L - -f - | sort-tags > tags

Note that this only generates tags for your current architecture,
and that your ctags must be Exuberant and version >= 5.0.

		-- Pete
