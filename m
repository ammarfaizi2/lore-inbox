Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262000AbVEEJLS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262000AbVEEJLS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 May 2005 05:11:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262008AbVEEJLS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 May 2005 05:11:18 -0400
Received: from casper2.cs.uct.ac.za ([137.158.96.99]:60927 "EHLO
	casper2.cs.uct.ac.za") by vger.kernel.org with ESMTP
	id S262003AbVEEJLE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 May 2005 05:11:04 -0400
Date: Thu, 5 May 2005 11:11:31 +0200
To: linux-kernel@vger.kernel.org
Subject: Holding ref to /proc/<pid> dentry prevents task being freed
Message-ID: <20050505091131.GA4472@omnius.cs.uct.ac.za>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
From: bmerry@cs.uct.ac.za
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Please CC me on replies. I'm not subscribed to LKML]

Hi

I'm busy writing a security module that does some very basic ACL stuff
on a per-task basis. If my module obtains and holds a dentry for
/proc/<pid> (via path_lookup), then the task_free_security hook is
never called for that process. Since the module releases the dentry in
task_free_security, this creates a chicken-and-egg problem and neither
the task nor the dentry is ever released. A side-effect is that the
module refcount never drops to 0.

Perhaps the LSM framework needs a hook for a task exiting (transition
to zombie state), in addition to the task_free_security hook? That
would allow resources to be freed from zombies, including these types
of circular references.

Thanks
Bruce

[Please CC me on replies. I'm not subscribed to LKML]
-- 
/--------------------------------------------------------------------\
| Bruce Merry                      | bmerry at cs . uct . ac . za    |
| Proud user of Gentoo GNU/Linux   | http://www.cs.uct.ac.za/~bmerry |
|        Despite the high cost of living, it remains popular.        |
\--------------------------------------------------------------------/
