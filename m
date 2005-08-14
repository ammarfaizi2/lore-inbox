Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932479AbVHNKWp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932479AbVHNKWp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Aug 2005 06:22:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932477AbVHNKWp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Aug 2005 06:22:45 -0400
Received: from wproxy.gmail.com ([64.233.184.200]:26218 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932479AbVHNKWo convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Aug 2005 06:22:44 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=iDRwTnY9cei0Xoi5/NYBXRmebl9nqUmIakWebjGN5PmI+WP/UH+GOcfLDqypHVoN7I0Pb4imKs/adyonXBP/i8ujXl4/FNkXtcizu3DaRbm5cLBcv0P6awImtL3TmIyOYSnUUTZBiheX93cvPS+rC9gKnVA/KIAUx7DUUHt8P5I=
Message-ID: <98df96d305081403222e75b232@mail.gmail.com>
Date: Sun, 14 Aug 2005 19:22:41 +0900
From: Hiro Yoshioka <lkml.hyoshiok@gmail.com>
Reply-To: hyoshiok@miraclelinux.com
To: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [RFC] [PATCH] cache pollution aware __copy_from_user_ll()
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1124012489.3222.13.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <98df96d305081402164ce52f8@mail.gmail.com>
	 <1124012489.3222.13.camel@laptopd505.fenrus.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for your comments.

On 8/14/05, Arjan van de Ven <arjan@infradead.org> wrote:
> On Sun, 2005-08-14 at 18:16 +0900, Hiro Yoshioka wrote:
> > Hi,
> >
> > The following is a patch to reduce a cache pollution
> > of __copy_from_user_ll().
> >
> > When I run simple iozone benchmark to find a performance bottleneck of
> > the linux kernel, I found that __copy_from_user_ll() spent CPU cycle
> > most and it did many cache misses.
> 
> 
> however... you copy something from userspace... aren't you going to USE
> it? The non-termoral versions actually throw the data out of the
> cache... so while this part might be nice, you pay BIG elsewhere....

The oprofile data does not give an evidence that we pay BIG elsewhere.

For examples, the original 2.6.12.4 Top 5 cache misses are the following,

37017 63.4603  vmlinux    __copy_from_user_ll
1049   1.7984  vmlinux    _spin_lock_irqsave
940    1.6115  vmlinux    blk_rq_map_sg
896    1.5361  vmlinux    generic_file_buffered_write
885    1.5172  vmlinux    _spin_lock
pattern9-0-cpu4-0-08141702

cache aware version Top 5 cache misses are
899 5.7305  vmlinux    blk_rq_map_sg
569 3.6270  vmlinux    journal_commit_transaction
531 3.3848  vmlinux    radix_tree_delete
514 3.2764  vmlinux    journal_add_journal_head
505 3.2190  vmlinux    release_pages
...
89 0.5673 vmlinux _mmx_memcpy_nt
pattern9-0-cpu4-0-08141625

What do you think?

Regards,
  Hiro
