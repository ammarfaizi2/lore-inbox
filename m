Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135978AbREJB1c>; Wed, 9 May 2001 21:27:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135981AbREJB1Y>; Wed, 9 May 2001 21:27:24 -0400
Received: from mfo01.iij.ad.jp ([202.232.2.118]:38917 "EHLO mfo01.iij.ad.jp")
	by vger.kernel.org with ESMTP id <S135978AbREJB1M>;
	Wed, 9 May 2001 21:27:12 -0400
Date: Thu, 10 May 2001 10:23:48 +0900 (JST)
Message-Id: <20010510.102348.59467080.okuyamak@dd.iij4u.or.jp>
To: atheurer@austin.ibm.com
Cc: lse-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        samba-technical@samba.org
Subject: Re: Linux 2.4 Scalability, Samba, and Netbench
From: Kenichi Okuyama <okuyamak@dd.iij4u.or.jp>
In-Reply-To: <3AF97062.42465A53@austin.ibm.com>
In-Reply-To: <3AF97062.42465A53@austin.ibm.com>
X-Mailer: Mew version 1.95b91 on Emacs 20.7 / Mule 4.0 (HANANOEN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "AMT" == Andrew M Theurer <atheurer@austin.ibm.com> writes:
AMT> I would like to help improve SMP scalability on this workload.  If you
AMT> have questions or comments about the above results, or if you are
AMT> conducting similar tests, please send email to
AMT> lse-tech@lists.sourceforge.net.  I have some ideas on my next steps,
AMT> but would like to discuss first.


Did you check vmstat result of each benchmarks?

Most of the problems are caused due to kernel. If you look at result
of vmstat, more than 80% CPU time are used in kernel.

It's true that heavy kernel overhead is due to Samba, and is due to
Samba generating lot's and lot's of request against kernels ( not
only disk IO, but it requires many signal handling etc ).

So, there's really two things we need to do.

1) make Linux more scalable.
   ( This sometimes seems as if it's tuning, but it's really bug
     fix. So, don't ask performance team to tune. Let them FIX. )
 
2) make Samba work in less signals.
   This means, don't call useless system calls, use shared memory
   more effectively, divide Samba source into OS dependent part
   and independent part so that you can do tuning for specific OS
   and still have wide userland, etc.
---- 
Kenichi Okuyama.
