Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265151AbUELSV6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265151AbUELSV6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 14:21:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265152AbUELSV6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 14:21:58 -0400
Received: from linuxhacker.ru ([217.76.32.60]:13542 "EHLO shrek.linuxhacker.ru")
	by vger.kernel.org with ESMTP id S265151AbUELSUY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 14:20:24 -0400
Date: Wed, 12 May 2004 21:20:35 +0300
From: Oleg Drokin <green@linuxhacker.ru>
To: Dave Jones <davej@redhat.com>, akpm@osdl.org, linux-kernel@vger.kernel.org,
       mason@suse.com, reiserfs-dev@namesys.com
Subject: Re: [PATCH] [2.6] Make reiserfs not to crash on oom
Message-ID: <20040512182035.GC7474@linuxhacker.ru>
References: <20040512165038.GA72981@linuxhacker.ru> <20040512180145.GA1573@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040512180145.GA1573@redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Wed, May 12, 2004 at 07:01:45PM +0100, Dave Jones wrote:
>  >   Thanks to Standford guys, a case where reiserfs can dereference NULL pointer
>  >   if memory allocation fail during mount was identified.
>  > 
>  > @@ -2260,8 +2260,10 @@
>  >      INIT_LIST_HEAD (&SB_JOURNAL(p_s_sb)->j_prealloc_list);
>  >      INIT_LIST_HEAD(&SB_JOURNAL(p_s_sb)->j_working_list);
>  >      INIT_LIST_HEAD(&SB_JOURNAL(p_s_sb)->j_journal_list);
>  > -    reiserfs_allocate_list_bitmaps(p_s_sb, SB_JOURNAL(p_s_sb)->j_list_bitmap, 
>  > - 				   SB_BMAP_NR(p_s_sb)) ;
>  > +    if (reiserfs_allocate_list_bitmaps(p_s_sb,
>  > +				       SB_JOURNAL(p_s_sb)->j_list_bitmap, 
>  > + 				       SB_BMAP_NR(p_s_sb)))
>  > +	goto free_and_return ;
>  >      allocate_bitmap_nodes(p_s_sb) ;
> Are you leaking the 'journal' allocation here?
> (Ditto some of the other failure paths too)

No, there is "vfree(SB_JOURNAL(p_s_sb)) ;" at the end of free_journal_ram()
that is called if we jump to that free_and_return label.

> There's also a typod 'jornal' a few lines further down.

Yup. Fortunatelly it does not break anything ;)
If somebody to catch all typos and misspellings in reiserfs code, that would
worth a separate patch (and it will be big).

Bye,
    Oleg
