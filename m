Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264511AbRFTRhU>; Wed, 20 Jun 2001 13:37:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264512AbRFTRhK>; Wed, 20 Jun 2001 13:37:10 -0400
Received: from 216-60-128-137.ati.utexas.edu ([216.60.128.137]:25478 "HELO
	tsunami.webofficenow.com") by vger.kernel.org with SMTP
	id <S264511AbRFTRhI>; Wed, 20 Jun 2001 13:37:08 -0400
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@webofficenow.com>
Reply-To: landley@webofficenow.com
To: Larry McVoy <lm@bitmover.com>, Ben Greear <greearb@candelatech.com>
Subject: Re: [OT] Threads, inelegance, and Java
Date: Wed, 20 Jun 2001 08:36:07 -0400
X-Mailer: KMail [version 1.2]
Cc: Aaron Lehmann <aaronl@vitelus.com>, hps@intermeta.de,
        linux-kernel@vger.kernel.org
In-Reply-To: <20010620042544.E24183@vitelus.com> <3B30BD5D.153A5FE9@candelatech.com> <20010620095329.M3089@work.bitmover.com>
In-Reply-To: <20010620095329.M3089@work.bitmover.com>
MIME-Version: 1.0
Message-Id: <01062008360706.00776@localhost.localdomain>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 20 June 2001 12:53, Larry McVoy wrote:

> We couldn't believe that Java was really that bad so our GUI guy, Aaron
> Kushner, sat down and rewrote the revision history browser in Java.
> On a 500 node graph, the Java tool was up to 85MB.  The tk tool doing
> the same thing was 5MB.  Note that we routinely run the tool on files
> with 4000 nodes, we can't even run the Java tool on files that big,
> it crashes.

I can second that.

I recently mentioned an OS/2 abonination called Feature Install.  Around 1996 
I tried to port Feature Install to java 1.0.  I got as far as the response 
file reading code, and reading in a 100k file exhausted available memory on 
the 32 megabyte machine I was working on.

Remember, every single java object includes a BUNCH of data, including two 
semaphores (one event, one mutex) and who knows what else.  On OS/2 the 
overhead of a java 1.0 object (new Object();) was 2 kilobytes!  In later 
versions they got that down to around 200k, but it's still just rediculous.  
Every single String, every pointless Integer() wrapper, every temporarily 
created Stringbuffer() discarded by a + operation left there littering the 
stack.

Plus I have yet to see a JVM that actually reclaims heap space after a 
garbage collect and gives it back to the OS.  (You have to be able to 
relocate objects to do this at all reliably...)

So if you create a large number of small objects, EVER, (tree, etc,) it's 
going to explode the heap and it'll never come down until the program exits.

> So, yeah, we have done what you think we haven't done, and we've tried
> the Java way, we aren't making this stuff up.  We run into Java fanatics
> all the time and when we start asking "so what toolkits do you use" we
> get back "well, actually, err, umm, none of them are any good so we write
> our own".  That's pathetic.

Also true.

The Graphics class isn't too bad, and lightweight containers are actually 
quite nice.  But swing is just insanely bad (I have to understand 
model/view/controller and select a look-and-feel just to pop up a dialog with 
an "ok" button?), and the only serious third party challenger to it was from 
MIcrosoft...

Rob
