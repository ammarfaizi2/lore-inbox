Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261744AbVAGXgQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261744AbVAGXgQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 18:36:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261719AbVAGXeN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 18:34:13 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:50693 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261739AbVAGXcv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 18:32:51 -0500
Date: Sat, 8 Jan 2005 00:32:47 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Christoph Hellwig <hch@infradead.org>, mingo@elte.hu,
       viro@parcelfarce.linux.theplanet.co.uk, paulmck@us.ibm.com,
       arjan@infradead.org, linux-kernel@vger.kernel.org, jtk@us.ibm.com,
       wtaber@us.ibm.com, pbadari@us.ibm.com, markv@us.ibm.com,
       greghk@us.ibm.com, torvalds@osdl.org
Subject: Re: [PATCH] fs: Restore files_lock and set_fs_root exports
Message-ID: <20050107233246.GH14108@stusta.de>
References: <20050106203258.GN26051@parcelfarce.linux.theplanet.co.uk> <20050106210408.GM1292@us.ibm.com> <20050106212417.GQ26051@parcelfarce.linux.theplanet.co.uk> <20050106152621.395f935e.akpm@osdl.org> <20050106234123.GA27869@infradead.org> <20050106162928.650e9d71.akpm@osdl.org> <20050107002624.GA29006@infradead.org> <20050107090014.GA24946@elte.hu> <20050107091542.GA5295@infradead.org> <20050107140034.46aec534.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050107140034.46aec534.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 07, 2005 at 02:00:34PM -0800, Andrew Morton wrote:
> 
> No, I'd say that unexports are different.  They can clearly break existing
> code and so should only be undertaken with caution, and with lengthy notice
> if possible.
> 
> And it _is_ possible here, because there are no plans to change the
> exported functions, and it's only two lines of code, dammit.
> 
> The cost to us of maintaining those two lines of code for a year is
> basically zero.
> 
> The cost to others of us removing those two lines of code without warning
> is appreciable.
> 
> Obvious solution: don't remove the two lines of code without warning.
> 
> The only reason I can see for peremptorily removing those two lines of code
> is that there is some benefit to doing so which outweighs the downstream
> cost of doing so.  Nobody has demonstrated such a benefit.
>...

I did a bit research using grep, sort, uniq and wc:

between 2.6.9 and 2.6.10:
414 EXPORT_SYMBOL's were removed

since 2.6.10:
90 EXPORT_SYMBOL's were removed in Linus' tree

in 2.6.10-mm2 excluding linus.patch:
71 EXPORT_SYMBOL's are removed

Notes:
- EXPORT_SYMBOL_GPL's weren't counted in any way
- if an EXPORT_SYMBOL was moved, it wasn't counted (using uniq)
- small mistakes in the numbers might be possible since my method to
  measure them was't at a scientific level, but after a quick look
  it seems the numbers are roughly correct


Resurrecting and documenting all of these recently removed 
EXPORT_SYMBOL's because some company might have found some way to 
(ab)use one or more of them costs us:
- some extra work
- wasts space for all users of Linux (e.g. some of the recent removals
  are "remove EXPORT_SYMBOL'ed but completely unused function" patches
  I sent)


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

