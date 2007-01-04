Return-Path: <linux-kernel-owner+w=401wt.eu-S965106AbXADWS3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965106AbXADWS3 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 17:18:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965105AbXADWS2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 17:18:28 -0500
Received: from gaz.sfgoth.com ([69.36.241.230]:52545 "EHLO gaz.sfgoth.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965103AbXADWS1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 17:18:27 -0500
Date: Thu, 4 Jan 2007 14:38:56 -0800
From: Mitchell Blank Jr <mitch@sfgoth.com>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Linus Torvalds <torvalds@osdl.org>, Eric Sandeen <sandeen@redhat.com>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [UPDATED PATCH] fix memory corruption from misinterpreted bad_inode_ops return values
Message-ID: <20070104223856.GA79126@gaz.sfgoth.com>
References: <20070104105430.1de994a7.akpm@osdl.org> <Pine.LNX.4.64.0701041104021.3661@woody.osdl.org> <20070104191451.GW17561@ftp.linux.org.uk> <Pine.LNX.4.64.0701041127350.3661@woody.osdl.org> <20070104202412.GY17561@ftp.linux.org.uk> <20070104215206.GZ17561@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070104215206.GZ17561@ftp.linux.org.uk>
User-Agent: Mutt/1.4.2.1i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.2.2 (gaz.sfgoth.com [127.0.0.1]); Thu, 04 Jan 2007 14:38:57 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Viro wrote:
> At least 3 versions, unless you want to mess with ifdefs to reduce them to
> two.

I don't think you need to do fancy #ifdef's:

static s32 return_eio_32(void) { return -EIO; }
static s64 return_eio_64(void) { return -EIO; }
extern void return_eio_unknown(void);   /* Doesn't exist */
#define return_eio(type)        ((sizeof(type) == 4)			\
					? ((void *) return_eio_32)	\
				: ((sizeof(type) == 8)			\
					? ((void *) return_eio_64)	\
					: ((void *) return_eio_unknown)))

-Mitch
