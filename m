Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291599AbSBTCMV>; Tue, 19 Feb 2002 21:12:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291608AbSBTCML>; Tue, 19 Feb 2002 21:12:11 -0500
Received: from ns1.crl.go.jp ([133.243.3.1]:20210 "EHLO ns1.crl.go.jp")
	by vger.kernel.org with ESMTP id <S291599AbSBTCL5>;
	Tue, 19 Feb 2002 21:11:57 -0500
Date: Wed, 20 Feb 2002 11:10:45 +0900 (JST)
From: Tom Holroyd <tomh@po.crl.go.jp>
X-X-Sender: tomh@holly.crl.go.jp
To: Andreas Schwab <schwab@suse.de>
cc: Tim Schmielau <tim@physik3.uni-rostock.de>,
        kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Unknown HZ value! (1908) Assume 1024.
In-Reply-To: <jeheod929p.fsf@sykes.suse.de>
Message-ID: <Pine.LNX.4.44.0202201101080.1972-100000@holly.crl.go.jp>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> |> 	jif * smp_num_cpus - (user + nice + system)
>
> Changing the line to this:
>
>  	jif * smp_num_cpus - user - nice - system
>
> should avoid the overflow.

True.  It still might be a good idea to make them longs, though,
because they are really totals of all the CPUs, as in:
                user += kstat.per_cpu_user[cpu];

Now ultimately, kstat.per_cpu_user[cpu] will overflow, and I don't
know what to do about that, but making user, nice, and system unsigned
long will at least allow SMP systems to last a little while longer.
(Actually I don't know why Procps needs these values at all -- the
claim in the code is that all of this is just to compute the HZ value,
which is presumably needed to be able to interpret jiffies.  It'd be a
lot simpler just to have /proc/stat export the HZ value directly.)

