Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266120AbUA1RJW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jan 2004 12:09:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266130AbUA1RJW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jan 2004 12:09:22 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:58320 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S266120AbUA1RI5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jan 2004 12:08:57 -0500
Date: Wed, 28 Jan 2004 17:08:28 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Tim Hockin <thockin@hockin.org>
cc: Andrew Morton <akpm@osdl.org>, <thockin@sun.com>, <torvalds@osdl.org>,
       <linux-kernel@vger.kernel.org>, <rusty@rustcorp.com.au>
Subject: Re: NGROUPS 2.6.2rc2
In-Reply-To: <20040128010222.GA32323@hockin.org>
Message-ID: <Pine.LNX.4.44.0401281706040.6069-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Jan 2004, Tim Hockin wrote:
> On Tue, Jan 27, 2004 at 04:46:15PM -0800, Andrew Morton wrote:
> > +
> > +	if (info->ngroups > TASK_SIZE/sizeof(group))
> > +		return -EFAULT;
> > +	if (!access_ok(VERIFY_WRITE, grouplist, info->ngroups * sizeof(group)))
> > +		return -EFAULT;
> > 
> > Why are many functions playing with TASK_SIZE?
> 
> Not sure - I thought it was maybe a paranoid check, Rusty included it in his
> version of a similar patch a while ago.

Yes, a necessary paranoid check: without it, info->ngroups * sizeof(group)
can easily wrap to something small, and access_ok pass when it should fail.

Hugh

