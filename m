Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964983AbWILKVn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964983AbWILKVn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 06:21:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965148AbWILKVn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 06:21:43 -0400
Received: from smtp-out001.kontent.com ([81.88.40.215]:24732 "EHLO
	smtp-out.kontent.com") by vger.kernel.org with ESMTP
	id S964983AbWILKVm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 06:21:42 -0400
From: Oliver Neukum <oliver@neukum.org>
To: David Howells <dhowells@redhat.com>
Subject: Re: Uses for memory barriers
Date: Tue, 12 Sep 2006 12:22:00 +0200
User-Agent: KMail/1.8
Cc: paulmck@us.ibm.com, Alan Stern <stern@rowland.harvard.edu>,
       Kernel development list <linux-kernel@vger.kernel.org>
References: <20060911162059.GA1496@us.ibm.com> <Pine.LNX.4.44L0.0609082216070.8541-100000@netrider.rowland.org> <32145.1158051703@warthog.cambridge.redhat.com>
In-Reply-To: <32145.1158051703@warthog.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609121222.01260.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 12. September 2006 11:01 schrieb David Howells:
> Paul E. McKenney <paulmck@us.ibm.com> wrote:
> 
> > 2.	All stores to a given single memory location will be perceived
> > 	as having occurred in the same order by all CPUs.
> 
> Does that take into account a CPU combining or discarding coincident memory
> operations?
> 
> For instance, a CPU asked to issue two writes to the same location may discard
> the first if it hasn't done it yet.

Does it make sense? If you do:
mov #x, $a
wmb
mov #y, $b
wmb
mov #z, $a

The CPU must not discard any write. If you do

mov #x, $a
mov #y, $b
wmb
mov #z, $a

The first store to $a is superfluous if you have only inter-CPU
issues in mind.

	Regards
		Oliver
