Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317181AbSIHRBX>; Sun, 8 Sep 2002 13:01:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317257AbSIHRBX>; Sun, 8 Sep 2002 13:01:23 -0400
Received: from pc1-cwma1-5-cust128.swa.cable.ntl.com ([80.5.120.128]:13043
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317181AbSIHRBW>; Sun, 8 Sep 2002 13:01:22 -0400
Subject: Re: LMbench2.0 results
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Cc: Andrew Morton <akpm@digeo.com>, William Lee Irwin III <wli@holomorphy.com>,
       Paolo Ciarrocchi <ciarrocchi@linuxmail.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <2090000.1031442267@flay>
References: <20020907121854.10290.qmail@linuxmail.org>
	<3D7A2768.E5C85EB@digeo.com> <20020907200334.GI888@holomorphy.com>
	<3D7A87F1.F3D0865C@digeo.com>  <2090000.1031442267@flay>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-6) 
Date: 08 Sep 2002 18:07:28 +0100
Message-Id: <1031504848.26888.238.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-09-08 at 00:44, Martin J. Bligh wrote:
> >> Perhaps testing with overcommit on would be useful.
> > 
> > Well yes - the new overcommit code was a significant hit on the 16ways
> > was it not?  You have some numbers on that?
> 
> About 20% hit on system time for kernel compiles.

That suprises me a lot. On a 2 way and 4 way the 2.4 memory overcommit
check code didnt show up. That may be down to the 2 way being on a CPU
that has no measurable cost for locked operations and the 4 way being an
ancient ppro a friend has.

If it is the memory overcommit handling then there are plenty of ways to
deal with it efficiently in the non-preempt case at least. I had
wondered originally about booking chunks of pages off per CPU (take the
remaining overcommit divide by four and only when a CPU finds its
private block is empty take a lock and redistribute the remaining
allocation). Since boxes almost never get that close to overcommit
kicking in then it should mean we close to never touch a locked count.

