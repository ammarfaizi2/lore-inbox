Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932420AbWCJAwx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932420AbWCJAwx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 19:52:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932140AbWCJAww
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 19:52:52 -0500
Received: from test-iport-1.cisco.com ([171.71.176.117]:44622 "EHLO
	test-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S932420AbWCJAwu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 19:52:50 -0500
To: "Bryan O'Sullivan" <bos@pathscale.com>
Cc: rolandd@cisco.com, gregkh@suse.de, akpm@osdl.org, davem@davemloft.net,
       linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [PATCH 9 of 20] ipath - char devices for diagnostics and lightweight subnet management
X-Message-Flag: Warning: May contain useful information
References: <28bb276205de498d0b5c.1141950939@eng-12.pathscale.com>
	<adaslprcelg.fsf@cisco.com>
	<1141951622.10693.85.camel@serpentine.pathscale.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Thu, 09 Mar 2006 16:52:47 -0800
In-Reply-To: <1141951622.10693.85.camel@serpentine.pathscale.com> (Bryan O'Sullivan's message of "Thu, 09 Mar 2006 16:47:02 -0800")
Message-ID: <adaoe0fce8w.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 10 Mar 2006 00:52:49.0884 (UTC) FILETIME=[F46629C0:01C643DC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Bryan> It's read outside of this file, without a lock held.

I missed the other reference in another patch.  But the central point
still stands: if all you do is atomic_set() and atomic_read(), then
using atomic_t doesn't buy you anything.  Just look at what
atomic_read() expands to -- using it isn't protecting you against
anything, so either you have a race, or you were safe without
atomic_t.  The only point to atomic_t is so that you can safely do
read-modify-write things like atomic_inc().

 - R.
