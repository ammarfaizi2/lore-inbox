Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267306AbTBVSMx>; Sat, 22 Feb 2003 13:12:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267315AbTBVSMx>; Sat, 22 Feb 2003 13:12:53 -0500
Received: from tom.hrz.tu-chemnitz.de ([134.109.132.38]:33972 "EHLO
	tom.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S267306AbTBVSMx>; Sat, 22 Feb 2003 13:12:53 -0500
Date: Sat, 22 Feb 2003 14:57:28 +0100
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Andrew Morton <akpm@digeo.com>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org, andrea@suse.de
Subject: Re: [ak@suse.de: Re: iosched: impact of streaming read on read-many-files]
Message-ID: <20030222145728.L629@nightmaster.csn.tu-chemnitz.de>
References: <20030222054307.GA22074@wotan.suse.de> <20030221230716.630934cf.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20030221230716.630934cf.akpm@digeo.com>; from akpm@digeo.com on Fri, Feb 21, 2003 at 11:07:16PM -0800
X-Spam-Score: -3.0 (---)
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *18meIe-0003JP-00*RR61Kl7TmUs*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 21, 2003 at 11:07:16PM -0800, Andrew Morton wrote:
> You have not defined "fix".  An IO scheduler which attempts to serve every
> request within ten milliseconds is an impossibility.  Attempting to 
> achieve it will result in something which seeks all over the place.
> 
> The best solution is to implement five or ten seconds worth of buffering
> in the application and for the kernel to implement a high throughput general
> purpose I/O scheduler which does not suffer from starvation.

What about implementing io-requests, which can time out? So if it will
not be serviced in time or we know, that it will not be serviced
in time, we can skip that.

This can easily be stuffed into the aio-api by cancelling
requests, which are older than a specified time. Just attach a
jiffie to each request and make a new syscall like io_cancel but
with a starting time attached. Or even make it a property of the
aio list we are currently handling and use a kernel timer.

That way we could help streaming applications and the kernel
itself (by reducing its io-requests) at the same time.

Combined with you buffering suggestion, this will help cases,
where the system is under high load and cannot satisfy these
applications anyway.

What do you think?

Regards

Ingo Oeser
-- 
Science is what we can tell a computer. Art is everything else. --- D.E.Knuth
