Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275926AbSIURrk>; Sat, 21 Sep 2002 13:47:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275928AbSIURrk>; Sat, 21 Sep 2002 13:47:40 -0400
Received: from holomorphy.com ([66.224.33.161]:34189 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S275926AbSIURrk>;
	Sat, 21 Sep 2002 13:47:40 -0400
Date: Sat, 21 Sep 2002 10:46:06 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@transmeta.com>, Andries Brouwer <aebr@win.tue.nl>,
       linux-kernel@vger.kernel.org
Subject: Re: quadratic behaviour
Message-ID: <20020921174606.GR3530@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Ingo Molnar <mingo@elte.hu>,
	Linus Torvalds <torvalds@transmeta.com>,
	Andries Brouwer <aebr@win.tue.nl>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0209210958080.2702-100000@home.transmeta.com> <Pine.LNX.4.44.0209211940350.452-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0209211940350.452-100000@localhost.localdomain>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 21 Sep 2002, Linus Torvalds wrote:
>> But the quadratic behaviour wrt processes clearly isn't fixed.
>> Suggestions welcome (and we'll need to avoid the same quadratic
>> behaviour wrt the threads when we expose them).

On Sat, Sep 21, 2002 at 07:49:49PM +0200, Ingo Molnar wrote:
> in the case of threads my plan is to use the pid alloction bitmap for
> this. It slightly overestimates the pids because orphan sessions and pgrps
> are included as well, but this should not be a problem because procfs also
> does a pid lookup when the specific directory is accessed. This method is
> inherently restartable, the pid bitmap pages are never freed, and it's the
> most cache-compact representation of the sorted pidlist. And it can be
> accessed lockless ...

This sounds more attractive still. I'll forego the strategy of my prior
post and try to squeeze some more benchmark numbers out of things over
the weekend.


Cheers,
Bill
