Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267516AbUG2R3T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267516AbUG2R3T (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 13:29:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267475AbUG2R1Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 13:27:16 -0400
Received: from holomorphy.com ([207.189.100.168]:30613 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S264833AbUG2RXR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 13:23:17 -0400
Date: Thu, 29 Jul 2004 10:23:05 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Avi Kivity <avi@exanet.com>, jmoyer@redhat.com, suparna@in.ibm.com,
       linux-aio@kvack.org, linux-kernel@vger.kernel.org, linux-osdl@osdl.org
Subject: Re: [PATCH 20/22] AIO poll
Message-ID: <20040729172305.GT2334@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Arjan van de Ven <arjanv@redhat.com>, Avi Kivity <avi@exanet.com>,
	jmoyer@redhat.com, suparna@in.ibm.com, linux-aio@kvack.org,
	linux-kernel@vger.kernel.org, linux-osdl@osdl.org
References: <20040702130030.GA4256@in.ibm.com> <20040702163946.GJ3450@in.ibm.com> <16649.5485.651481.534569@segfault.boston.redhat.com> <41091FAA.6080409@exanet.com> <1091117766.2792.14.camel@laptop.fenrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1091117766.2792.14.camel@laptop.fenrus.com>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-07-29 at 18:02, Avi Kivity wrote:
>> I second the motion. I don't see how one can write a server which uses 
>> both networking and block aio without aio poll.

On Thu, Jul 29, 2004 at 06:16:07PM +0200, Arjan van de Ven wrote:
> one could try to use epoll and fix it to be usable for disk io too ;)

That notion doesn't make any sense. epoll is just a continuation-based
implementation of a recurring readiness notification operation. Extant
async I/O operations (in mainline) are data transfer. The inclusion
goes the other direction. Readiness notification can be modeled as a
kind of data transfer by synthesizing a data stream to represent the
readiness transitions, but the reverse fails as data can't become
ready to consume (what epoll would like to report) until I/O is
initiated. epoll is suited to become a recurring aio readiness
notification operation. Vice-versa is literally so logically
inconsistent it can't even be phrased properly.

I'll send in some code to deal with this properly later on today. New
polling infrastructures should not be erected, but rather existing
epoll code reused for continuation-based readiness notification.


-- wli
