Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317743AbSIEQEl>; Thu, 5 Sep 2002 12:04:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317755AbSIEQEl>; Thu, 5 Sep 2002 12:04:41 -0400
Received: from mg03.austin.ibm.com ([192.35.232.20]:49637 "EHLO
	mg03.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S317743AbSIEQEk>; Thu, 5 Sep 2002 12:04:40 -0400
Content-Type: text/plain; charset=US-ASCII
From: Dave Kleikamp <shaggy@austin.ibm.com>
To: Oleg Drokin <green@namesys.com>, "David S. Miller" <davem@redhat.com>
Subject: Re: [reiserfs-dev] Re: [PATCH] sparc32: wrong type of nlink_t
Date: Thu, 5 Sep 2002 11:09:12 -0500
X-Mailer: KMail [version 1.4]
Cc: szepe@pinerecords.com, mason@suse.com, reiser@namesys.com,
       marcelo@conectiva.com.br, linux-kernel@vger.kernel.org,
       reiserfs-dev@namesys.com, linuxjfs@us.ibm.com
References: <3D76A6FF.509@namesys.com> <20020904.223651.79770866.davem@redhat.com> <20020905135442.A19682@namesys.com>
In-Reply-To: <20020905135442.A19682@namesys.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200209051109.12291.shaggy@austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 05 September 2002 04:54, Oleg Drokin wrote:

> +/* Find maximal number, that nlink_t can hold. GCC is able to
> calculate this +   value at compile time, so do not worry about extra
> CPU overhead. */ +#define REISERFS_LINK_MAX ((((nlink_t) -1) >> 0)?~0:((1u<<(sizeof(nlink_t)*8-1))-1))

Shouldn't this be:

#define REISERFS_LINK_MAX ((((nlink_t) -1) >> 0)?(nlink_t) ~0:((1u<<(sizeof(nlink_t)*8-1))-1))

if nlink_t is u16, ~0 would still be 0xffffffff (assuming 32 bits)
-- 
David Kleikamp
IBM Linux Technology Center

