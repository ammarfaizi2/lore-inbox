Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261888AbVCZAR3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261888AbVCZAR3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 19:17:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261889AbVCZAR3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 19:17:29 -0500
Received: from mx1.redhat.com ([66.187.233.31]:52952 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261888AbVCZARW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 19:17:22 -0500
Date: Fri, 25 Mar 2005 19:17:02 -0500
From: Dave Jones <davej@redhat.com>
To: Mingming Cao <cmm@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, Andrea Arcangeli <andrea@suse.de>,
       mjbligh@us.ibm.com, linux-kernel@vger.kernel.org,
       ext2-devel <ext2-devel@lists.sourceforge.net>
Subject: Re: OOM problems on 2.6.12-rc1 with many fsx tests
Message-ID: <20050326001702.GA22347@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Mingming Cao <cmm@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
	Andrea Arcangeli <andrea@suse.de>, mjbligh@us.ibm.com,
	linux-kernel@vger.kernel.org,
	ext2-devel <ext2-devel@lists.sourceforge.net>
References: <20050315204413.GF20253@csail.mit.edu> <20050316003134.GY7699@opteron.random> <20050316040435.39533675.akpm@osdl.org> <20050316183701.GB21597@opteron.random> <1111607584.5786.55.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1111607584.5786.55.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 23, 2005 at 11:53:04AM -0800, Mingming Cao wrote:

 > The fsx command is:
 > 
 > ./fsx -c 10 -n -r 4096 -w 4096 /mnt/test/foo1 &
 > 
 > I also see fsx tests start to generating report about read bad data
 > about the tests have run for about 9 hours(one hour before of the OOM
 > happen). 

Is writing to the same testfile from multiple fsx's supposed to work?
It sounds like a surefire way to break the consistency checking that it does.
I'm surprised it lasts 9hrs before it breaks.

In the past I've done tests like..

for i in `seq 1 100`
do
  fsx foo$i &
done

to make each process use a different test file.

		Dave

