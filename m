Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261187AbSJ1OJR>; Mon, 28 Oct 2002 09:09:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261205AbSJ1OJQ>; Mon, 28 Oct 2002 09:09:16 -0500
Received: from ns.suse.de ([213.95.15.193]:7437 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S261187AbSJ1OJO>;
	Mon, 28 Oct 2002 09:09:14 -0500
Date: Mon, 28 Oct 2002 15:15:34 +0100
From: Andi Kleen <ak@suse.de>
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
Cc: Andi Kleen <ak@suse.de>, eggert@twinsun.com, linux-kernel@vger.kernel.org
Subject: Re: nanosecond file timestamp resolution in filesystems, GNU make, etc.
Message-ID: <20021028151533.D18441@wotan.suse.de>
References: <20021027153651.GB26297@pimlott.net.suse.lists.linux.kernel> <200210280947.g9S9l9H01162@sic.twinsun.com.suse.lists.linux.kernel> <20021028102809.GA16062@bjl1.asuk.net.suse.lists.linux.kernel> <p73r8eastwo.fsf@oldwotan.suse.de> <20021028125652.GA16329@bjl1.asuk.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021028125652.GA16329@bjl1.asuk.net>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> So I propose: add a field to struct stat indicating the resolution of
> the timestamps in it.  It can go on the end.

It's impossible. There is no space left in struct stat64
And adding a new syscall just for that would be severe overkill.

But what you could do if you really wanted that: implement kernel POSIX
pathconf()/fpathconf() and implement it as a parameter to that. 

kernel pathconf would be needed for some other reasons anyways, e.g. to return 
proper max hard link counts (currently glibc hardcodes the parameters
for various fs in user space and it always breaks the LSB test suite
for new file systems). Ulrich Drepper could probably give you other
reasons on why it is needed if you ask him nicely.

I personally have no plans to implement it, however, because it looks like
kernel bloat to me :-)

-Andi
