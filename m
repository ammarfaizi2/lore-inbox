Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750827AbWADV1E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750827AbWADV1E (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 16:27:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750871AbWADV1E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 16:27:04 -0500
Received: from sj-iport-2-in.cisco.com ([171.71.176.71]:22197 "EHLO
	sj-iport-2.cisco.com") by vger.kernel.org with ESMTP
	id S1750827AbWADV1D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 16:27:03 -0500
To: ebiederm@xmission.com (Eric W. Biederman)
Cc: "Bryan O'Sullivan" <bos@pathscale.com>, Greg KH <greg@kroah.com>,
       linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [PATCH 0 of 20] [RFC] ipath - PathScale InfiniPath driver
X-Message-Flag: Warning: May contain useful information
References: <patchbomb.1135816279@eng-12.pathscale.com>
	<20051230080002.GA7438@kroah.com>
	<1135984304.13318.50.camel@serpentine.pathscale.com>
	<20051231001051.GB20314@kroah.com>
	<1135993250.13318.94.camel@serpentine.pathscale.com>
	<m1irt25pxg.fsf@ebiederm.dsl.xmission.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Wed, 04 Jan 2006 13:26:55 -0800
In-Reply-To: <m1irt25pxg.fsf@ebiederm.dsl.xmission.com> (Eric W. Biederman's
 message of "Mon, 02 Jan 2006 13:35:07 -0700")
Message-ID: <adawthf4rc0.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.17 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
X-OriginalArrivalTime: 04 Jan 2006 21:26:56.0644 (UTC) FILETIME=[96DB5440:01C61175]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Eric> Given Linus's comments and looking at where you are getting
    Eric> stuck I would recommend you split out support for the
    Eric> nonstandard ipath protocol from the rest of the driver.  If
    Eric> the standard infiniband interfaces for kernel bypass are not
    Eric> sufficient for flinging packets then we need to re-examine
    Eric> them.

Yes, this might be a good idea.  The "core" driver looks like it is
suffering from really being several things stuck together.  It would
probably make things a lot cleaner and easier to maintain if the core
driver just handled synchronizing access to the low-level hardware,
with other stuff split into its own driver.  It seems there might even
be enough stuff to split "core" into three drivers: the real core, the
ultra-high-performance MPI transport, and the management/diagnostitcs
stuff.

Also, there are APIs in the "core" driver that are only exported for a
single user outside the driver -- it would probably make sense to move
that logic directly to where it's used.  I'm thinking of things like
ipath_verbs_send() and the whole ipath_copy.c file.

 - R.
