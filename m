Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275075AbTHGFft (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 01:35:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275076AbTHGFfs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 01:35:48 -0400
Received: from angband.namesys.com ([212.16.7.85]:58801 "EHLO
	angband.namesys.com") by vger.kernel.org with ESMTP id S275075AbTHGFf2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 01:35:28 -0400
Date: Thu, 7 Aug 2003 09:35:22 +0400
From: Oleg Drokin <green@namesys.com>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>, andrea@suse.de,
       linux-kernel@vger.kernel.org
Subject: Re: 2.4.22-pre lockups (now decoded oops for pre10)
Message-ID: <20030807053522.GB19048@namesys.com>
References: <20030806094150.4d7b0610.skraw@ithnet.com> <Pine.LNX.4.44.0308061506170.4979-100000@logos.cnet> <20030807041440.12341286.skraw@ithnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030807041440.12341286.skraw@ithnet.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Thu, Aug 07, 2003 at 04:14:40AM +0200, Stephan von Krawczynski wrote:

> Unable to handle kernel NULL pointer dereference at virtual address 00000004

Hm NULL pointer in j_dirty_buffers list. This cannot happen, basically.
This is a cyclically linked list of buffers. And we add stuff to it via standard
functions, so the linkage happens by itself.

> Trace; c0183ef5 <reiserfs_sync_file+65/d0>
> Trace; f8c84fc8 <[nfsd]nfsd_sync+78/d0>
> Code;  c0145060 <fsync_buffers_list+50/1b0>
> 00000000 <_EIP>:
> Code;  c0145060 <fsync_buffers_list+50/1b0>   <=====
>    0:   89 50 04                  mov    %edx,0x4(%eax)   <=====

> As you can see reiserfs seems involved. Regarding reiserfs and my last postings
> I can assure you that all reiserfs partitions were checked via reiserfsck right
> before installation of rc1 - as Oleg advised - and found:
> "Comparing bitmaps.. vpf-10640: The on-disk and the correct bitmaps differs"

That might explain your prior "freeing already free block" messages.

> I was told to use --fix-fixable option which I did and it indeed fixed the
> problem. Trying reiserfsck after that found no errors any more. So I see no
> chance that corrupt data on the media (through former crashes) is responsible
> for this one. Hint: spelling in reiserfsck should be checked ;-)

Yes, but how the condition that triggered the oops have appeared is totally unclear for me.

Bye,
    Oleg
