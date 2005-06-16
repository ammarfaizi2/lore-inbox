Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261470AbVFPRPG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261470AbVFPRPG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Jun 2005 13:15:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261678AbVFPRPF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Jun 2005 13:15:05 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:7106 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261470AbVFPRO7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Jun 2005 13:14:59 -0400
Date: Thu, 16 Jun 2005 10:15:02 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: junjie cai <junjiec@gmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, shemminger@osdl.org
Subject: Re: is synchronize_net in inet_register_protosw necessary?
Message-ID: <20050616171502.GA1321@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <ca992f11050614071857cd069b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca992f11050614071857cd069b@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 14, 2005 at 11:18:08PM +0900, junjie cai wrote:
> hi all.
> i am a newbie to linux kernel.
> in a arm926 board i found that it took about 30ms to finish
> the (net/ipv4/af_inet.c:898) inet_register_protosw
> because of the synchronize_net call during profiling.
> synchronize_net finally calls synchronize_rcu, so i think
> this is to make the change visiable after a list_add_rcu.
> but according to the Document/listRCU.txt it seems that
> a list insertation does not necessarily do call_rcu etc.
> may i have any mistakes, please kindly tell me.

>From a strict RCU viewpoint, you are quite correct.  But sometimes
the overall locking protocol (which almost always includes other things
besides just RCU) places additional constraints on the code.  My guess is
that the networking folks needed to ensure that the new protocol is seen
by all packets that are received after inet_register_protosw() returns.

But I need to defer to networking guys on this one.

							Thanx, Paul
