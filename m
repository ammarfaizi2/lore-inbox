Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261442AbUCIAZf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 19:25:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261437AbUCIAZf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 19:25:35 -0500
Received: from fw.osdl.org ([65.172.181.6]:51410 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261440AbUCIAZ2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 19:25:28 -0500
Date: Mon, 8 Mar 2004 16:32:06 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrew Morton <akpm@osdl.org>
cc: Thomas Schlichter <thomas.schlichter@web.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix warning about duplicate 'const'
In-Reply-To: <20040308161410.49127bdf.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0403081627450.9575@ppc970.osdl.org>
References: <200403090043.21043.thomas.schlichter@web.de>
 <20040308161410.49127bdf.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 8 Mar 2004, Andrew Morton wrote:
> > 
> > This is done by removing the 'const' from the temporary variables of the min() 
> > and max() macros. For me it seems to have no negative impact, so please 
> > consider applying...
> 
> I think there was a reason for those consts in kernel.h's min() and max()
> macros, but memory fails me.  Linus, do you recall?

I'm not 100% sure, but I think they are required to make a few other 
warnings go away. The fact that gcc complains about "const typeof" is a 
gcc misfeature, I think, and should be fixed there.

The warnings the extra "const" fixes is something like:

	int a;
	const int b;

	min(a,b)

where otherwise it would complain about pointers to different types when
comparing the type of the pointer. Or something.

		Linus
