Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318973AbSIDAm5>; Tue, 3 Sep 2002 20:42:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318982AbSIDAm5>; Tue, 3 Sep 2002 20:42:57 -0400
Received: from holomorphy.com ([66.224.33.161]:26274 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S318973AbSIDAm4>;
	Tue, 3 Sep 2002 20:42:56 -0400
Date: Tue, 3 Sep 2002 17:40:28 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@zip.com.au>
Cc: lkml <linux-kernel@vger.kernel.org>,
       "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: 2.5.33-mm1
Message-ID: <20020904004028.GS888@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@zip.com.au>,
	lkml <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>
References: <3D7437AC.74EAE22B@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <3D7437AC.74EAE22B@zip.com.au>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 02, 2002 at 09:16:44PM -0700, Andrew Morton wrote:
> http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.33/2.5.33-mm1/
> Seven new patches - mostly just code cleanups.
> +slablru-speedup.patch
>   A patch to improve slablru cpu efficiency.  Ed is
>   redoing this.

count_list() appears to be the largest consumer of cpu after this is
done, or so say the profiles after running updatedb by hand on
2.5.33-mm1 on a 900MHz P-III T21 Thinkpad with 256MB of RAM.

  4608 __rdtsc_delay                            164.5714
  2627 __generic_copy_to_user                    36.4861
  2401 count_list                                42.8750
  1415 find_inode_fast                           29.4792
  1325 do_anonymous_page                          3.3801

It also looks like there's either a bit of internal fragmentation or a
missing kmem_cache_reap() somewhere:

  ext3_inode_cache:    20001KB    51317KB   38.97
      dentry_cache:     4734KB    18551KB   25.52
   radix_tree_node:     1811KB     1923KB   94.20
       buffer_head:     1132KB     1378KB   82.12

It does stay quite a bit more nicely bounded than without slablru though.

Maybe it's old news. Just thought I'd try running a test on something tiny
for once. (new kbd/mouse config options were a PITA BTW)


Cheers,
Bill
