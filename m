Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267521AbUIBFoD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267521AbUIBFoD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 01:44:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267520AbUIBFoC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 01:44:02 -0400
Received: from smtp110.mail.sc5.yahoo.com ([66.163.170.8]:17828 "HELO
	smtp110.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S267521AbUIBFnx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 01:43:53 -0400
Date: Wed, 1 Sep 2004 22:43:06 -0700
From: "David S. Miller" <davem@davemloft.net>
To: Andi Kleen <ak@suse.de>
Cc: vatsa@in.ibm.com, davem@redhat.com, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org, dipankar@in.ibm.com, paulmck@us.ibm.com
Subject: Re: [RFC] Use RCU for tcp_ehash lookup
Message-Id: <20040901224306.7dd80458.davem@davemloft.net>
In-Reply-To: <20040831135419.GA17642@wotan.suse.de>
References: <20040831125941.GA5534@in.ibm.com>
	<20040831135419.GA17642@wotan.suse.de>
Organization: DaveM Loft Enterprises
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Aug 2004 15:54:20 +0200
Andi Kleen <ak@suse.de> wrote:

> And it should also fix the performance problems with
> cat /proc/net/tcp on ppc64/ia64 for large hash tables because the rw locks 
> are gone.

Time to convert netstat et al. over the netlink too.

> > - I presume that one of the reasons for keeping the hash table so big is to
> >   keep lock contention low (& to reduce the size of hash chains). If the lookup
> >   is made lock-free, then could the size of the hash table be reduced (without
> >   adversely impacting performance)?
> 
> Definitely worth trying IMHO. The current hash tables are far
> too big. I would do that as followon patches though.

The hashes are big to make the hash effective, not to help the locking
contention.
