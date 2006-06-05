Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1750748AbWFEIWs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750748AbWFEIWs (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 04:22:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750751AbWFEIWs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 04:22:48 -0400
Received: from canuck.infradead.org ([205.233.218.70]:32461 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S1750748AbWFEIWs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 04:22:48 -0400
Subject: Re: [PATCH] Use ld's garbage collection feature
From: David Woodhouse <dwmw2@infradead.org>
To: Marcelo Tosatti <marcelo@kvack.org>
Cc: linux-kernel@vger.kernel.org, Arjan van de Ven <arjan@linux.intel.com>
In-Reply-To: <20060605003152.GA1364@dmt>
References: <20060605003152.GA1364@dmt>
Content-Type: text/plain
Date: Mon, 05 Jun 2006 09:22:43 +0100
Message-Id: <1149495763.30024.36.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.1.dwmw2.2) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-06-04 at 21:31 -0300, Marcelo Tosatti wrote:
> - Do not discard symbols referenced by modules (via KEEP directive
> from linker script). 

I think we should keep _all_ symbols which are exported, except perhaps
if some _extra_ config option hidden behing CONFIG_EMBEDDED is set. It
isn't acceptable to break the case of modules which you build only later
or out-of-tree.

I also want to play with '-fwhole-program --combine'. There's currently
a compiler bug with --combine getting on my tits, but if you #include
the whole of fs/jffs2/*.c or fs/ext3/*.c from one file and build that
with -fwhole-program, you also see a fair amount of benefit.

That would also render a certain amount of the gc-sections improvements
obsolete, although we can't use -fwhole-program in core code; only 'leaf
object' like drivers and filesystems so I think gc-sections is still
going to be a win.

-- 
dwmw2

