Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261373AbVDMPr1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261373AbVDMPr1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 11:47:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261303AbVDMPr1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 11:47:27 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:36081 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S261373AbVDMPqy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 11:46:54 -0400
Subject: RE: FUSYN and RT
From: Steven Rostedt <rostedt@goodmis.org>
To: dwalker@mvista.com
Cc: mingo@elte.hu, linux-kernel@vger.kernel.org,
       "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>,
       Esben Nielsen <simlo@phys.au.dk>
In-Reply-To: <1113352069.6388.39.camel@dhcp153.mvista.com>
References: <Pine.OSF.4.05.10504130056271.6111-100000@da410.phys.au.dk>
	 <1113352069.6388.39.camel@dhcp153.mvista.com>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Wed, 13 Apr 2005 11:46:40 -0400
Message-Id: <1113407200.4294.25.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-04-12 at 17:27 -0700, Daniel Walker wrote:
> There is a great big snag in my assumptions. It's possible for a process
> to hold a fusyn lock, then block on an RT lock. In that situation you
> could have a high priority user space process be scheduled then block on
> the same fusyn lock but the PI wouldn't be fully transitive , plus there
> will be problems when the RT mutex tries to restore the priority. 
> 
> We could add simple hooks to force the RT mutex to fix up it's PI, but
> it's not a long term solution.

How hard would it be to use the RT mutex PI for the priority inheritance
for fusyn?  I only work with the RT mutex now and haven't looked at the
fusyn.  Maybe Ingo can make a separate PI system with its own API that
both the fusyn and RT mutex can use. This way the fusyn locks can still
be separate from the RT mutex locks but still work together. 

Basically can the fusyn work with the rt_mutex_waiter?  That's what I
would pull into its own subsystem.  Have another structure that would
reside in both the fusyn and RT mutex that would take over for the
current rt_mutex that is used in pi_setprio and task_blocks_on_lock in
rt.c.  So if both locks used the same PI system, then this should all be
cleared up. 

If this doesn't makes sense, or just confusing, I'll explain more :-)  

-- Steve


