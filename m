Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263155AbTCLLgO>; Wed, 12 Mar 2003 06:36:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263157AbTCLLgO>; Wed, 12 Mar 2003 06:36:14 -0500
Received: from rth.ninka.net ([216.101.162.244]:18858 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id <S263155AbTCLLgN>;
	Wed, 12 Mar 2003 06:36:13 -0500
Subject: Re: [PATCH][COMPAT] compat_sys_fcntl{,64} 1/9 Generic part
From: "David S. Miller" <davem@redhat.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, schwidefsky@de.ibm.com,
       arnd@arndb.de, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0303112124000.12804-100000@home.transmeta.com>
References: <Pine.LNX.4.44.0303112124000.12804-100000@home.transmeta.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1047469604.15904.1.camel@rth.ninka.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 12 Mar 2003 03:46:45 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-03-11 at 21:26, Linus Torvalds wrote:

> Yes, this looks much more sane. If you _really_ want to be anal about 
> typechecking (and also checking that nobody can possibly use a user 
> pointer incorrectly), you make
> 
> 	typedef struct {
> 		unsigned int val;
> 	} compat_uptr_t;

Be careful, these kind of "int in a struct" things end up being
passed to functions on the stack instead of registers :-(

This is why we don't do any of the fancy type-checking
page table types on Sparc unless you edit the header files.

