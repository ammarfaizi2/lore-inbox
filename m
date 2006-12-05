Return-Path: <linux-kernel-owner+willy=40w.ods.org-S968395AbWLEQEZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968395AbWLEQEZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 11:04:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968393AbWLEQEZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 11:04:25 -0500
Received: from relay.2ka.mipt.ru ([194.85.82.65]:58917 "EHLO 2ka.mipt.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S967997AbWLEQEY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 11:04:24 -0500
Date: Tue, 5 Dec 2006 18:59:32 +0300
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Steve Wise <swise@opengridcomputing.com>
Cc: Roland Dreier <rdreier@cisco.com>, netdev@vger.kernel.org,
       openib-general@openib.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH  v2 04/13] Connection Manager
Message-ID: <20061205155932.GA32380@2ka.mipt.ru>
References: <20061202224917.27014.15424.stgit@dell3.ogc.int> <20061202224958.27014.65970.stgit@dell3.ogc.int> <20061204110825.GA26251@2ka.mipt.ru> <ada8xhnk6kv.fsf@cisco.com> <20061205050725.GA26033@2ka.mipt.ru> <1165330925.16087.13.camel@stevo-desktop> <20061205151905.GA18275@2ka.mipt.ru> <1165333198.16087.53.camel@stevo-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <1165333198.16087.53.camel@stevo-desktop>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Tue, 05 Dec 2006 18:59:39 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 05, 2006 at 09:39:58AM -0600, Steve Wise (swise@opengridcomputing.com) wrote:
> > Phrases like "MPA-aware TCP" rises a lot of questions - briefly saying
> > that hardware (even if it is called ethernet driver) can create and work
> > with own TCP flows potentially modified in the way it likes which is seen 
> > in driver. Likely such flows will not be seen by upper layers like OS 
> > network stack according to hardware descriptions.
> > 
> > Is it correct?
> > 
> 
> I don't quite get your point about the driver aspect of this?
> 
> The HW manages the iWARP connection including data flow.  It adheres to
> the MPA, RDDP, and RDMAP protocol specification IDs from the IETF.  The
> HW manages how data gets pushed out in the RDMA stream.   The RDMA
> Driver just requests a TCP connection and does the MPA exchange.  Then
> tells the hardware to move the connection into RDMA mode.  From that
> point on, the driver simply suffles IO work requests from the consumer
> application to the hardware and handles asynchronous events while the
> connection is up and running.

My main concern about this is the fact, that protocol handling is
splitted into SF and HW parts, and actually until negotiation is
completed those parts are completely unrelated to each other, so
requested TCP connection can leak into main stack and main stack can
send some packets which can be considered as MPA negotiation.

> Steve.

-- 
	Evgeniy Polyakov
