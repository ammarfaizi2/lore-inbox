Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268369AbUH2Xck@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268369AbUH2Xck (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 19:32:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268399AbUH2Xck
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 19:32:40 -0400
Received: from sccrmhc12.comcast.net ([204.127.202.56]:6614 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S268400AbUH2Xcg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 19:32:36 -0400
Subject: Re: [BENCHMARK] nproc: netlink access to /proc information
From: Albert Cahalan <albert@users.sf.net>
To: Roger Luethi <rl@hellgate.ch>
Cc: William Lee Irwin III <wli@holomorphy.com>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Paul Jackson <pj@sgi.com>
In-Reply-To: <20040829214150.GA5060@k3.hellgate.ch>
References: <20040828194546.GA25523@k3.hellgate.ch>
	 <20040828195647.GP5492@holomorphy.com>
	 <20040828201435.GB25523@k3.hellgate.ch>
	 <20040829160542.GF5492@holomorphy.com>
	 <20040829170247.GA9841@k3.hellgate.ch>
	 <20040829172022.GL5492@holomorphy.com>
	 <20040829175245.GA32117@k3.hellgate.ch>
	 <20040829181627.GR5492@holomorphy.com>
	 <20040829190050.GA31641@k3.hellgate.ch> <1093810645.434.6859.camel@cube>
	 <20040829214150.GA5060@k3.hellgate.ch>
Content-Type: text/plain
Organization: 
Message-Id: <1093822277.431.6919.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 29 Aug 2004 19:31:17 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-08-29 at 17:41, Roger Luethi wrote:

> And FWIW, you don't need the "minimum set of /proc
> files needed to supply some required set of process
> attributes". Any set that supplies the required fields
> will do, and you can get an excellent approximation
> in O(n).

You got that, and you didn't like it.

I'm sure it wouldn't be hard to hack up some
special-case optimization for the cases you've
listed. As soon as I do so, you'll find another
special case. Ultimately, you ARE asking to have
procps solve the NP-hard set-covering problem.

There are several good reasons to not go down
that path. The potential for increasing numbers
of /proc files in the future is one. Another is
the very limited benefit; typical ps usage does
require much of that data. Maintainability is yet
another reason; ps does more than just spit out the
data. It is very useful to have a decent selection
of data items that will always be available for
process selection, sorting, and any other use.
The potential for adding bugs is great.

That said, I do at times tweak the code used to
select data sources. Perhaps I should add a new
/proc/*/basics file for the most popular items.
This would make fancy set-covering choices more
profitable.


