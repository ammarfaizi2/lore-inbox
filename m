Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267090AbTBQNoY>; Mon, 17 Feb 2003 08:44:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267091AbTBQNoY>; Mon, 17 Feb 2003 08:44:24 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:5768
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267090AbTBQNoW>; Mon, 17 Feb 2003 08:44:22 -0500
Subject: Re: [PATCH] Prevent setting 32 uids/gids in the error range
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Linus Torvalds <torvalds@transmeta.com>, tridge@samba.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       cyeoh@samba.org, sfr@canb.auug.org.au
In-Reply-To: <20030217074920.E76822C003@lists.samba.org>
References: <20030217074920.E76822C003@lists.samba.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1045493720.19397.4.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 17 Feb 2003 14:55:20 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-02-17 at 07:41, Rusty Russell wrote:
> Tridge noticed that getegid() was returning EPERM.
> 
> I used -1000 since that's what PTR_ERR uses, but i386 _syscall macros
> use -125: I don't suppose it really matters.

Thats a bug in the interface. getegid/getgid/setegid/setuid() is not permitted to fail.
If libc is setting errno and returning -1 the libc wrapper is wrong.

set*id can fail, but unlike the get functions they do not return a uid but an error code.

Alan

