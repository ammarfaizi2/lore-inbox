Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263361AbTDLSQS (for <rfc822;willy@w.ods.org>); Sat, 12 Apr 2003 14:16:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263363AbTDLSQS (for <rfc822;linux-kernel-outgoing>);
	Sat, 12 Apr 2003 14:16:18 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:20494
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id S263361AbTDLSQR 
	(for <rfc822;linux-kernel@vger.kernel.org>); Sat, 12 Apr 2003 14:16:17 -0400
Subject: Re: 2.5.67: ppa driver & preempt == oops
From: Robert Love <rml@tech9.net>
To: Gert Vervoort <gert.vervoort@hccnet.nl>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3E982AAC.3060606@hccnet.nl>
References: <3E982AAC.3060606@hccnet.nl>
Content-Type: text/plain
Organization: 
Message-Id: <1050172083.2291.459.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 (1.2.4-2) 
Date: 12 Apr 2003 14:28:03 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-04-12 at 11:03, Gert Vervoort wrote:

> ppa: Version 2.07 (for Linux 2.4.x)
> ppa: Found device at ID 6, Attempting to use EPP 16 bit
> ppa: Communication established with ID 6 using EPP 16 bit

I guess you don't see these without kernel preemption?

These are not errors, just warnings.  Most likely you only see them when
CONFIG_PREEMPT is enabled, because otherwise the kernel cannot detect
them.  But they still happen.

Does anything go wrong?  Or just these errors?

It looks like one of the scsi command functions grabs a lock and then
does wait_for_completion.  I have not identified what lock, yet.  But
its a bug in the SCSI code if so, and unrelated to preemption.

	Robert Love

