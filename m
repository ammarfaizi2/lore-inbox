Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265159AbUELSGu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265159AbUELSGu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 14:06:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265144AbUELSEz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 14:04:55 -0400
Received: from delerium.kernelslacker.org ([81.187.208.145]:17607 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S265150AbUELSD1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 14:03:27 -0400
Date: Wed, 12 May 2004 19:01:45 +0100
From: Dave Jones <davej@redhat.com>
To: Oleg Drokin <green@linuxhacker.ru>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, mason@suse.com,
       reiserfs-dev@namesys.com
Subject: Re: [PATCH] [2.6] Make reiserfs not to crash on oom
Message-ID: <20040512180145.GA1573@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Oleg Drokin <green@linuxhacker.ru>, akpm@osdl.org,
	linux-kernel@vger.kernel.org, mason@suse.com,
	reiserfs-dev@namesys.com
References: <20040512165038.GA72981@linuxhacker.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040512165038.GA72981@linuxhacker.ru>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 12, 2004 at 07:50:38PM +0300, Oleg Drokin wrote:
 > Hello!
 > 
 >   Thanks to Standford guys, a case where reiserfs can dereference NULL pointer
 >   if memory allocation fail during mount was identified.
 > 
 > @@ -2260,8 +2260,10 @@
 >      INIT_LIST_HEAD (&SB_JOURNAL(p_s_sb)->j_prealloc_list);
 >      INIT_LIST_HEAD(&SB_JOURNAL(p_s_sb)->j_working_list);
 >      INIT_LIST_HEAD(&SB_JOURNAL(p_s_sb)->j_journal_list);
 > -    reiserfs_allocate_list_bitmaps(p_s_sb, SB_JOURNAL(p_s_sb)->j_list_bitmap, 
 > - 				   SB_BMAP_NR(p_s_sb)) ;
 > +    if (reiserfs_allocate_list_bitmaps(p_s_sb,
 > +				       SB_JOURNAL(p_s_sb)->j_list_bitmap, 
 > + 				       SB_BMAP_NR(p_s_sb)))
 > +	goto free_and_return ;
 >      allocate_bitmap_nodes(p_s_sb) ;

Are you leaking the 'journal' allocation here?
(Ditto some of the other failure paths too)

There's also a typod 'jornal' a few lines further down.

		Dave

