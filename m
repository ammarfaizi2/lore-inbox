Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261582AbSKHDrg>; Thu, 7 Nov 2002 22:47:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261583AbSKHDrg>; Thu, 7 Nov 2002 22:47:36 -0500
Received: from holomorphy.com ([66.224.33.161]:55463 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S261582AbSKHDrg>;
	Thu, 7 Nov 2002 22:47:36 -0500
Date: Thu, 7 Nov 2002 19:51:02 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: "Van Maren, Kevin" <kevin.vanmaren@unisys.com>
Cc: linux-ia64@linuxia64.org, linux-kernel@vger.kernel.org,
       rusty@rustcorp.com.au, dhowells@redhat.com, mingo@elte.hu,
       torvalds@transmeta.com
Subject: Re: [Linux-ia64] reader-writer livelock problem
Message-ID: <20021108035102.GA22031@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"Van Maren, Kevin" <kevin.vanmaren@unisys.com>,
	linux-ia64@linuxia64.org, linux-kernel@vger.kernel.org,
	rusty@rustcorp.com.au, dhowells@redhat.com, mingo@elte.hu,
	torvalds@transmeta.com
References: <3FAD1088D4556046AEC48D80B47B478C0101F4E7@usslc-exch-4.slc.unisys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FAD1088D4556046AEC48D80B47B478C0101F4E7@usslc-exch-4.slc.unisys.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 07, 2002 at 09:23:21PM -0600, Van Maren, Kevin wrote:
> This is a follow-up to the email thread I started on July 29th.
> See http://www.cs.helsinki.fi/linux/linux-kernel/2002-30/0446.html
> and the following discussion on LKML.
> I'll summarize the problem again to refresh the issue.
> Again, this is a correctness issue, not a performance one.
> I am seeing a problem on medium-sized SMPs where user programs are
> able to livelock the Linux kernel to such an extent that the
> system appears dead.  With the help of some hardware debugging
> tools, I was able to determine that the problem is caused by
> the reader-preference reader/writer locks in the Linux kernel.

This is a very serious problem which I have also encountered. My
strategy was to make the readers on the tasklist_lock more well-behaved,
and with Ingo's help and co-authorship those changes were cleaned up,
tuned to provide performance benefits for smaller systems, bugfixed,
and incorporated in the kernel. They have at least provided 16x systems
in my lab with much more stability. The issues are still triggerable on
32x systems in my lab, to which I do not have regular access.

Rusty, Dave, Ingo, and Linus cc:'d for additional commentary/help.

Bill
