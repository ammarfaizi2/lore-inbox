Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291773AbSBHTg4>; Fri, 8 Feb 2002 14:36:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291772AbSBHTgo>; Fri, 8 Feb 2002 14:36:44 -0500
Received: from zero.tech9.net ([209.61.188.187]:40203 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S291771AbSBHTgb>;
	Fri, 8 Feb 2002 14:36:31 -0500
Subject: Re: [RFC] New locking primitive for 2.5
From: Robert Love <rml@tech9.net>
To: Alexander Viro <viro@math.psu.edu>
Cc: Linus Torvalds <torvalds@transmeta.com>, Andrew Morton <akpm@zip.com.au>,
        Martin Wirth <Martin.Wirth@dlr.de>, linux-kernel@vger.kernel.org,
        mingo@elte.hu, haveblue@us.ibm.com
In-Reply-To: <Pine.GSO.4.21.0202081416410.28514-100000@weyl.math.psu.edu>
In-Reply-To: <Pine.GSO.4.21.0202081416410.28514-100000@weyl.math.psu.edu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 08 Feb 2002 14:36:26 -0500
Message-Id: <1013196987.805.153.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-02-08 at 14:21, Alexander Viro wrote:

> Had anyone actually seen lseek() vs. lseek() contention prior to the
> switch to ->i_sem-based variant?

Yes, I did, even on my 2-way.

Additionally, when I posted the remove-bkl-llseek patch, someone from
SGI noted that on a 24-processor NUMA IA-64 machine, _50%_ of machine
time was spent spinning on the BKL in llseek-intense operations.

The bkl is not held for a long time, but it is acquired often, and there
are definitely workloads that show a big hit with the BKL in there.

	Robert Love

