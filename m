Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262274AbTH3XUH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Aug 2003 19:20:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262258AbTH3XUH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Aug 2003 19:20:07 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:35339
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S262257AbTH3XUC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Aug 2003 19:20:02 -0400
Date: Sat, 30 Aug 2003 16:20:03 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: OOps in 2.6.0-test4-mm3-1
Message-ID: <20030830232003.GB898@matchmail.com>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
References: <20030828235649.61074690.akpm@osdl.org> <20030830014309.GA898@matchmail.com> <20030829200926.3e2b7eb6.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030829200926.3e2b7eb6.akpm@osdl.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 29, 2003 at 08:09:26PM -0700, Andrew Morton wrote:
> Mike Fedyk <mfedyk@matchmail.com> wrote:
> >
> > It's vanilla mm3-1 with this one patch added from Neil Brown.  I don't think
> > it has anything to do with it (it looks like a driver issue to me).  But it
> > can't hurt to mention it.

> Some drivers such as aha1542 and aic7xxx_old will call scsi_register() and
> then, if some succeeding operations fails they will call scsi_unregister(),
> without an intervening scsi_set_host().
> 
> This causes an oops in scsi_put_device(), because kobj->parent is NULL.
> 
> In other words, scsi_register() immediately followed by scsi_unregister()
> is guaranteed to oops.
> 
> The patch makes scsi_host_dev_release() more robust against this usage
> pattern.

Ok, I'll give that patch a try.  Though, is there any reason why
2.6.0-test2-mm1 doesn't oops too?  (that was the previous kernel on that
machine)
