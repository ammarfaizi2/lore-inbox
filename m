Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932282AbWDURot@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932282AbWDURot (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 13:44:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932297AbWDURot
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 13:44:49 -0400
Received: from hera.kernel.org ([140.211.167.34]:58325 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S932282AbWDURos (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 13:44:48 -0400
To: linux-kernel@vger.kernel.org
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [patch 05/22] : Fix hotplug race during device registration
Date: Fri, 21 Apr 2006 10:44:33 -0700
Organization: OSDL
Message-ID: <20060421104433.0ff85977@localhost.localdomain>
References: <4448DC4C.6010500@ums.usu.ru>
	<20060421135219.37720.qmail@web52901.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Trace: build.pdx.osdl.net 1145641473 2274 10.8.0.54 (21 Apr 2006 17:44:33 GMT)
X-Complaints-To: abuse@osdl.org
NNTP-Posting-Date: Fri, 21 Apr 2006 17:44:33 +0000 (UTC)
X-Newsreader: Sylpheed-Claws 2.0.0 (GTK+ 2.8.6; i486-pc-linux-gnu)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Apr 2006 14:52:19 +0100 (BST)
Chris Rankin <rankincj@yahoo.com> wrote:

> --- "Alexander E. Patrakov" <patrakov@ums.usu.ru> wrote:
> > Look at the old code again. This is not a new bug. The old code fails 
> > registration, does a printk, and then sets dev->reg_state = NETREG_REGISTERED. 
> 
> OK, fair enough. But anyway, is it valid to leave reg_state as NETREG_REGISTERED when the
> registration has failed?

Yes. the device is still half alive in that case. It is accessible via normal networking
calls, and can be unregistered. It just would not show up properly in sysfs.

Not sure how it would be possible (except maybe out of memory) to construct a case
where registration fails. Maybe races with name changes.
