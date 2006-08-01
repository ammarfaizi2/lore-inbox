Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932675AbWHALwJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932675AbWHALwJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 07:52:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932676AbWHALwI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 07:52:08 -0400
Received: from smtp106.mail.mud.yahoo.com ([209.191.85.216]:9393 "HELO
	smtp106.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932675AbWHALwH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 07:52:07 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=lRfuhBy6YldRWmwob2DvblvpyfuxMwiHQ5bz+UkPp7ShQ+8JNkLypkewx5mElXHgiqbH1SXJy/jWK2C5rGMX5p4gUlTXFkPyKp2GANT9rAJk5kRLnB5PxUwNAKWw96//MGdFuNFj4EdZ+LP1A0SDXTSlpnHc5ZDPJuuIPhxDTL8=  ;
Message-ID: <44CF4063.9070003@yahoo.com.au>
Date: Tue, 01 Aug 2006 21:52:03 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Denis Vlasenko <vda.linux@googlemail.com>, reiser@namesys.com,
       linux-kernel@vger.kernel.org
Subject: Re: reiser4: maybe just fix bugs?
References: <1158166a0607310226m5e134307o8c6bedd1f883479c@mail.gmail.com> <20060801013104.f7557fb1.akpm@osdl.org>
In-Reply-To: <20060801013104.f7557fb1.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Mon, 31 Jul 2006 10:26:55 +0100
> "Denis Vlasenko" <vda.linux@googlemail.com> wrote:
> 
> 
>>The reiser4 thread seem to be longer than usual.
> 
> 
> Meanwhile here's poor old me trying to find another four hours to finish
> reviewing the thing.
> 
> The writeout code is ugly, although that's largely due to a mismatch between
> what reiser4 wants to do and what the VFS/MM expects it to do.  If it
> works, we can live with it, although perhaps the VFS could be made smarter.
> 
> I'd say that resier4's major problem is the lack of xattrs, acls and
> direct-io.  That's likely to significantly limit its vendor uptake.  (As
> might the copyright assignment thing, but is that a kernel.org concern?)
> 
> The plugins appear to be wildly misnamed - they're just an internal
> abstraction layer which permits later feature additions to be added in a
> clean and safe manner.  Certainly not worth all this fuss.
> 
> Could I suggest that further technical critiques of reiser4 include a
> file-and-line reference?  That should ease the load on vger.

I haven't really reviewed it, but when I grepped through it last, I
found a few alarming things, like use of __put_page, trying to remove
pages from pagecache (duplicating parts of vmscan.c, plus bugs), and
taking tree_lock.

Mostly didn't look like big problems to fix, but should be fixed for
mm/ maintainers' sanity. Maybe it's better now, though.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
