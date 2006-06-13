Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932331AbWFMVg4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932331AbWFMVg4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 17:36:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932334AbWFMVg4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 17:36:56 -0400
Received: from mga03.intel.com ([143.182.124.21]:16154 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S932330AbWFMVgz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 17:36:55 -0400
X-IronPort-AV: i="4.06,128,1149490800"; 
   d="scan'208"; a="50489536:sNHT5828210143"
From: "Sean Hefty" <sean.hefty@intel.com>
To: "'Steve Wise'" <swise@opengridcomputing.com>,
       "Tom Tucker" <tom@opengridcomputing.com>
Cc: "Andrew Morton" <akpm@osdl.org>, <netdev@vger.kernel.org>,
       <rdreier@cisco.com>, <linux-kernel@vger.kernel.org>,
       <openib-general@openib.org>
Subject: RE: [openib-general] [PATCH v2 1/2] iWARP Connection Manager.
Date: Tue, 13 Jun 2006 14:36:46 -0700
Message-ID: <000001c68f31$78910fe0$24268686@amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
Thread-Index: AcaPKPmRQdErfavST2O0Lxl4DK7WagAByVPg
In-Reply-To: <1150230871.17394.68.camel@stevo-desktop>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2670
X-OriginalArrivalTime: 13 Jun 2006 21:36:46.0989 (UTC) FILETIME=[78D2D3D0:01C68F31]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Er...no. It will lose this event. Depending on the event...the carnage
>> varies. We'll take a look at this.
>>
>
>This behavior is consistent with the Infiniband CM (see
>drivers/infiniband/core/cm.c function cm_recv_handler()).  But I think
>we should at least log an error because a lost event will usually stall
>the rdma connection.

I believe that there's a difference here.  For the Infiniband CM, an allocation
error behaves the same as if the received MAD were lost or dropped.  Since MADs
are unreliable anyway, it's not so much that an IB CM event gets lost, as it
doesn't ever occur.  A remote CM should retry the send, which hopefully allows
the connection to make forward progress.

- Sean
