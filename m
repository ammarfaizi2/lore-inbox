Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262835AbTJGX01 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Oct 2003 19:26:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262855AbTJGX01
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Oct 2003 19:26:27 -0400
Received: from fw.osdl.org ([65.172.181.6]:51094 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262835AbTJGX0Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Oct 2003 19:26:25 -0400
Date: Tue, 7 Oct 2003 16:25:46 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Robert White <rwhite@casabyte.com>
cc: "'Albert Cahalan'" <albert@users.sourceforge.net>,
       "'Ulrich Drepper'" <drepper@redhat.com>,
       "'Mikael Pettersson'" <mikpe@csd.uu.se>,
       "'Kernel Mailing List'" <linux-kernel@vger.kernel.org>
Subject: RE: Who changed /proc/<pid>/ in 2.6.0-test5-bk9?
In-Reply-To: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA2ZSI4XW+fk25FhAf9BqjtMKAAAAQAAAAQemaQXZL7UqvO6rldPpFKgEAAAAA@casabyte.com>
Message-ID: <Pine.LNX.4.44.0310071621280.16239-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 7 Oct 2003, Robert White wrote:
>
> I can say that (virtually) any programmer who does a lot of threads work is
> going to presume that he may pass file handles between threads safely.
> 
> IMHO it would be exceptionally bad to break this assumption.

That's not true.

It's true that if you use the pthreads model, you'll pass fd's between 
threads freely.

But there are lots of other valid thread usages. Many of the original uses 
of Linux threading were for special-case apps which used the clone() 
interface directly. Some were games, where the native threading stuff was 
doing things like sound etc in the background.

And when you have _that_ kind of model (with assymetric specialized 
threads), it makes perfect sense for the threads to have independent file 
descriptors.

> At the purist level, when I pass an abstraction (data structure etc) around
> between my threads, having done my due-diligence WRT locking and such, I
> expect that when the abstraction gets there it will still be valid.

And that is what you get with pthreads.

But the native Linux threading has never been pthreads. It's been about a 
much more generic thing, where the user is in control of what he does.

And that, btw, implies that thread nazis that only use pthreads do _not_ 
get to determine what the rest of the world does.

		Linus

