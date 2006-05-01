Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932198AbWEAT2o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932198AbWEAT2o (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 15:28:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932199AbWEAT2o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 15:28:44 -0400
Received: from sj-iport-3-in.cisco.com ([171.71.176.72]:30258 "EHLO
	sj-iport-3.cisco.com") by vger.kernel.org with ESMTP
	id S932198AbWEAT2n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 15:28:43 -0400
X-IronPort-AV: i="4.04,169,1144047600"; 
   d="scan'208"; a="425826173:sNHT29952366"
To: Arjan van de Ven <arjan@infradead.org>
Cc: "Bryan O'Sullivan" <bos@pathscale.com>, openib-general@openib.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5 of 13] ipath - use proper address translation routine
X-Message-Flag: Warning: May contain useful information
References: <1ab168913f0fea5d18b4.1145913781@eng-12.pathscale.com>
	<ada3bftvatf.fsf@cisco.com>
	<1146509646.20760.63.camel@laptopd505.fenrus.org>
	<aday7xltvtb.fsf@cisco.com>
	<1146511201.20760.65.camel@laptopd505.fenrus.org>
From: Roland Dreier <rdreier@cisco.com>
Date: Mon, 01 May 2006 12:28:41 -0700
In-Reply-To: <1146511201.20760.65.camel@laptopd505.fenrus.org> (Arjan van de Ven's message of "Mon, 01 May 2006 21:20:00 +0200")
Message-ID: <adaaca1tuhi.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 01 May 2006 19:28:42.0825 (UTC) FILETIME=[74F13390:01C66D55]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Arjan> sounds like you need to redesign your layering ;) In linux
    Arjan> it's common to have the lowest level driver do the mapping
    Arjan> (even when the mid layer will provide the most commonly
    Arjan> used helper to do it for the common case)...

It's not that simple of course...

InfiniBand allows RDMA -- _remote_ DMA.  So that address might be
something that a protocol sent to the remote host and which is now
showing up for a DMA operation initiated by the remote side.  And we
can't very well send a struct page * + offset to the remote side...
