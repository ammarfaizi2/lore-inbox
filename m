Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263079AbUCMKZa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Mar 2004 05:25:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263080AbUCMKZa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Mar 2004 05:25:30 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:47596 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id S263079AbUCMKZY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Mar 2004 05:25:24 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Andrew Morton <akpm@osdl.org>
Date: Sat, 13 Mar 2004 21:25:14 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16466.57738.590102.717396@notabene.cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.4-mm1
In-Reply-To: message from Andrew Morton on Thursday March 11
References: <20040310233140.3ce99610.akpm@osdl.org>
	<16465.3163.999977.302378@notabene.cse.unsw.edu.au>
	<20040311172244.3ae0587f.akpm@osdl.org>
	<16465.20264.563965.518274@notabene.cse.unsw.edu.au>
	<20040311235009.212d69f2.akpm@osdl.org>
X-Mailer: VM 7.18 under Emacs 21.3.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday March 11, akpm@osdl.org wrote:
> > I thought I might try selectively removing patches, but it isn't clear
> > what order the borken-out patches were applied it.
> > If you have an ordered list, I can try a binary search.
> 
> See the `series' file in the broken-out directory.
> 

Ahh... would you consider moving that up one level, or spelling it
"Series" or "00series" or something to make it stand out for the
uninitiated??

> > Or if you can suggest some patches that I can try backing out....
> 
> Maybe turn off -mregparm?  Or back off the 4g/4g patches?  Maybe they broke
> non-4:4 code comehow.
> 

Looks like it might be a good guess....

I cannot reach the reset button on the weekend, so I wrote a little
boot-time script which would apply the next patch, mail me, recompile,
install, and reboot.

It got up to stop-using-dirty-pages.patch and died because of the
spin_unlock in mm/page.c - I left SPINLOCK_DEBUG configured :-(

But that only leaves

   235  stop-using-io-pages.patch
   236  stop-using-locked-pages.patch
   237  stop-using-clean-pages.patch
   238  unslabify-pgds-and-pmds.patch
   239  slab-stop-using-page-list.patch
   240  page_alloc-stop-using-page-list.patch
   241  hugetlb-stop-using-page-list.patch
   242  pageattr-stop-using-page-list.patch
   243  readahead-stop-using-page-list.patch
   244  compound-pages-stop-using-lru.patch
   245  remove-page-list.patch
   246  remap-file-pages-prot-2.6.4-rc1-mm1-A1.patch
   247  remap-file-pages-prot-ia64-2.6.4-rc2-mm1-A0.patch
   248  list_del-debug.patch
   249  oops-dump-preceding-code.patch
   250  lockmeter.patch
   251  lockmeter-ia64-fix.patch
   252  4g-2.6.0-test2-mm2-A5.patch
   253  4g4g-locked-userspace-copy.patch
   254  ia32-4k-stacks.patch
   255  ia32-4k-stacks-build-fix.patch
   256  4k-stacks-in-modversions-magic.patch
   257  ppc-fixes.patch
   258  ppc-fixes-dependency-fix.patch

of which, the 4g and the 4k-stack patches look most likely.
I'll finish the hunt when I get back to the office.

Thanks,
NeilBrown
