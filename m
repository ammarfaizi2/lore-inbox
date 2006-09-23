Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750743AbWIWLE1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750743AbWIWLE1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Sep 2006 07:04:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750735AbWIWLE1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Sep 2006 07:04:27 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:46482 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750720AbWIWLE0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Sep 2006 07:04:26 -0400
Subject: Re: [patch 1/8] extend make headers_check to detect more problems
From: David Woodhouse <dwmw2@infradead.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20060918013216.335200000@klappe.arndb.de>
References: <20060918012740.407846000@klappe.arndb.de>
	 <20060918013216.335200000@klappe.arndb.de>
Content-Type: text/plain
Date: Sat, 23 Sep 2006 12:04:21 +0100
Message-Id: <1159009461.24527.920.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-09-18 at 03:27 +0200, Arnd Bergmann wrote:
> plain text document attachment (headercheck-base.diff)
> In addition to the problem of including non-existant header
> files, a number of other things can go wrong with header
> files exported to user space. This adds checks for some
> common problems:
> 
> - The header fails to include the files it needs, which
>   results in build errors when a program tries to include
>   it. Check this by doing a dummy compile.
> 
> - There is a declarations of a static variable or non-inline
>   function in the header, which results in object code
>   in every file including it. Check for symbols in the object
>   with 'nm'.
> 
> - Part of the header is subject to conditional compilation
>   based on CONFIG_*. Add a regex search for this.

It would be good to fix these problems, it's true -- but bear in mind
that none of these are actually fatal problems -- they're just caveats
of (ab)using kernel-private headers in userspace. 

On the other hand, it would be good to get people used to running
'make headers_check' whenever they make a change -- so introducing more
breakage right now may be counterproductive from that point of view.

So I think I'd prefer to leave this for now, or at least limit it to
'make CHECKMEHARDER=1 headers_check' so that we can wean people onto
using headers_check slowly and relatively painlessly.

> I found many problems with this, which I then fixed for
> powerpc, s390 and i386, in subsequent patches.

Can you -include <linux/types.h> _every_ time, to reduce the number of
places you have to add '/* @headercheck: -include linux/types.h @ */' ?

-- 
dwmw2

