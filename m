Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265821AbUATXN1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 18:13:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265830AbUATXN1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 18:13:27 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:4600 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S265821AbUATXNW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 18:13:22 -0500
Message-ID: <400DB46D.67E852D9@us.ibm.com>
Date: Tue, 20 Jan 2004 15:06:21 -0800
From: Jim Keniston <jkenisto@us.ibm.com>
X-Mailer: Mozilla 4.75 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Rask Ingemann Lambertsen <rask@sygehus.dk>
CC: LKML <linux-kernel@vger.kernel.org>, netdev <netdev@oss.sgi.com>,
       Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@osdl.org>,
       "Feldman, Scott" <scott.feldman@intel.com>,
       Larry Kessler <kessler@us.ibm.com>
Subject: Re: [PATCH 2.6.1] Net device error logging
References: <400C3D3E.BFCC25CE@us.ibm.com> <20040120195122.A1087@sygehus.dk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rask Ingemann Lambertsen wrote:
> 
> On Mon, Jan 19, 2004 at 12:25:34PM -0800, Jim Keniston wrote:
> > The enclosed patch implements the netdev_* error-logging macros for
> > network drivers.  These macros have been discussed at length on the
> > linux-kernel and linux-netdev lists.  All issues that reviewers have
> > raised were addressed previously.  This is just an update for v2.6.1.
> 
> How about a message rate limit?
> 
> --
> Regards,
> Rask Ingemann Lambertsen

Thanks.  We considered adding a ratelimit flag to the netdev_printk arg
list.  It was pointed out that
(1) rate-limiting is necessary for a relatively small subset of messages;
and
(2) the NETIF_MSG_* flags are already designed to be used in order of
increasing verbosity.  If the user selects the more verbose class of
messages, then rate-limiting may not be appropriate.

I concluded that ratelimit() should continue to be used on a case-by-case
basis, and not folded into netdev_printk.

Jim Keniston
