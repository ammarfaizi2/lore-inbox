Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317380AbSHVWEs>; Thu, 22 Aug 2002 18:04:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317385AbSHVWEs>; Thu, 22 Aug 2002 18:04:48 -0400
Received: from holomorphy.com ([66.224.33.161]:25739 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S317380AbSHVWEr>;
	Thu, 22 Aug 2002 18:04:47 -0400
Date: Thu, 22 Aug 2002 15:05:25 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Mala Anand <manand@us.ibm.com>, Benjamin LaHaise <bcrl@redhat.com>,
       alan@lxorguk.ukuu.org.uk, Bill Hartner <bhartner@us.ibm.com>,
       davem@redhat.com, linux-kernel@vger.kernel.org,
       lse-tech@lists.sourceforge.net, lse-tech-admin@lists.sourceforge.net
Subject: Re: [Lse-tech] Re: (RFC): SKB Initialization
Message-ID: <20020822220525.GZ21685@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Dave Hansen <haveblue@us.ibm.com>, Mala Anand <manand@us.ibm.com>,
	Benjamin LaHaise <bcrl@redhat.com>, alan@lxorguk.ukuu.org.uk,
	Bill Hartner <bhartner@us.ibm.com>, davem@redhat.com,
	linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net,
	lse-tech-admin@lists.sourceforge.net
References: <OF126E7130.D54285DD-ON87256C1C.0077A747@boulder.ibm.com> <3D653543.6000403@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <3D653543.6000403@us.ibm.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 22, 2002 at 12:02:27PM -0700, Dave Hansen wrote:
> You can see the entire readprofile here:
> http://www.sr71.net/~specweb99/run-specweb-100sec-2400-2.5.31-bk+4-kmap-08-22-2002-11.20.17/
> http://www.sr71.net/~specweb99/run-specweb-100sec-2400-2.5.31-bk+4-kmap-mala-08-22-2002-11.44.25/
> No, I don't know why I have so much idle time.

Hmm, I found that tiobench was spending a lot of time idle due to
__wait_on_inode() and get_request_wait(). I bumped up the size of
the inode wait table to 1024 and the request queue size to 16384
and saw that most of them then spent their time stuck on ->i_sem
during the initial open of the file they were going to pound on
for the duration of the run.

I determined this by just ^C'ing with kgdb and backtracing various
"stuck" processes. I think various profiling patches might be able to
give you an idea of what people are going to sleep on too.


Cheers,
Bill
