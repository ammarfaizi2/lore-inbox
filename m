Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261206AbSKKUSw>; Mon, 11 Nov 2002 15:18:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261224AbSKKUSw>; Mon, 11 Nov 2002 15:18:52 -0500
Received: from sb0-cf9a4971.dsl.impulse.net ([207.154.73.113]:27922 "EHLO
	madrabbit.org") by vger.kernel.org with ESMTP id <S261206AbSKKUSv>;
	Mon, 11 Nov 2002 15:18:51 -0500
Subject: Re: [PATCH] Re: sscanf("-1", "%d", &i) fails, returns 0
From: Ray Lee <ray-lk@madrabbit.org>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: hps@intermeta.de, schwab@suse.de,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33L2.0211111019300.23954-100000@dragon.pdx.osdl.net>
References: <Pine.LNX.4.33L2.0211111019300.23954-100000@dragon.pdx.osdl.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 11 Nov 2002 12:25:34 -0800
Message-Id: <1037046334.22906.117.camel@orca>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-11-11 at 11:09, Randy.Dunlap wrote:
> | It only sounds strange at first. It actually means that scanf is
> | consistent with C's rules of assignment between mixed types. For
> | example:
<snip>
> These values (-100 and 4294967196) are the same bits, just observed/used
> in a different manner.

I probably didn't state it very clearly, but that was what I was getting
at. It's the same value after a cast. As Andreas points out though, it
may not be bit-for-bit identical on machines that don't use two's
complement. That's why the conversion code cares about the format
specifiers, it seems.

> Now what does it mean to "convert the value to an unsigned and return
> that."  This is the same as above, isn't it?

Explicitly, in the scan conversion you'd do a:

  unsigned int *u = (unsigned int *) va_arg(args,long long *);
  *u = (unsigned int) converted_value;

...from wherever you get converted_value from (simple_strtoul? I haven't
looked at that routine). (The cast here is implied if left off, I'm just
being explicit.)

> I.e., on the scanf() side, there is no conversion needed; just store the
> value.

Almost true, as Andreas pointed out. You have to be careful that the
target you're storing to has the correctly declared type inside the
conversion routine. 

Ray

