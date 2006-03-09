Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751907AbWCIXN1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751907AbWCIXN1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 18:13:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751888AbWCIXN1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 18:13:27 -0500
Received: from test-iport-1.cisco.com ([171.71.176.117]:54877 "EHLO
	test-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S1751907AbWCIXN0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 18:13:26 -0500
To: "Bryan O'Sullivan" <bos@pathscale.com>
Cc: rolandd@cisco.com, gregkh@suse.de, akpm@osdl.org, davem@davemloft.net,
       linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [PATCH 7 of 20] ipath - misc driver support code
X-Message-Flag: Warning: May contain useful information
References: <2f16f504dd4b98c2ce7c.1141922820@localhost.localdomain>
From: Roland Dreier <rdreier@cisco.com>
Date: Thu, 09 Mar 2006 15:13:24 -0800
In-Reply-To: <2f16f504dd4b98c2ce7c.1141922820@localhost.localdomain> (Bryan O'Sullivan's message of "Thu,  9 Mar 2006 08:47:00 -0800")
Message-ID: <adau0a7fbzf.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 09 Mar 2006 23:13:25.0463 (UTC) FILETIME=[1153BE70:01C643CF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > +/**
 > + * ipath_unordered_wc - indicate whether write combining is ordered
 > + *
 > + * Because our performance depends on our ability to do write combining mmio
 > + * writes in the most efficient way, we need to know if we are on an Intel
 > + * or AMD x86_64 processor.  AMD x86_64 processors flush WC buffers out in
 > + * the order completed, and so no special flushing is required to get
 > + * correct ordering.  Intel processors, however, will flush write buffers
 > + * out in "random" orders, and so explict ordering is needed at times.
 > + */
 > +int ipath_unordered_wc(void)
 > +{
 > +	return boot_cpu_data.x86_vendor == X86_VENDOR_INTEL;
 > +}

This is kind of theoritical, but it seems to me that it would be safer
to write this as

	int ipath_unordered_wc(void)
	{
		return boot_cpu_data.x86_vendor != X86_VENDOR_AMD;
	}

after all, Via is probably going to have an x86-64 CPU one of these
days, and I doubt you've checked that their WC flush is ordered.

 - R.
