Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932405AbWAFNgy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932405AbWAFNgy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 08:36:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932403AbWAFNgy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 08:36:54 -0500
Received: from [81.2.110.250] ([81.2.110.250]:5312 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S932379AbWAFNgx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 08:36:53 -0500
Subject: Re: [PATCH, RFC] RCU : OOM avoidance and lower latency
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Eric Dumazet <dada1@cosmosbay.com>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       "David S. Miller" <davem@davemloft.net>,
       Dipankar Sarma <dipankar@in.ibm.com>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       Manfred Spraul <manfred@colorfullife.com>, netdev@vger.kernel.org
In-Reply-To: <43BE43B6.3010105@cosmosbay.com>
References: <20060105235845.967478000@sorel.sous-sol.org>
	 <20060106004555.GD25207@sorel.sous-sol.org>
	 <Pine.LNX.4.64.0601051727070.3169@g5.osdl.org>
	 <43BE43B6.3010105@cosmosbay.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 06 Jan 2006 13:37:12 +0000
Message-Id: <1136554632.30498.7.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2006-01-06 at 11:17 +0100, Eric Dumazet wrote:
> I assume that if a CPU queued 10.000 items in its RCU queue, then the oldest 
> entry cannot still be in use by another CPU. This might sounds as a violation 
> of RCU rules, (I'm not an RCU expert) but seems quite reasonable.

Fixing the real problem in the routing code would be the real fix. 

The underlying problem of RCU and memory usage could be solved more
safely by making sure that the sleeping memory allocator path always
waits until at least one RCU cleanup has occurred after it fails an
allocation before it starts trying harder. That ought to also naturally
throttle memory consumers more in the situation which is the right
behaviour.

Alan
