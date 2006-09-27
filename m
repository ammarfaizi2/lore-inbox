Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031130AbWI0WLJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031130AbWI0WLJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 18:11:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031133AbWI0WLJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 18:11:09 -0400
Received: from atlrel7.hp.com ([156.153.255.213]:8833 "EHLO atlrel7.hp.com")
	by vger.kernel.org with ESMTP id S1031130AbWI0WLF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 18:11:05 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Keith Owens <kaos@sgi.com>
Subject: Re: KDB blindly reads keyboard port
Date: Wed, 27 Sep 2006 16:11:00 -0600
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
References: <5239.1159325150@kao2.melbourne.sgi.com>
In-Reply-To: <5239.1159325150@kao2.melbourne.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609271611.00701.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 26 September 2006 20:45, Keith Owens wrote:
> No support for legacy I/O ports could be a bigger problem than just
> KDB.

On Itanium (and I suppose on x86), ACPI theoretically tells us enough
that we don't need to assume any legacy resources.  Of course, Linux
doesn't listen to everything ACPI is trying to tell it.  But that's
a Linux deficiency we should remedy.

> To fix just KDB, apply this patch over kdb-v4.4-2.6.18-common-1 and
> add 'kdb_skip_keyboard' to the boot command line on the offending
> hardware. 

This doesn't feel like the right solution.  Since firmware tells us
whether the device is present, I think we should rely on that.  If
you want to use the device before ACPI is initialized, *then* you
should pass a "kdb_use_keyboard" sort of flag.

Bjorn
