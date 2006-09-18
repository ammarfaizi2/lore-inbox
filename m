Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751969AbWIRXOd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751969AbWIRXOd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 19:14:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030252AbWIRXOd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 19:14:33 -0400
Received: from wr-out-0506.google.com ([64.233.184.226]:2720 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751968AbWIRXOc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 19:14:32 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=daNizltbQed8tIMz6+mXkd9kXCRMnB0gMphek2PukziGUic8sBfK78lXM2y732TV1aidFRvQh6xVnoLtE7BDhiW6XggU2pnWZt6XTr2FCSO4bGoEQk7WD0r7YpFy7qu9OUVJfs2Hnk3okVed0X0M1yHiBmHt4JdHdKNNCYKMGAI=
Message-ID: <9a8748490609181614r55178f1djab68eb48bd36f7de@mail.gmail.com>
Date: Tue, 19 Sep 2006 01:14:31 +0200
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Linus Torvalds" <torvalds@osdl.org>
Subject: Re: Math-emu kills the kernel on Athlon64 X2
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       billm@melbpc.org.au, billm@suburbia.net
In-Reply-To: <Pine.LNX.4.64.0609181549200.4388@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <9a8748490609181518j2d12e4f0l2c55e755e40d38c2@mail.gmail.com>
	 <Pine.LNX.4.64.0609181549200.4388@g5.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/09/06, Linus Torvalds <torvalds@osdl.org> wrote:
>
>
> On Tue, 19 Sep 2006, Jesper Juhl wrote:
> >
> > If I enable the math emulator in 2.6.18-rc7-git2 (only version I've
> > tried this with) and then boot the kernel with "no387" then I only get
> > as far as lilo's "...Booting the kernel." message and then the system
> > hangs.
>
> I'm wondering if it tries to use the MMX/XMM stuff for memcpy and friends.
>
> I'm also wondering why you'd be doing what you seem to try to be doing in
> the first place ;)
>
Simply to try and find bugs. If we have a math emulator and it's
selectable for my CPU type, then it should damn well work ;-)

> Basically, "no387" doesn't seem to disable any of the fancier FPU
> features, even though it obviously should. If you ask for math emulation,
> you'll get emulation faults for _all_ of the modern MMX stuff too (which
> we don't do).
>
Hmm, I guess that could be the problem. The emulator should disable
any stuff which it's not able to handle. I've not actually looked very
much at the emulator code yet, so I didn't realize it didn't disable
what it couldn't handle, but getting it to do that sounds like a
sensible first step.

> It's entirely possible that nobody has ever tested this combination.
>
That was my thought as well, which is exactely why I chose to try it -
thinking that it might expose some bugs in math-emu or elsewhere.


-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
