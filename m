Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263058AbUDASsO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 13:48:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263061AbUDASsO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 13:48:14 -0500
Received: from facesaver.epoch.ncsc.mil ([144.51.25.10]:14237 "EHLO
	epoch.ncsc.mil") by vger.kernel.org with ESMTP id S263058AbUDASsK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 13:48:10 -0500
Subject: Re: disable-cap-mlock
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Marc-Christian Petersen <m.c.p@wolk-project.de>,
       lkml <linux-kernel@vger.kernel.org>, Andrea Arcangeli <andrea@suse.de>,
       Andrew Morton <akpm@osdl.org>, kenneth.w.chen@intel.com,
       Chris Wright <chrisw@osdl.org>
In-Reply-To: <20040401175436.GI791@holomorphy.com>
References: <20040401135920.GF18585@dualathlon.random>
	 <1080841071.25431.155.camel@moss-spartans.epoch.ncsc.mil>
	 <20040401174405.GG791@holomorphy.com> <200404011952.29724@WOLK>
	 <20040401175436.GI791@holomorphy.com>
Content-Type: text/plain
Organization: National Security Agency
Message-Id: <1080845238.25431.196.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Thu, 01 Apr 2004 13:47:18 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-04-01 at 12:54, William Lee Irwin III wrote:
> On Thu, Apr 01, 2004 at 07:52:29PM +0200, Marc-Christian Petersen wrote:
> > hmm, maybe a /proc/sys/capability/lock and if set to 1 you can't
> > change any of the sysctl variables, even root should not be allowed
> > to change lock back, until you do a reboot. Practical?
> > ciao, Marc
> 
> Feasible, though it's an open question as to how many hoops we should
> jump through to prevent people from shooting themselves in the foot.
> 
> Maybe Steven could recommend adjustments and/or give some idea as to
> whether the above would be useful.

Some form of control over changing the sysctl settings (beyond just the
mode) should be provided; otherwise, the module is too unsafe by itself
for real use, and you can't assume that people will only use it stacked
with SELinux (which could control such changes).  Allowing the settings
to be locked as mcp suggested sounds simple and sufficient for the
proposed use; they can disable their desired capability and then lock in
/sbin/init.  For greater generality, I'd suggest adding a new capability
to control the ability to set the capability sysctls, but then we are in
a vicious cycle...

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

