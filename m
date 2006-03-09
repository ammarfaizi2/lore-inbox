Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932156AbWCIXtz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932156AbWCIXtz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 18:49:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752085AbWCIXtz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 18:49:55 -0500
Received: from mx.pathscale.com ([64.160.42.68]:39560 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1752082AbWCIXtz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 18:49:55 -0500
Subject: Re: [PATCH 9 of 20] ipath - char devices for diagnostics and
	lightweight subnet management
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: Roland Dreier <rdreier@cisco.com>
Cc: rolandd@cisco.com, gregkh@suse.de, akpm@osdl.org, davem@davemloft.net,
       linux-kernel@vger.kernel.org, openib-general@openib.org
In-Reply-To: <adad5gvfbhe.fsf@cisco.com>
References: <eac2ad3017b5f160d24c.1141922822@localhost.localdomain>
	 <adad5gvfbhe.fsf@cisco.com>
Content-Type: text/plain
Organization: PathScale, Inc.
Date: Thu, 09 Mar 2006 15:49:49 -0800
Message-Id: <1141948189.10693.48.camel@serpentine.pathscale.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-03-09 at 15:24 -0800, Roland Dreier wrote:

> It seems there's a window here where two processes can both pass the
> if (ipath_sma_alive) test and then proceed to step on each other.

Yep, this is a real race, albeit incredibly unlikely.  I just turned
ipath_sma_alive into an atomic_t, and wrapped the open/close code in
spinlocks.

	<b

