Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265470AbTBJWZO>; Mon, 10 Feb 2003 17:25:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265477AbTBJWZN>; Mon, 10 Feb 2003 17:25:13 -0500
Received: from fmr02.intel.com ([192.55.52.25]:6885 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id <S265470AbTBJWZK> convert rfc822-to-8bit; Mon, 10 Feb 2003 17:25:10 -0500
content-class: urn:content-classes:message
Subject: Re: [FWD: NAT counting]
Date: Mon, 10 Feb 2003 14:34:53 -0800
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Message-ID: <DD755978BA8283409FB0087C39132BD1A07CC8@fmsmsx404.fm.intel.com>
Content-Transfer-Encoding: 7BIT
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
X-MimeOLE: Produced By Microsoft Exchange V6.0.6334.0
Thread-Topic: Re: [FWD: NAT counting]
Thread-Index: AcLRVKqke2I8Og+TRyi5f3kiAlhfjA==
From: "Luck, Tony" <tony.luck@intel.com>
To: <linux-kernel@vger.kernel.org>
Cc: <laforge@gnumonks.org>
X-OriginalArrivalTime: 10 Feb 2003 22:34:53.0459 (UTC) FILETIME=[A15EAE30:01C2D154]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Linux is not 'being fixed', because I don't regard this as a bug - and
> only bugs need fixing.
> 
> I don't want to have the NAT code to _always_ rewrite the IP ID because
> of performance reasons.  I think we should leave the current behaviour
> and provide an _optional_ 'IPID' target for the mangle table.  So
> everybody who wants IP ID rewriting can use that target.

The fact that someone can deduce how many hosts are hidden behind
a NAT gateway may, or may not, be a bug ... depending on whether you
think that the NAT is supposed to keep this number a secret.  But there
is a real bug here too.  Suppose you have two hosts behind your NAT
that both have connections to the same host out in internet-land. And
further suppose that both those hosts have the same value for their
incrementing counter that they use for IPID.  And finally suppose that
they both send a fragmented packet to the same port on the same host.

If your NAT router isn't re-writing the IPID, can't the target host get
confused when it sees two fragments that have a source address from your
NAT machine, that have the same IPID ... but really don't belong together?

-Tony Luck  

