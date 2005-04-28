Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262165AbVD1Qmu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262165AbVD1Qmu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 12:42:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262167AbVD1Qmt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 12:42:49 -0400
Received: from gate.in-addr.de ([212.8.193.158]:42368 "EHLO mx.in-addr.de")
	by vger.kernel.org with ESMTP id S262165AbVD1Qma (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 12:42:30 -0400
Date: Thu, 28 Apr 2005 18:42:21 +0200
From: Lars Marowsky-Bree <lmb@suse.de>
To: David Teigland <teigland@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] dlm: overview
Message-ID: <20050428164221.GE21645@marowsky-bree.de>
References: <20050425151136.GA6826@redhat.com> <20050425203952.GE25002@ca-server1.us.oracle.com> <20050425210915.GX32085@marowsky-bree.de> <200504260130.17016.phillips@istop.com> <20050427135635.GA4431@marowsky-bree.de> <20050428162552.GH10628@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050428162552.GH10628@redhat.com>
X-Ctuhulu: HASTUR
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2005-04-29T00:25:52, David Teigland <teigland@redhat.com> wrote:

> On Wed, Apr 27, 2005 at 03:56:35PM +0200, Lars Marowsky-Bree wrote:
> 
> > Questions which need to be settled, or which the API at least needs to
> > export so we know what is expected from us:
> 
> Here's what the dlm takes from userspace:
> 
> - Each lockspace takes a list of nodeid's that are the current members
>   of that lockspace.  Nodeid's are int's.  For lockspace "alpha", it looks
>   like this:
>   echo "1 2 3 4" > /sys/kernel/dlm/alpha/members
> 
> - The dlm comms code needs to map these nodeid's to real IP addresses.
>   A simple ioctl on a dlm char device passes in nodeid/sockaddr pairs.
>   e.g. dlm_tool set_node 1 10.0.0.1
>   to tell the dlm that nodeid 1 has IP address 10.0.0.1
> 
> - To suspend the lockspace you'd do (and similar for resuming):
>   echo 1 > /sys/kernel/dlm/alpha/stop

Ohhh. _NEAT!_ Simple. Me like simple. This will work just perfectly well
with our current approach (well, with some minor adjustments on our side
for the mapping table).

I assume that we're allowed to update the nodeid/sockaddr mapping while
suspended too? ie, if we were to reassign the nodeid to some other
node...?

We can drive this almost directly and completely with a simple plugin.

> In other words, these aren't external API's; they're internal interfaces
> within systems that happen to be split between the kernel and user-space.

Okay, understood. So the boundary is within user-space.


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
High Availability & Clustering
SUSE Labs, Research and Development
SUSE LINUX Products GmbH - A Novell Business

