Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262713AbVA0Tvc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262713AbVA0Tvc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 14:51:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262715AbVA0Tvc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 14:51:32 -0500
Received: from p-mail1.rd.francetelecom.com ([195.101.245.15]:16905 "EHLO
	p-mail1.rd.francetelecom.com") by vger.kernel.org with ESMTP
	id S262713AbVA0TvO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 14:51:14 -0500
Message-ID: <41F94661.9090002@francetelecom.REMOVE.com>
Date: Thu, 27 Jan 2005 20:52:01 +0100
From: Julien TINNES <julien.tinnes.NOSPAM@francetelecom.REMOVE.com>
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
MIME-Version: 1.0
Newsgroups: gmane.linux.kernel
To: linux-os@analogic.com
CC: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Patch 4/6  randomize the stack pointer
References: <20050127101117.GA9760@infradead.org>  <20050127101322.GE9760@infradead.org>  <41F92721.1030903@comcast.net> <1106848051.5624.110.camel@laptopd505.fenrus.org> <41F92D2B.4090302@comcast.net> <Pine.LNX.4.58.0501271010130.2362@ppc970.osdl.org> <Pine.LNX.4.61.0501271414010.23221@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.61.0501271414010.23221@chaos.analogic.com>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 27 Jan 2005 19:51:10.0532 (UTC) FILETIME=[8CA1B840:01C504A9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Gentlemen,
> 
> Isn't the return address on the stack an offset in the
> code (.text) segment?
> 
> How would a random stack-pointer value help? I think you would
> need to start a program at a random offset, not the stack!
> No stack-smasher that worked would care about the value of
> the stack-pointer.

While exploiting a stacks buffer overflow you can do at least two things:
* Changing the execution flow by overwriting return address or saved EBP.
* Injecting new executable code in the stack.

"Standard" stack smashing is doing both. The purpose of stack 
randomization is to make it harder to jump to code injected into the 
stack. If enough bits are randomized it's unlikely that an exploit will 
find the correct address at the first try. Now all you need is to make 
sure the vulnerable program won't be relaunched after a given number of 
crashes (or the chances that the exploit find the correct address will 
raise).

Of course you could inject code in other places or use existing code in 
address space (libc or running program) but this is at least a first 
layer of protection and adding layers is exactly what security is about.

-- 
Julien TINNES - & france telecom - R&D Division/MAPS/NSS
Research Engineer - Internet/Intranet Security
GPG: C050 EF1A 2919 FD87 57C4 DEDD E778 A9F0 14B9 C7D6
