Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267471AbTBLSSy>; Wed, 12 Feb 2003 13:18:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267487AbTBLSSx>; Wed, 12 Feb 2003 13:18:53 -0500
Received: from air-2.osdl.org ([65.172.181.6]:40422 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S267471AbTBLSSw>;
	Wed, 12 Feb 2003 13:18:52 -0500
Date: Wed, 12 Feb 2003 10:25:40 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Andrew Morton <akpm@digeo.com>
Cc: root@chaos.analogic.com, linux-kernel@vger.kernel.org
Subject: Re: Panic `cat /proc/ioports`
Message-Id: <20030212102540.7fe1e55d.rddunlap@osdl.org>
In-Reply-To: <20030212092224.27aa4723.akpm@digeo.com>
References: <20030211154413.19a172f4.akpm@digeo.com>
	<Pine.LNX.3.95.1030212081934.6864A-100000@chaos.analogic.com>
	<20030212092224.27aa4723.akpm@digeo.com>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.6 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Feb 2003 09:22:24 -0800
Andrew Morton <akpm@digeo.com> wrote:

| "Richard B. Johnson" <root@chaos.analogic.com> wrote:
| >
| > On Tue, 11 Feb 2003, Andrew Morton wrote:
| > 
| > > "Richard B. Johnson" <root@chaos.analogic.com> wrote:
| > > >
| > > > Linux version 2.4.18, after it runs for a few days, will panic
| > > > if I do `cat /proc/ioports`. Has this been reported/fixed in
| > > > later versions?
| > > > 
| > > > : Unable to handle kernel paging request at virtual address d48e2fa0 
| > > 
| > > This means that some driver which was previously loaded forgot to do a
| > > release_region().  Later, the /proc code tries to read stuff from within the
| > > driver which isn't there any more and oopses.
| > > 
| > 
| > Yes. I just noticed that most network board drivers in version 2.4.18
| > do not execute release_region() after they have done a request_region(),
| > if they fail to install because of some error.
| 
| Fairly common error.
| 
| > The error in this case was
| > the failure to allocate memory because I told the kernel I only had 4
| > megabytes (exprimental ioremap() of the rest in another module).
| > 
| > Is somebody fixing these drivers (do you know).
| 
| There is ongoing janitorial work, and things are getting better.
| But I'm not aware of anyone specifically auditing for missing
| release_region()s.  And given that it is a box-killer rather than
| just a memory leak, yes, it is worth an audit.

Dick,
Did you ever determine which driver (or module) was causing this problem?

--
~Randy
