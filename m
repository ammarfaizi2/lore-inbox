Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262153AbUDEMOf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 08:14:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262170AbUDEMOf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 08:14:35 -0400
Received: from [144.51.25.10] ([144.51.25.10]:20621 "EHLO epoch.ncsc.mil")
	by vger.kernel.org with ESMTP id S262153AbUDEMOd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 08:14:33 -0400
Subject: Re: disable-cap-mlock
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Andrew Morton <akpm@osdl.org>
Cc: Chris Wright <chrisw@osdl.org>, andrea@suse.de,
       lkml <linux-kernel@vger.kernel.org>, kenneth.w.chen@intel.com
In-Reply-To: <20040402133540.1dfa0256.akpm@osdl.org>
References: <20040401135920.GF18585@dualathlon.random>
	 <20040401170705.Y22989@build.pdx.osdl.net>
	 <20040401173034.16e79fee.akpm@osdl.org>
	 <20040402133540.1dfa0256.akpm@osdl.org>
Content-Type: text/plain
Organization: National Security Agency
Message-Id: <1081167231.5343.13.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Mon, 05 Apr 2004 08:13:51 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-04-02 at 16:35, Andrew Morton wrote:
> Particularly as, apparently, the new security stuff STILL cannot solve the
> extremely simple Oracle-wants-CAP_IPC_LOCK requirement.

Actually, it can.  With SELinux enabled, you run oracle as uid 0 in a TE
domain that is allowed to use CAP_IPC_LOCK (e.g. allow oracle_t
self:capability ipc_lock;) and no other capabilities, and you are done. 
Naturally, you would need to define a domain for oracle.  uid 0 has no
special significance to SELinux; it is only required to satisfy the
secondary module you stack with SELinux, i.e. dummy or capabilities, and
the ability to use capabilities is controlled by the TE policy.  

Or, if you want to drop the need to use uid 0 entirely, you unhook the
secondary_ops from SELinux so that SELinux alone makes the capability
decisions.  But that will require finer tuning of the policy
configuration.

None of this is to argue against fixing the base capability logic, just
to note that SELinux can control capability usage.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

