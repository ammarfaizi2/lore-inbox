Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932319AbWDUN5p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932319AbWDUN5p (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 09:57:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932317AbWDUN5p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 09:57:45 -0400
Received: from zombie.ncsc.mil ([144.51.88.131]:19386 "EHLO jazzdrum.ncsc.mil")
	by vger.kernel.org with ESMTP id S932315AbWDUN5o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 09:57:44 -0400
Subject: Re: [RFC][PATCH 11/11] security: AppArmor - Export
	namespace	semaphore
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Linda A. Walsh" <law@tlinx.org>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>,
       linux-security-module@vger.kernel.org, chrisw@sous-sol.org,
       linux-kernel@vger.kernel.org, Tony Jones <tonyj@suse.de>
In-Reply-To: <44480727.9010500@tlinx.org>
References: <20060419174905.29149.67649.sendpatchset@ermintrude.int.wirex.com>
	 <20060419175034.29149.94306.sendpatchset@ermintrude.int.wirex.com>
	 <1145536742.16456.35.camel@moss-spartans.epoch.ncsc.mil>
	 <20060420124647.GD18604@sergelap.austin.ibm.com>
	 <1145534735.3313.3.camel@moss-spartans.epoch.ncsc.mil>
	 <20060420132128.GG18604@sergelap.austin.ibm.com>
	 <1145537318.3313.40.camel@moss-spartans.epoch.ncsc.mil>
	 <44480727.9010500@tlinx.org>
Content-Type: text/plain
Organization: National Security Agency
Date: Fri, 21 Apr 2006 10:02:02 -0400
Message-Id: <1145628122.21749.129.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-04-20 at 15:11 -0700, Linda A. Walsh wrote:
>     The *current* accepted way to get pathnames going into system
> calls is to trap the syscall vector as audit currently does --
> a method subject to race conditions.  There is no way to implement
> pathname-based security (or auditing) without providing hooks
> in each of the relevant system calls after they have copied their
> arguments from user space, safely into kernel space.  Decoding
> the arguments (including copying them from user space) twice allows
> for a window during which the user-space arguments can still be
> changed by a user-level process.  You can't copy the arguments from
> userspace, twice, and expect that the userspace memory will be
> remain the same between the two "copies".

They aren't being copied twice.  Look at getname() in fs/namei.c, and
note the call to audit_getname().  The native Linux 2.6 audit framework
combines processing at entry/exit with certain hooks placed at key
locations to collect the necessary information, without requiring the
degree of invasiveness of the SGI CAPP auditing patches of long ago.

-- 
Stephen Smalley
National Security Agency

