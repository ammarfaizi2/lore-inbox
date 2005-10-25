Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932277AbVJYR7L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932277AbVJYR7L (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Oct 2005 13:59:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932279AbVJYR7K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Oct 2005 13:59:10 -0400
Received: from smtp.osdl.org ([65.172.181.4]:18136 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932277AbVJYR7I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Oct 2005 13:59:08 -0400
Date: Tue, 25 Oct 2005 10:57:03 -0700
From: Andrew Morton <akpm@osdl.org>
To: Badari Pulavarty <pbadari@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       andrew.vasquez@qlogic.com
Subject: Re: 2.6.14-rc5-mm1
Message-Id: <20051025105703.07288224.akpm@osdl.org>
In-Reply-To: <1130253176.6831.48.camel@localhost.localdomain>
References: <20051024014838.0dd491bb.akpm@osdl.org>
	<1130186927.6831.23.camel@localhost.localdomain>
	<20051024141646.6265c0da.akpm@osdl.org>
	<1130253176.6831.48.camel@localhost.localdomain>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Badari Pulavarty <pbadari@gmail.com> wrote:
>
> On Mon, 2005-10-24 at 14:16 -0700, Andrew Morton wrote:
> ..
> > 
> > qla2x00_probe_one() has called qla2x00_free_device() and
> > qla2x00_free_device() has locked up in
> > wait_for_completion(&ha->dpc_exited);
> > 
> > Presumably, ha->dpc_exited is not initialised yet.
> > 
> > The first `goto probe_failed' in qla2x00_probe_one() will cause
> > qla2x00_free_device() to run wait_for_completion() against an uninitialised
> > completion struct.  Because ha->dpc_pid will be >= 0.
> > 
> > This patch might fix the lockup, but if so, qla2x00_iospace_config()
> > failed.  Please debug that a bit for us?
> 
> Yes. This patch helped. Due to power failures, my disk trays are
> powered off. qla2x00_iospace_config() is failing and causing the
> panic on -mm kernel. For odd reasons, older -mm kernels & mainline
> kernels doesn't panic.

OK, thanks.  Andrew seems offline and this patch is sufficiently obvious
that I think I'll just jam it into 2.6.14...
