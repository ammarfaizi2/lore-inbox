Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161444AbWASVwM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161444AbWASVwM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 16:52:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161446AbWASVwM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 16:52:12 -0500
Received: from mx.pathscale.com ([64.160.42.68]:34703 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1161444AbWASVwK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 16:52:10 -0500
Subject: Re: [openib-general] Re: RFC: ipath ioctls and their replacements
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: Sean Hefty <mshefty@ichips.intel.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@osdl.org>,
       Greg Kroah-Hartman <greg@kroah.com>, Roland Dreier <rdreier@cisco.com>,
       linux-kernel@vger.kernel.org, openib-general@openib.org,
       "David S. Miller" <davem@davemloft.net>
In-Reply-To: <43CFFFCB.7060002@ichips.intel.com>
References: <1137631411.4757.218.camel@serpentine.pathscale.com>
	 <m1y81cpqt8.fsf@ebiederm.dsl.xmission.com>
	 <1137688158.3693.29.camel@serpentine.pathscale.com>
	 <m1hd80oz9b.fsf@ebiederm.dsl.xmission.com>
	 <43CFDF5F.5060409@ichips.intel.com>
	 <1137696901.3693.66.camel@serpentine.pathscale.com>
	 <43CFFFCB.7060002@ichips.intel.com>
Content-Type: text/plain
Organization: PathScale, Inc.
Date: Thu, 19 Jan 2006 13:52:05 -0800
Message-Id: <1137707525.3693.95.camel@serpentine.pathscale.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-01-19 at 13:08 -0800, Sean Hefty wrote:

> I'm struggling to understand what your card does then.  From this, it sounds 
> like a standard network card that just happens to use IB physicals.

It has typical features of a standard network card, while also
supporting direct user access to the hardware.  We eschew the
offload-as-much-as-possible approach that other vendors take.

> Do you just send raw packets?

We certainly can do that.  The hardware doesn't need to do much more, in
fact.

> How is the LRH formatted by your card?  I.e. what's setting 
> up the dlid, slid, vl, etc.?

This is all done in software.  The low-level driver and hardware fill
out enough of the IB UD protocol headers to put packets on the wire that
an IB switch will route.  The higher-level layer is responsible for the
full IB protocol suite and the driver-side interfaces to the various
OpenIB userspace APIs.

>   Can your card interoperate with other IB devices 
> on the network when running in this mode?

Yes.  It can do both the low-level wonkery and regular IB at the same
time.

	<b

