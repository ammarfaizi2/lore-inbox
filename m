Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264358AbUAHMNW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 07:13:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264368AbUAHMNW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 07:13:22 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:34698 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264358AbUAHMNN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 07:13:13 -0500
Date: Thu, 8 Jan 2004 12:13:12 +0000
From: Matthew Wilcox <willy@debian.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jesper Juhl <juhl@dif.dk>, linux-kernel@vger.kernel.org,
       Matthew Wilcox <matthew@wil.cx>
Subject: Re: [PATCH] fs/fcntl.c - remove impossible <0 check in do_fcntl - arg is unsigned.
Message-ID: <20040108121312.GT17182@parcelfarce.linux.theplanet.co.uk>
References: <8A43C34093B3D5119F7D0004AC56F4BC074B2059@difpst1a.dif.dk> <Pine.LNX.4.58.0401071846160.2131@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0401071846160.2131@home.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 07, 2004 at 06:47:49PM -0800, Linus Torvalds wrote:
> 
> 
> On Thu, 8 Jan 2004, Jesper Juhl wrote:
> > 
> > The 'arg' argument to the function do_fcntl in fs/fcntl.c is of type
> > 'unsigned long', thus it can never be less than zero (all callers of
> > do_fcntl take unsigned arguments as well and pass on unsigned values),
> 
> I'm not sure I like these kinds of patches.
> 
> I _like_ the code being readable. The fact that the compiler can optimize 
> away one of the tests if the type is right is fine. It seems to be 
> draconian to remove code that is correct and safe, especially when the 
> code has no real downsides to it.
> 
> Do we have a compiler that needlessly complains again? 

gcc does indeed complain about it with -W.  But -W turns on so many other
warnings, this one's lost in the noise.  I would actually like to be
able to make the header files -W clean so that I can compile individual
files with -W to catch some of my worst mistakes.

But I don't think that making the entire build -W clean is worthwhile.
It'd make the code too ugly.

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
