Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965057AbWJJHEK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965057AbWJJHEK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 03:04:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965060AbWJJHEJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 03:04:09 -0400
Received: from ozlabs.org ([203.10.76.45]:23230 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S965059AbWJJHEI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 03:04:08 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17707.17886.823268.538399@cargo.ozlabs.ibm.com>
Date: Tue, 10 Oct 2006 17:03:58 +1000
From: Paul Mackerras <paulus@samba.org>
To: Andrew Morton <akpm@osdl.org>
Cc: greg@kroah.com, linux-kernel@vger.kernel.org
Subject: Re: Why is device_create_file __must_check?
In-Reply-To: <20061009222641.96c4acb5.akpm@osdl.org>
References: <17707.8801.395100.35054@cargo.ozlabs.ibm.com>
	<20061009214936.a2788702.akpm@osdl.org>
	<17707.11292.661824.337474@cargo.ozlabs.ibm.com>
	<20061009222641.96c4acb5.akpm@osdl.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton writes:

> > So we have to add printks in all sorts of places where the
> > device_create_file has never failed before.  If you're that concerned,
> 
> aren't you concerned too?

Not about the ones that have shown no sign of failing, no...

Most of the sites I have looked at have been cases where the kernel
genuinely doesn't care whether the device_create_file call succeeded
or failed.  Adding an if and printk in all these places seems like
pointless bloat when it could be done in one place - namely
device_create_file.  In one or two cases the return value from
device_create_file can be returned as its caller's return value, but
these were the minority.  In no cases that I have looked at was there
any other suitable action to take.

> > why not add a WARN_ON(error) in device_create_file() ?
> 
> That might be suitable, yup.

Greg claims that people ignore WARN_ON messages.  If that's true, I
fail to see how adding printks will help.

Paul.
