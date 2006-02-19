Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750756AbWBSV1u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750756AbWBSV1u (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Feb 2006 16:27:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750830AbWBSV1u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Feb 2006 16:27:50 -0500
Received: from smtp1.pp.htv.fi ([213.243.153.37]:52456 "EHLO smtp1.pp.htv.fi")
	by vger.kernel.org with ESMTP id S1750756AbWBSV1u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Feb 2006 16:27:50 -0500
Date: Sun, 19 Feb 2006 23:27:48 +0200
From: Paul Mundt <lethal@linux-sh.org>
To: Dave Jones <davej@redhat.com>
Cc: Greg KH <greg@kroah.com>, Christoph Hellwig <hch@infradead.org>,
       zanussi@us.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] relay: Migrate from relayfs to a generic relay API.
Message-ID: <20060219212748.GA4690@linux-sh.org>
Mail-Followup-To: Paul Mundt <lethal@linux-sh.org>,
	Dave Jones <davej@redhat.com>, Greg KH <greg@kroah.com>,
	Christoph Hellwig <hch@infradead.org>, zanussi@us.ibm.com,
	linux-kernel@vger.kernel.org
References: <20060219210733.GA3682@linux-sh.org> <20060219212122.GA7974@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060219212122.GA7974@redhat.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 19, 2006 at 04:21:22PM -0500, Dave Jones wrote:
> On Sun, Feb 19, 2006 at 11:07:33PM +0200, Paul Mundt wrote:
>  > This is a small patch set for getting rid of relayfs, and moving the core of
>  > its functionality to kernel/relay.c. The API is kept consistent for everything
>  > but the relayfs-specific bits, meaning people will have to use other file
>  > systems to implement relay channel buffers.
> 
> What about the userspace visible API for things already using relayfs,
> like systemtap ?  Whilst technically these patches may make sense,
> yanking the rug underneath applications as soon as they've started
> using it without warning or a migration period doesn't sound too good an idea.
> 
Yes, that's why this is only done in the last two patches. The rest are
completely independent and don't interfere with the API (well, ok,
FIX_SIZE() needs to be dropped in fs/relayfs if it's fetching it from the
header, but that's it).

> It's taken us *years* to try and get rid of devfs, why should relayfs
> get ripped out any quicker, when it has valid users?
> 
I'm not advocating its removal, I'm more interested in using it from
sysfs and debugfs where it makes more sense. Splitting up CONFIG_RELAY
and CONFIG_RELAYFS_FS will allow for both, and it'll also be possible to
migrate the existing CONFIG_RELAYFS_FS code to use CONFIG_RELAY without
breaking the userspace APIs if we want to get rid of the duplication. The
only issue will be wrapping up the default callbacks, but that's a
trivial ifdef.
