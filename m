Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267922AbTBRT1Q>; Tue, 18 Feb 2003 14:27:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267925AbTBRT1Q>; Tue, 18 Feb 2003 14:27:16 -0500
Received: from packet.digeo.com ([12.110.80.53]:61384 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267922AbTBRT1Q>;
	Tue, 18 Feb 2003 14:27:16 -0500
Date: Tue, 18 Feb 2003 11:38:23 -0800
From: Andrew Morton <akpm@digeo.com>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: CIFS (2.5.62) build problems
Message-Id: <20030218113823.64d22c7d.akpm@digeo.com>
In-Reply-To: <1045596223.17584.139.camel@dell_ss3.pdx.osdl.net>
References: <1045596223.17584.139.camel@dell_ss3.pdx.osdl.net>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 18 Feb 2003 19:37:11.0196 (UTC) FILETIME=[217875C0:01C2D785]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Hemminger <shemminger@osdl.org> wrote:
>
> CIFS can not be built as a module because it cifs_readpages calls:
>  __pagevec_lru_add
>  add_to_page_cache
> 
> The patch to mm/filemap.c and mm/swap.c is trivial, the question is
> should those internal functions be exported in the first place.
> 

Yes they need to be exported.  Otherwise filesystems cannot implement
a fully custom readpages address_space op.

I have a fix for this queued.
