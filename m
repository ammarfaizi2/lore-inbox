Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266648AbUBQWq1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 17:46:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266660AbUBQWq1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 17:46:27 -0500
Received: from 209-166-240-202.cust.walrus.com ([209.166.240.202]:36307 "EHLO
	ti3.telemetry-investments.com") by vger.kernel.org with ESMTP
	id S266650AbUBQWqX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 17:46:23 -0500
Date: Tue, 17 Feb 2004 17:46:04 -0500
From: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>
To: Rik van Riel <riel@redhat.com>
Cc: Miklos Szeredi <mszeredi@inf.bme.hu>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
Subject: Re: [RFC] [PATCH] allowing user mounts
Message-ID: <20040217224604.GD6189@ti19.telemetry-investments.com>
Mail-Followup-To: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>,
	Rik van Riel <riel@redhat.com>, Miklos Szeredi <mszeredi@inf.bme.hu>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <200402171000.i1HA00U29578@kempelen.iit.bme.hu> <Pine.LNX.4.44.0402171657070.25294-100000@chimarrao.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0402171657070.25294-100000@chimarrao.boston.redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 17, 2004 at 04:59:25PM -0500, Rik van Riel wrote:
> You'll notice that /bin/mount already is a suid application,
> so you could just add your functionality there, or write your
> own suid mount application.
> 
> As an added bonus, you'd be able to have a more flexible
> configuration framework then what would ever be accepted
> into the kernel, without needing to go through the effort
> of getting anything merged into the kernel.
 
True, but one  generally wants to avoid suid tools that are visible
inside of CLONE_NS environment.  Ideally, one uses per-vfsmount
ro,nodev,nosuid for mounts within such an environment.

How does mount(8) access its configuration information from within the
namespace?  That requires that part of the private namespace be secured,
which is a non-trivial limitation, if one wants to, e.g., grant the
vserver administrator full privileges.

Alternatively, one might run a mount server within the environment.
That's certainly doable with existing infrastructure.

Regards,

	Bill Rugolsky

