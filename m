Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261622AbVDJWg7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261622AbVDJWg7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Apr 2005 18:36:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261625AbVDJWg7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Apr 2005 18:36:59 -0400
Received: from fire.osdl.org ([65.172.181.4]:55227 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261622AbVDJWgs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Apr 2005 18:36:48 -0400
Date: Sun, 10 Apr 2005 15:38:39 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Christopher Li <lkml@chrisli.org>
cc: Paul Jackson <pj@engr.sgi.com>, junkio@cox.net, rddunlap@osdl.org,
       ross@jose.lug.udel.edu, linux-kernel@vger.kernel.org
Subject: Re: more git updates..
In-Reply-To: <20050410190331.GG13853@64m.dyndns.org>
Message-ID: <Pine.LNX.4.58.0504101533020.1267@ppc970.osdl.org>
References: <Pine.LNX.4.58.0504091208470.6947@ppc970.osdl.org>
 <20050409200709.GC3451@pasky.ji.cz> <Pine.LNX.4.58.0504091320490.1267@ppc970.osdl.org>
 <7vhdifcbmo.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0504100824470.1267@ppc970.osdl.org>
 <20050410115055.2a6c26e8.pj@engr.sgi.com> <Pine.LNX.4.58.0504101338360.1267@ppc970.osdl.org>
 <20050410190331.GG13853@64m.dyndns.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 10 Apr 2005, Christopher Li wrote:
> 
> BTW, one thing I learn from ext3 is that it is very useful to have some
> compatible flag for future development. I think if we want to reserve some
> room in the file format for further development of git

Way ahead of you.

This is (one reason) why all git objects have the type embedded inside of 
them. The format of all objects is totally regular: they are all 
compressed with zlib, they are all named by the sha1 file, and they all 
start out with a magic header of "<typename> <typesize><nul byte>".

So if I want to create a new kind of tree object that does the same thing 
as the old one but has some other layout, I'd just call it something else. 
Like "dir". That was what I initially planned to do about the change to 
recursive tree objects, but it turned out to actually be a lot easier to 
just encode it in the old type (that way the routines that read it don't 
even have to care about old/new types - it's all the same to them).

			Linus
