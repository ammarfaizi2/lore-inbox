Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261384AbVDIVG1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261384AbVDIVG1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Apr 2005 17:06:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261385AbVDIVG1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Apr 2005 17:06:27 -0400
Received: from fire.osdl.org ([65.172.181.4]:58575 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261384AbVDIVGX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Apr 2005 17:06:23 -0400
Date: Sat, 9 Apr 2005 14:08:19 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Petr Baudis <pasky@ucw.cz>
cc: "Randy.Dunlap" <rddunlap@osdl.org>,
       Ross Vandegrift <ross@jose.lug.udel.edu>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: more git updates..
In-Reply-To: <Pine.LNX.4.58.0504091320490.1267@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.58.0504091404350.1267@ppc970.osdl.org>
References: <Pine.LNX.4.58.0504091208470.6947@ppc970.osdl.org>
 <20050409200709.GC3451@pasky.ji.cz> <Pine.LNX.4.58.0504091320490.1267@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 9 Apr 2005, Linus Torvalds wrote:
> 
> I suspect that I have to change the file format. Maybe make the "tree" 
> object a two-level thing, and have a "directory" object.
> 
> Then a "tree" object would point to a "directory" object, which would in
> turn point to the individual files (and other "directory" objects, of
> course). That way a commit that only changes a few files will only need to
> create a few new "directory" objects, instead of creating one huge "tree"
> object.

Actually, I guess I wouldn't have to change the format. I could just 
extend the existing "tree" object to be able to point to other trees, and 
that's it.

The downside of that is that then a tree wouldn't have a canonical format 
any more: you could have two trees that have the exact same content, but 
they'd haev different names. They should obviously merge very easily (and 
thus you could create a new merge that _does_ have a common name), but 
it's ugly.

I'll have to think about it. It's good to notice these issues early, this 
was the first time I had actually tried to check in a kernel-sized tree 
for real.

		Linus
