Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264617AbSKICkb>; Fri, 8 Nov 2002 21:40:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264618AbSKICkb>; Fri, 8 Nov 2002 21:40:31 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:52999 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S264617AbSKICka>; Fri, 8 Nov 2002 21:40:30 -0500
Date: Fri, 8 Nov 2002 18:46:59 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: David Woodhouse <dwmw2@infradead.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: RFC: mmap(PROT_READ, MAP_SHARED) fails if !writepage. 
In-Reply-To: <25622.1036799419@passion.cambridge.redhat.com>
Message-ID: <Pine.LNX.4.44.0211081843010.5564-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 8 Nov 2002, David Woodhouse wrote:
> 
> It's a read-only mapping. Whether it's shared or private is not relevant,
> surely, since those affect only the behaviour if we write to it -- which we 
> can't. 

But why do you expect to be able to mmap shared something you opened RW in
the first place, if the filesystem cannot handle writable m appings?

> I don't _really_ want a shared mapping; all I want is for the fsx-linux
> stress test to run, and find interesting breakage on my file system to keep
> me from getting bored (what are Friday nights for, after all?).

Ok, it's good to have tests, but it sounds like the test is broken.

> As shipped, fsx-linux uses PROT_READ, MAP_SHARED on its test file

Ad shipped, the kernel doesn't allow that.

Notice the pattern here? "As shipped". You have two choices: make 
gratuitous changes to the kernel to make some random test happy, or fix 
the test.

I think you should fix the test. The kernel change buys you _zero_ new 
features.

		Linus

