Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317422AbSIIQB2>; Mon, 9 Sep 2002 12:01:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317457AbSIIQB2>; Mon, 9 Sep 2002 12:01:28 -0400
Received: from blackbird.intercode.com.au ([203.32.101.10]:50696 "EHLO
	blackbird.intercode.com.au") by vger.kernel.org with ESMTP
	id <S317422AbSIIQB1>; Mon, 9 Sep 2002 12:01:27 -0400
Date: Tue, 10 Sep 2002 02:06:04 +1000 (EST)
From: James Morris <jmorris@intercode.com.au>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Performance issue in 2.5.32+
In-Reply-To: <Pine.LNX.4.44.0209081055310.14734-100000@home.transmeta.com>
Message-ID: <Mutt.LNX.4.44.0209100150490.25061-100000@blackbird.intercode.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 8 Sep 2002, Linus Torvalds wrote:

> I don't really see anythign very suspicious in the 31->32 changelogs. 
> Somebody else already mentioned TLS etc, but that shouldn't really be 
> noticeable...

I've now tracked the problem to the introduction of the new mtrr code, and
backing it out for 2.5.32 restores original performance.  From what I can 
tell, the new code is not handling a bios/hardware bug that the old code 
was.

The old mtrr code says this during bootup:
 mtrr: your CPUs had inconsistent fixed MTRR settings
 mtrr: your CPUs had inconsistent variable MTRR settings
 mtrr: probably your BIOS does not setup all CPUs

While the new code just says:
 mtrr: SMP support incomplete for this vendor

The peformance hit is basically the same as when the old mtrr code is 
disabled.  I'll have a poke around and see if I can find out why the new 
mtrr code isn't handling the problem.


- James
-- 
James Morris
<jmorris@intercode.com.au>


