Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132830AbRDQTVK>; Tue, 17 Apr 2001 15:21:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132827AbRDQTVB>; Tue, 17 Apr 2001 15:21:01 -0400
Received: from maniola.plus.net.uk ([195.166.135.195]:35457 "HELO
	mail.plus.net.uk") by vger.kernel.org with SMTP id <S132826AbRDQTUs>;
	Tue, 17 Apr 2001 15:20:48 -0400
Content-Type: text/plain; charset=US-ASCII
From: "D.W.Howells" <dhowells@astarte.free-online.co.uk>
To: andrea@suse.de
Subject: Re: generic rwsem [Re: Alpha "process table hang"]
Date: Tue, 17 Apr 2001 20:18:57 +0100
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-Id: <01041720185700.01003@orion.ddi.co.uk>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea,

> As said the design of the framework to plugin per-arch rwsem implementation 
> isn't flexible enough and the generic spinlocks are as well broken, try to 
> use them if you can (yes I tried that for the alpha, it was just a mess and 
> it was more productive to rewrite than to fix).

Having thought about the matter a bit, I know what the problem is:

As stated in the email with the latest patch, I haven't yet extended this to 
cover any architecture but i386. That patch was actually put up for comments, 
though it got included anyway.

Therefore, all other archs use the old (and probably) broken implementations!

I'll quickly knock up a patch to fix the other archs. This should also fix 
the alpha problem.

As for making the stuff I had done less generic, and more specific, I only 
made it more generic because I got asked to by a number of people. It was 
suggested that I move the contention functions into lib/rwsem.c and make them 
common.

As far as using atomic_add_return() goes, the C compiler cannot make the 
fastpath anywhere near as efficient, because amongst other things, I can make 
use of the condition flags set in EFLAGS and the compiler can't.

> And it's also more readable and it's not bloated code, 65+110 lines
> compared to 156+148+174 lines. 

You do my code an injustice there... I've put comments in mine.

David
