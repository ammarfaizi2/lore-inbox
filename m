Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262687AbTJPEka (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 00:40:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262690AbTJPEka
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 00:40:30 -0400
Received: from holomorphy.com ([66.224.33.161]:21634 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S262687AbTJPEk3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 00:40:29 -0400
Date: Wed, 15 Oct 2003 21:43:34 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Alberto Bertogli <albertogli@telpin.com.ar>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test5/6 (and probably 7 too) size-4096 memory leak
Message-ID: <20031016044334.GE4461@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>,
	Alberto Bertogli <albertogli@telpin.com.ar>,
	linux-kernel@vger.kernel.org
References: <20031016025554.GH4292@telpin.com.ar> <20031015211918.1a70c4d2.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031015211918.1a70c4d2.akpm@osdl.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alberto Bertogli <albertogli@telpin.com.ar> wrote:
>>  Slabinfo reports that size-4096 has 104341 active objects and growing.
>>  On another box at home I see the same issue with test6, but "only" with
>>  11612 objects; I'm not posting info on this box as I guess the mailserver
>>  is much more important because the leak is really noticeable.

On Wed, Oct 15, 2003 at 09:19:18PM -0700, Andrew Morton wrote:
> At least I'm not the only one; my main desktop machine does the same
> thing.  It leaks two megabytes a day into size-4096, like clockwork.  It's
> up to 43 megs now.
> I was ignoring it and hoping it would go away.  Ho hum.  Tricky.

I immediately thought of bundling this in with the do_exit() BUG() and
/proc/ oopsen, but we would see a task_t leak also in that case. I still
say the /proc/ change is swiss cheese (well, in concept there's nothing
wrong with what it wants to do, but there's something definitely wrong
with the implementation since backing it out stops things from oopsing),
but this looks unrelated therefore (which is actually depressing, since
we can't kill all three in one shot and/or get anywhere by correlating).
I should try using a dedicated stack slab to see if they're stacks even
though task_t's aren't leaking.

-- wli
