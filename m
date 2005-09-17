Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751271AbVIRC2n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751271AbVIRC2n (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Sep 2005 22:28:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751273AbVIRC2n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Sep 2005 22:28:43 -0400
Received: from smtp.enter.net ([216.193.128.24]:34824 "EHLO smtp.enter.net")
	by vger.kernel.org with ESMTP id S1751271AbVIRC2n convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Sep 2005 22:28:43 -0400
From: "D. Hazelton" <dhazelton@enter.net>
To: "Martin v. =?iso-8859-1?q?L=F6wis?=" <martin@v.loewis.de>
Subject: Re: [Patch] Support UTF-8 scripts
Date: Sat, 17 Sep 2005 22:31:33 +0000
User-Agent: KMail/1.7.2
Cc: 7eggert@gmx.de, "H. Peter Anvin" <hpa@zytor.com>,
       linux-kernel@vger.kernel.org
References: <4N6EL-4Hq-3@gated-at.bofh.it> <200509170028.59973.dhazelton@enter.net> <432BB77E.3050501@v.loewis.de>
In-Reply-To: <432BB77E.3050501@v.loewis.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200509172231.33872.dhazelton@enter.net>
X-Virus-Checker-Version: Enter.Net Virus Scanner 1.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 17 September 2005 06:28, "Martin v. Löwis" wrote:
> D. Hazelton wrote:
> > This is a bogus argument. You're comparing the way a _binary_
> > executable works to the way an interpreted _text_ script works.
> > execve(), at least on my system, isn't capable of running a
> > script - if I want to do that from a program I have to tell
> > execve() that it's running /bin/sh and the script file is in the
> > parameter list.
>
> This being the linux-kernel list, I assume your system is Linux,
> no? Well, on Linux, execve *does* support script files. This is the
> whole point of my patch - I would not propose a kernel patch to
> improve this support if it weren't there in the first place.

This is news to me. The last time I handed execve() a script as a 
paramter I had errors returned from execve() -- I must admit that 
this was not on my current system and I had assumed that the behavior 
would be consistent.

> > While I appreciate that the kernel is capable of performing
> > complex actions when execve runs into a file that is not an a.out
> > or elf binary I have yet to see a "binfmt script" option in the
> > kernel config files ever.
>
> It's not a config option because it is always enabled. See
> fs/binfmt_script.c for details. It wasn't integrated into the
> binfmt system until I made it so some ten years ago, though.

I haven't gotten into that section of the code yet. I've been slowly 
working my way through the code from the drivers that seem to cause 
strange behavior on my system and then up the tree from there.

> > On the other hand, there is the "binfmt_misc" option, which does
> > the work that you seem to be looking for and can, AFAIK, be set
> > to handle both ASCII and UTF-8 scripts. Why add the complexity to
> > the kernel when it's not needed?
>
> One shouldn't add complexity if its not needed. However, this patch
> does not add complexity. It is fairly trivial.

You are correct. It is fairly trivial. However my point still is valid 
that the Kernel has the whole binfmt_misc system -- I will admit that 
I have recently been shown numbers that show a noticeable difference 
in the speed of a binary executed using the binfmt_misc system and 
the binfmt_script system, but the fact remains that offering handling 
for UTF8 and ASCII scripts directly in the kernel will likely lead to 
at least one more patch in which the the full Unicode standard is 
implemented.

That, and my point remains that the kernel should know absolutely 
nothing about how to execute a text file - the kernel should return 
an error to the extent of "I don't know what to do with this file" to 
the shell that tries to execute it, and the shell can then check for 
the sh_bang. I do admit that this change would break a lot of 
existing code, so I'll leave the argument to the experts.


> Regards,
> Martin

DRH
