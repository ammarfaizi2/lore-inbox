Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932528AbWHLOQT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932528AbWHLOQT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Aug 2006 10:16:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932526AbWHLOP6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Aug 2006 10:15:58 -0400
Received: from moutng.kundenserver.de ([212.227.126.171]:32471 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S964835AbWHLOPy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Aug 2006 10:15:54 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 3/6] unlink: monitor i_nlink
Date: Sat, 12 Aug 2006 16:15:47 +0200
User-Agent: KMail/1.9.1
Cc: Dave Hansen <haveblue@us.ibm.com>, Christoph Hellwig <hch@infradead.org>,
       linux-kernel@vger.kernel.org
References: <20060809165729.FE36B262@localhost.localdomain> <1155143839.19249.151.camel@localhost.localdomain> <20060809112740.a964e5a2.akpm@osdl.org>
In-Reply-To: <20060809112740.a964e5a2.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200608121615.47877.arnd@arndb.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 09 August 2006 20:27, Andrew Morton wrote:
> struct inode {
>         ...
>         union {
>                 unsigned int i_nlink;
>                 unsigned int i_nlink_use_the_accessors_please;
>         }
>         ...
> };
> 
> then, when everything in-tree is migrated, remove `i_nlink'.

You can also mark a union member deprecated:

struct inode {
        ...
        union {
                unsigned int __deprecated i_nlink;
                unsigned int i_nlink_use_the_accessors_please;
        }
        ...
};

So gcc will warn about any newly introduced users.

	Arnd <><
