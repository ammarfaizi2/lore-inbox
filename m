Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261168AbVDMRel@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261168AbVDMRel (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 13:34:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261169AbVDMRel
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 13:34:41 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:62702 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261168AbVDMReh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 13:34:37 -0400
Subject: RE: FUSYN and RT
From: Daniel Walker <dwalker@mvista.com>
Reply-To: dwalker@mvista.com
To: Steven Rostedt <rostedt@goodmis.org>
Cc: mingo@elte.hu, linux-kernel@vger.kernel.org,
       "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>,
       Esben Nielsen <simlo@phys.au.dk>
In-Reply-To: <1113407200.4294.25.camel@localhost.localdomain>
References: <Pine.OSF.4.05.10504130056271.6111-100000@da410.phys.au.dk>
	 <1113352069.6388.39.camel@dhcp153.mvista.com>
	 <1113407200.4294.25.camel@localhost.localdomain>
Content-Type: text/plain
Organization: MontaVista
Message-Id: <1113413613.8183.15.camel@dhcp153.mvista.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 13 Apr 2005 10:33:33 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-04-13 at 08:46, Steven Rostedt wrote:
> How hard would it be to use the RT mutex PI for the priority inheritance
> for fusyn?  I only work with the RT mutex now and haven't looked at the
> fusyn.  Maybe Ingo can make a separate PI system with its own API that
> both the fusyn and RT mutex can use. This way the fusyn locks can still
> be separate from the RT mutex locks but still work together. 
> 
> Basically can the fusyn work with the rt_mutex_waiter?  That's what I
> would pull into its own subsystem.  Have another structure that would
> reside in both the fusyn and RT mutex that would take over for the
> current rt_mutex that is used in pi_setprio and task_blocks_on_lock in
> rt.c.  So if both locks used the same PI system, then this should all be
> cleared up. 
> 
> If this doesn't makes sense, or just confusing, I'll explain more :-)  

I've thought about this as an option, but when I first started this
thread It seemed like the two could work independently, and safely which
doesn't appear to be the case any more.

The problems with pulling out the PI in the RT mutex are that
pi_setprio() does a walk over lock->owner and we're got two different
lock structures now . I was thinking we could add something like
lock_ops (get_owner(), wait_list_add(), wait_list_del(), ?? ) to
rt_mutex_waiter, or abstract rt_lock. Then pi_setprio would just use the
lock_ops instead of accessing a structure .. 

I've only gone over the Fusyn code briefly , so I'm assuming all this
could be added.  I think it's a safe assumption though .

Daniel

