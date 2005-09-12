Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932269AbVILVkW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932269AbVILVkW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 17:40:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932273AbVILVkV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 17:40:21 -0400
Received: from smtpout.mac.com ([17.250.248.88]:63446 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S932269AbVILVkU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 17:40:20 -0400
In-Reply-To: <20050912141426.1582827c.pj@sgi.com>
References: <97597F8E-DDCE-479F-AE8D-CC7DC75AB3C3@mac.com> <20050910014543.1be53260.akpm@osdl.org> <4FAE9F58-7153-4574-A2C3-A586C9C3CFF1@mac.com> <20050910150446.116dd261.akpm@osdl.org> <E352D8E3-771F-4A0D-9403-DBAA0C8CBB83@mac.com> <20050910174818.579bc287.akpm@osdl.org> <93E9C5F9-A083-4322-A580-236E2232CCC0@mac.com> <20050912010954.70ac90e2.pj@sgi.com> <43259C9E.1040300@zytor.com> <20050912084756.4fa2bd07.pj@sgi.com> <20050912171759.GA11973@mars.ravnborg.org> <20050912141426.1582827c.pj@sgi.com>
Mime-Version: 1.0 (Apple Message framework v734)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <06DC2766-9448-416C-B9A0-D978949DE3B7@mac.com>
Cc: Sam Ravnborg <sam@ravnborg.org>, hpa@zytor.com, akpm@osdl.org,
       linux-kernel@vger.kernel.org, bunk@stusta.de
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [RFC][MEGAPATCH] Change __ASSEMBLY__ to __ASSEMBLER__ (defined by GCC from 2.95 to current CVS)
Date: Mon, 12 Sep 2005 17:39:35 -0400
To: Paul Jackson <pj@sgi.com>
X-Mailer: Apple Mail (2.734)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 12, 2005, at 17:14:26, Paul Jackson wrote:
> Sam wrote:
>> ... for absolutely no gain.
>
> I hear the usual and reasonable arguments on one side,
> favoring consolidating the headers.
>
> The final phrase "absolutely no gain" suggests a lack
> of consideration for the usual and reasonable arguments
> that no doubt exist on the other side.

I dunno about Sam, but I've looked at this a lot, and there really  
seem to
be no advantages to keeping them separate.  There's a lot of cruft in  
the
kernel headers, and in many cases a lack of organization.  By keeping  
the
user-accessible kernel-headers separate, you save work in the short term
by putting off cleaning up that cruft, but in the long term you have  
twice
the maintenance burden, in addition to the fact that you'll need to  
clean
up the cruft eventually anyways.  The user-space-accessible versions  
will
be identical to the kernel-space-accessible ones except without some
private kernel stuff.  Also, by having the separation _within_ the  
kernel
tree, we can help trigger more thought about kernel/user ABI for new
drivers, because it's much more obvious exactly what the userspace
interface is when it goes in.  It also makes it much easier to have a
template header file to show driver authors how to get their user/kernel
interfaces correct the first time.  If someone sees something about this
that I'm missing, then please tell me, but as far as I can tell, keeping
this project out of the kernel would give "absolutely no gain" over
doing it in kernel, and would in fact result in massive amounts of
duplicated effort ("You forgot to patch user-kernel-headers to add your
shiny new IOCTL!").  It also is dismissive to suckers^H^H^H^H^H^Hpeople
who are willing to invest effort in cleaning up kernel headers, removing
messy include cycles, breaking up monoliths like linux/sched.h, etc.

Cheers,
Kyle Moffett

--
Unix was not designed to stop people from doing stupid things,  
because that
would also stop them from doing clever things.
   -- Doug Gwyn


