Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964967AbVHSPKJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964967AbVHSPKJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 11:10:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964986AbVHSPKJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 11:10:09 -0400
Received: from rgminet04.oracle.com ([148.87.122.33]:27542 "EHLO
	rgminet04.oracle.com") by vger.kernel.org with ESMTP
	id S964984AbVHSPKH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 11:10:07 -0400
Date: Fri, 19 Aug 2005 08:09:35 -0700
From: Joel Becker <Joel.Becker@oracle.com>
To: David Teigland <teigland@redhat.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, mark.fasheh@oracle.com
Subject: Re: [PATCH] configfs: export config_group_find_obj
Message-ID: <20050819150935.GD18991@ca-server1.us.oracle.com>
Mail-Followup-To: David Teigland <teigland@redhat.com>, akpm@osdl.org,
	linux-kernel@vger.kernel.org, mark.fasheh@oracle.com
References: <20050818062602.GD10133@redhat.com> <20050818211749.GD22742@insight> <20050818212022.GE22742@insight>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050818212022.GE22742@insight>
User-Agent: Mutt/1.5.10i
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 18, 2005 at 02:20:23PM -0700, Joel Becker wrote:
> On Thu, Aug 18, 2005 at 02:17:49PM -0700, Joel Becker wrote:
> > On Thu, Aug 18, 2005 at 02:26:02PM +0800, David Teigland wrote:
> > > In the dlm I use config_group_find_obj() which isn't exported.
> > 
> > 	Did you notice the /* XXX Locking */?  Let me go see how you use
> > it, if it is the best way, we'll need to revisit the function and be
> > sure it's happy.
> 
> 	Yeah, your usage is unsafe, but the fault lies with find_obj().
> Needs fixing.

	And you copied the same issue into get_comm().  When navigating
cg_children (or any part of the object tree), you need to be holding the
subsystem semaphore.  Someone could race with mkdir/rmdir.

Joel


-- 

"Senator let's be sincere,
 As much as you can."

			http://www.jlbec.org/
			jlbec@evilplan.org

