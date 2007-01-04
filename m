Return-Path: <linux-kernel-owner+w=401wt.eu-S964821AbXADTLJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964821AbXADTLJ (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 14:11:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965063AbXADTLI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 14:11:08 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:48342 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964821AbXADTLH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 14:11:07 -0500
Date: Thu, 4 Jan 2007 19:10:46 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Segher Boessenkool <segher@kernel.crashing.org>,
       Albert Cahalan <acahalan@gmail.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, s0348365@sms.ed.ac.uk, bunk@stusta.de,
       mikpe@it.uu.se
Subject: Re: kernel + gcc 4.1 = several problems
Message-ID: <20070104191046.GV17561@ftp.linux.org.uk>
References: <787b0d920701032311l2c37c248s3a97daf111fe88f3@mail.gmail.com> <27e6f108b713bb175dd2e77156ef61d0@kernel.crashing.org> <787b0d920701040904i553e521fsb290acf5059f0b62@mail.gmail.com> <8069085182dff3b0e63a661d81804dbb@kernel.crashing.org> <Pine.LNX.4.64.0701040937460.3661@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0701040937460.3661@woody.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 04, 2007 at 09:47:01AM -0800, Linus Torvalds wrote:
> NOBODY will guarantee you that they follow all standards to the letter. 
> Some use compiler extensions knowingly, but pretty much _everybody_ ends 
> up depending on subtle issues without even realizing it. It's almost 
> impossible to write a real program that has no bugs, and if they don't 
> show up in testing (because the compiler didn't generate buggy assembly 
> code from source code that had the _potential_ for bugs), they often won't 
> get fixed.
> 
> The kernel does things like compare pointers across objects, and the 
> kernel EXPECTS it to work. I seriously doubt that the kernel is even 
> unusual in this. The common way to avoid AB-BA deadlocks in any threaded 
> code (whether kernel or user space) is to just take two locks in a 
> specific order, and the common way to do that for locks of the same type 
> is simply to compare the addresses).
> 
> The fact that this is "undefined" behaviour matters not a _whit_. Not for 
> the kernel, and I bet not for a lot of other applications either.

True, but we'd better understand what assumptions we are making.  I have
seen patches seriously attempting to _subtract_ unrelated pointers.  And
that simply doesn't work for obvious reasons...
