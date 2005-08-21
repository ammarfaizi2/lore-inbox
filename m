Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750762AbVHUCDQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750762AbVHUCDQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Aug 2005 22:03:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750763AbVHUCDQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Aug 2005 22:03:16 -0400
Received: from ylpvm29-ext.prodigy.net ([207.115.57.60]:7808 "EHLO
	ylpvm29.prodigy.net") by vger.kernel.org with ESMTP
	id S1750762AbVHUCDQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Aug 2005 22:03:16 -0400
X-ORBL: [63.205.185.3]
Date: Sat, 20 Aug 2005 19:03:06 -0700
From: Chris Wedgwood <cw@f00f.org>
To: linux-kernel@vger.kernel.org
Cc: staubach@redhat.com, Andrew Morton <akpm@osdl.org>
Subject: Re: largefile-support-for-accounting.patch added to -mm tree
Message-ID: <20050821020306.GA17353@taniwha.stupidest.org>
References: <200508210034.j7L0YoH1003173@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200508210034.j7L0YoH1003173@shell0.pdx.osdl.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 20, 2005 at 05:33:27PM -0700, akpm@osdl.org wrote:

> Another annoying problem is that once the system reaches this 2GB
> limit, then every process which exits will receive a signal,
> SIGXFSZ.  This signal is generated because an attempt was made to
> write beyond the limit for the file descriptor.  This signal makes
> it look like every process has exited due to a signal, when in fact,
> they have not.

Eeek.

> The solution is to add the O_LARGEFILE flag to the list of flags
> used to open the accounting file.  The rest of the accounting
> support is already largefile safe.

That fixes the larger accounting file problem but it doesn't address
the fact that signals resulting writes to the accounting file are
delivered incorrectly.

We could still have issues if the accounting file as over quota for
example.  Surely all accounting file writes should be insulated from
the processes involved?

