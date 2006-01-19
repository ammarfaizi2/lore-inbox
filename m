Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422663AbWASWNT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422663AbWASWNT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 17:13:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422662AbWASWNT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 17:13:19 -0500
Received: from mx.pathscale.com ([64.160.42.68]:37521 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1422663AbWASWNR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 17:13:17 -0500
Subject: Re: RFC: ipath ioctls and their replacements
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@osdl.org>, Roland Dreier <rdreier@cisco.com>,
       linux-kernel@vger.kernel.org, Greg Kroah-Hartman <greg@kroah.com>,
       openib-general@openib.org, "David S. Miller" <davem@davemloft.net>
In-Reply-To: <m1slrkneqq.fsf@ebiederm.dsl.xmission.com>
References: <1137631411.4757.218.camel@serpentine.pathscale.com>
	 <m1y81cpqt8.fsf@ebiederm.dsl.xmission.com>
	 <1137688158.3693.29.camel@serpentine.pathscale.com>
	 <m1hd80oz9b.fsf@ebiederm.dsl.xmission.com>
	 <1137696611.3693.63.camel@serpentine.pathscale.com>
	 <m1slrkneqq.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain
Organization: PathScale, Inc.
Date: Thu, 19 Jan 2006 14:13:11 -0800
Message-Id: <1137708791.3693.111.camel@serpentine.pathscale.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-01-19 at 13:29 -0700, Eric W. Biederman wrote:

> Agreed. Part of the problem is the IB layer is insufficient, or
> at least you perceive it that way.  At that level if you can express
> your problems we can get the IB layer fixed.

Our low-level driver is not IB, doesn't implement IB, and doesn't care
about IB.  Our upper-level driver implements IB, and interfaces to the
existing IB tree.

> Except not being a member of the IB verbs camp there is nothing
> your hardware does that is exotic enough for the IB layer to
> fall down.

We implement IB verbs just fine, both in the kernel and userspace.

> 1) The IB stack poorly supports your driver.
>    - IB stack problem.  If you could help point out what
>      is wrong with the IB stack that would be great.

I have no issue with it.  We already act as a provider to it, in our
higher-layer driver code.

We have some user page pinning code that is clearly similar in purpose,
and that I want to refactor in a helpful way.

We have UD and RC protocol engines that could profitably be moved out of
our driver and into the IB layer at some future point in time, should
some other device ever come along that could use them.

> For those who need the buzz words to understand what is going
> on the ipath hardware largely does stateless offload for IB while
> the mellanox hardware does whole protocol offload.

Our hardware actually does no offload whatsoever.  That's why we are (a)
fast (b) flexible and (c) somewhat big and unusual compared to other IB
drivers.

	<b

