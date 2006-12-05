Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1760096AbWLEPCK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760096AbWLEPCK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 10:02:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759904AbWLEPCJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 10:02:09 -0500
Received: from rrcs-24-153-217-226.sw.biz.rr.com ([24.153.217.226]:49628 "EHLO
	smtp.opengridcomputing.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760096AbWLEPCH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 10:02:07 -0500
Subject: Re: [PATCH  v2 04/13] Connection Manager
From: Steve Wise <swise@opengridcomputing.com>
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc: Roland Dreier <rdreier@cisco.com>, netdev@vger.kernel.org,
       openib-general@openib.org, linux-kernel@vger.kernel.org
In-Reply-To: <20061205050725.GA26033@2ka.mipt.ru>
References: <20061202224917.27014.15424.stgit@dell3.ogc.int>
	 <20061202224958.27014.65970.stgit@dell3.ogc.int>
	 <20061204110825.GA26251@2ka.mipt.ru> <ada8xhnk6kv.fsf@cisco.com>
	 <20061205050725.GA26033@2ka.mipt.ru>
Content-Type: text/plain
Date: Tue, 05 Dec 2006 09:02:05 -0600
Message-Id: <1165330925.16087.13.camel@stevo-desktop>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-12-05 at 08:07 +0300, Evgeniy Polyakov wrote:
> On Mon, Dec 04, 2006 at 07:45:52AM -0800, Roland Dreier (rdreier@cisco.com) wrote:
> >  > This and a lot of other changes in this driver definitely says you
> >  > implement your own stack of protocols on top of infiniband hardware.
> > 
> > ...but I do know this driver is for 10-gig ethernet HW.
> 
> It is for iwarp/rdma from description.
> If it is 10ge, then why does it parse incomping packet headers and
> implements initial tcp state machine?
> 

Its not implementing the TCP state machine at all. Its implementing the
MPA state machine (see the iWARP internet drafts).  These packets are
TCP payload.  MPA is used to negotiate RDMA mode on a TCP connection.
This entails an exchange of 2 messages on the TCP connection.  Once this
is exchanged and both side agree, the connection is bound to an RDMA QP
and the connection moved into RDMA mode.  From that point on, all IO is
done via the post_send() and post_recv().


Steve. 


