Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313114AbSEEHE6>; Sun, 5 May 2002 03:04:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315825AbSEEHE5>; Sun, 5 May 2002 03:04:57 -0400
Received: from gans.physik3.uni-rostock.de ([139.30.44.2]:43271 "EHLO
	gans.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id <S313114AbSEEHE5>; Sun, 5 May 2002 03:04:57 -0400
Date: Sun, 5 May 2002 09:04:48 +0200 (CEST)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Martin Dalecki <dalecki@evision-ventures.com>, Andi Kleen <ak@muc.de>,
        <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.13 IDE and preemptible kernel problems
In-Reply-To: <Pine.LNX.4.44.0205041903480.1594-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.33.0205050850090.15809-100000@gans.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 4 May 2002, Linus Torvalds wrote:

> Hmm.. Something like
> 
> 	#define timeout_expired(x)	time_after(jiffies, (x))
> 
> migth indeed make sense.
> 
> But I'm a lazy bastard. Is there some victim^H^H^H^H^H^Hhero who would
> want to do the 'sed s/time_after(jiffies,/timeout_expired(/g' and verify
> that it does the right thing and send it to me as a patch?
> 
> The thing is, I wonder if it should be "time_after(jiffies,x)" or
> "time_after_eq(jiffies,x)". There's a single-tick difference there..
> 

If you allow a lazy victim to throw in some statistics first:  ;-)

299 potential users preferring time_after_eq, and 160 voting for 
time_after (assuming use of !timeout_expired(x), too):

linux-2.5.13> find ./ -name "*.[ch]" -exec grep "time_before(*jiffies"
 /dev/null {} \; | wc -l
    248
linux-2.5.13> find ./ -name "*.[ch]" -exec grep "time_before_eq( *jiffies" 
 /dev/null {} \; | wc -l
     20
linux-2.5.13> find ./ -name "*.[ch]" -exec grep "time_after( *jiffies" 
 /dev/null {} \; | wc -l
    140
linux-2.5.13> find ./ -name "*.[ch]" -exec grep "time_after_eq( *jiffies" 
 /dev/null {} \; | wc -l
     51

That probably means we need both, as something like 
timeout_expired(x+1) seems to call for new "off by one" errors.


Tim


