Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262253AbUDKGUu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Apr 2004 02:20:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262266AbUDKGUu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Apr 2004 02:20:50 -0400
Received: from CPE-203-51-35-15.nsw.bigpond.net.au ([203.51.35.15]:56829 "EHLO
	e4.eyal.emu.id.au") by vger.kernel.org with ESMTP id S262253AbUDKGUs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Apr 2004 02:20:48 -0400
Message-ID: <4078E3BA.8040707@eyal.emu.id.au>
Date: Sun, 11 Apr 2004 16:20:42 +1000
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.26-rc2
References: <20040406004251.GA24918@logos.cnet>
In-Reply-To: <20040406004251.GA24918@logos.cnet>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti wrote:
> Hi,
> 
> Here goes the second release candidate. It contains an ACPI update,
> networking updates, IDE updates, XFS update, etc.

Building the (binary) nvidia driver I got this warning:

In file included from /lib/modules/2.4.26-rc2/build/include/linux/vmalloc.h:8,
                  from nv-linux.h:62,
                  from os-interface.c:26:
/lib/modules/2.4.26-rc2/build/include/linux/highmem.h: In function `bh_kmap':
/lib/modules/2.4.26-rc2/build/include/linux/highmem.h:20: warning: pointer of type `void *' used in arithmetic

Looking there I see:

static inline char *bh_kmap(struct buffer_head *bh)
{
         return kmap(bh->b_page) + bh_offset(bh);
}

And in /usr/include/linux/highmem.h I see:

static inline void *kmap(struct page *page) { return page_address(page); }

So we really are doing 'void *' math, which is not right. Maybe a cast is
called for in bh_kmap(), like:
	return (char *)kmap(bh->b_page) + bh_offset(bh);

--
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
