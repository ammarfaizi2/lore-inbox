Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263045AbTCLFRc>; Wed, 12 Mar 2003 00:17:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263047AbTCLFRc>; Wed, 12 Mar 2003 00:17:32 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:46096 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S263045AbTCLFRb>; Wed, 12 Mar 2003 00:17:31 -0500
Date: Tue, 11 Mar 2003 21:26:02 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
cc: schwidefsky@de.ibm.com, <arnd@arndb.de>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][COMPAT] compat_sys_fcntl{,64} 1/9 Generic part
In-Reply-To: <20030312162251.0478d86e.sfr@canb.auug.org.au>
Message-ID: <Pine.LNX.4.44.0303112124000.12804-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 12 Mar 2003, Stephen Rothwell wrote:
> 
> > Make the code _look_ good. Not look like SOMEBODY WHO CANNOT TYPE WITHOUT
> > THE SHIFT KEY. Make the thing take properly typed arguments, instead of
> > casting stuff two ways and backwards inside macros.
> 
> you mean like this?

Yes, this looks much more sane. If you _really_ want to be anal about 
typechecking (and also checking that nobody can possibly use a user 
pointer incorrectly), you make

	typedef struct {
		unsigned int val;
	} compat_uptr_t;

and then use

	static inline void *compat_ptr(compat_uptr_t uptr)
	{
		return (void *)uptr.val;
	}

which should still result in readable code.

		Linus

