Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264726AbSJ3Q2C>; Wed, 30 Oct 2002 11:28:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264731AbSJ3Q2C>; Wed, 30 Oct 2002 11:28:02 -0500
Received: from tapu.f00f.org ([66.60.186.129]:54242 "EHLO tapu.f00f.org")
	by vger.kernel.org with ESMTP id <S264726AbSJ3Q2B>;
	Wed, 30 Oct 2002 11:28:01 -0500
Date: Wed, 30 Oct 2002 08:34:25 -0800
From: Chris Wedgwood <cw@f00f.org>
To: "Kenneth M. Howlett" <av556@detroit.freenet.org>
Cc: linux-kernel@vger.kernel.org, mnalis-umsdos@voyager.hr,
       chaffee@cs.berkeley.edu, bsg@uniyar.ac.ru
Subject: Re: PROBLEM: dos filesystem timestamps and daylight savings time
Message-ID: <20021030163425.GB13126@tapu.f00f.org>
References: <200210300108.UAA17536@detroit.freenet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200210300108.UAA17536@detroit.freenet.org>
User-Agent: Mutt/1.4i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 29, 2002 at 08:08:20PM -0500, Kenneth M. Howlett wrote:

> I think the timestamps of a dos filesystem are stored in local
> time.

Yes, I beleive it does.

> So the dos filesystem driver needs to convert the local time to unix
> standard time, and then ls converts back to local time, and displays
> the timestamp in local time.

Nope.... that's a disgusting ugly hack that won't work (consider that
there are two 2:00am for example in a given time zone, one DST and one
without, does DOS store a bit to say which is which in ambiguous
cases?)

If anything, the FS should know about a tz-offset and just simply add
that to the timestamps before passing the data up to the VFS...

<pause>

Checking the code, it uses sys_tz to do exactly this...



  --cw
