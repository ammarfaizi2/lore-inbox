Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265931AbUBJQbk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 11:31:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265998AbUBJQbk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 11:31:40 -0500
Received: from fw.osdl.org ([65.172.181.6]:53151 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265931AbUBJQbj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 11:31:39 -0500
Date: Tue, 10 Feb 2004 08:31:24 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrew Morton <akpm@osdl.org>
cc: Jeff Chua <jchua@fedex.com>, jeffchua@silk.corp.fedex.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] warning: `__attribute_used__' redefined
In-Reply-To: <20040210082514.04afde4a.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0402100827100.2128@home.osdl.org>
References: <Pine.LNX.4.58.0402101434260.27213@boston.corp.fedex.com>
 <20040209225336.1f9bc8a8.akpm@osdl.org> <Pine.LNX.4.58.0402102150150.17289@silk.corp.fedex.com>
 <20040210082514.04afde4a.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 10 Feb 2004, Andrew Morton wrote:
> 
> ah, thanks.
> 
> Like this?

That will just break. The reason for the "compiler.h" include is the 
"__user" part of fpstate, so now you'll get a parse error later if 
non-kernel code includes this.

So the rule should still be: don't include kernel headers from user 
programs. But if it's needed for some reason, that #ifdef needs to be 
somewhere else (inside "compiler.h" or something).

		Linus
