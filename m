Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262844AbUJ1G0u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262844AbUJ1G0u (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 02:26:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262857AbUJ1G0u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 02:26:50 -0400
Received: from smtp3.akamai.com ([63.116.109.25]:55963 "EHLO smtp3.akamai.com")
	by vger.kernel.org with ESMTP id S262844AbUJ1GQH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 02:16:07 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: rcv_wnd = init_cwnd*mss
Date: Wed, 27 Oct 2004 23:15:48 -0700
Message-ID: <DB2C167D8FFDEA45B8FC0B1B75E3EE154A3B08@usca1ex-priv1.sanmateo.corp.akamai.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: rcv_wnd = init_cwnd*mss
Thread-Index: AcS8rx0lII4RnMC0R0WeBsZWJg685QABCWEw
From: "Meda, Prasanna" <pmeda@akamai.com>
To: "David S. Miller" <davem@davemloft.net>
Cc: <linux-kernel@vger.kernel.org>, <netdev@oss.sgi.com>, <davem@redhat.com>
X-OriginalArrivalTime: 28 Oct 2004 06:15:48.0916 (UTC) FILETIME=[917C4740:01C4BCB5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> From: David S. Miller [mailto:davem@davemloft.net]
> Sent: Wednesday, October 27, 2004 10:21 PM
> To: Meda, Prasanna
> Cc: linux-kernel@vger.kernel.org; netdev@oss.sgi.com; davem@redhat.com
> Subject: Re: rcv_wnd = init_cwnd*mss
>
>
> On Wed, 27 Oct 2004 22:14:33 -0700
> "Meda, Prasanna" <pmeda@akamai.com> wrote:
>
> > 
> > What is the reason for checking mss with 1<<rcv_wscale?
> > include/net/tcp.h:

> Because the advertised window field is 16-bits.  It is
> interpreted as "value << rcv_wscale"

Thanks, still it is unclear to me why are we
downsizing the advertised window(rcv_wnd) to cwnd? 
To defeat disobeying sender, or something like below?

Suppose when wscale is zero, it is now checking mss > 1,
and perhaps the intention was to check mss > rcv_wnd,
where mss is greater than advertised, and we still
want to advertise window to spwan 2 to 4 cwnd packets.

And also in the following line,
if (*rcv_wscale && sysctl_tcp_app_win && space>=mss &&
                    space - max((space>>sysctl_tcp_app_win), mss>>*rcv_wscale) <
65536/2)

space is actual_space>>rcv_wscale, mss is actual value.
Why are we checking space>=mss, which are in different
scales? The second line is doing max on space and mss 
on same scales, and looks right.


Thanks,
Prasanna.
