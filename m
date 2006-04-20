Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932067AbWDTVuq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932067AbWDTVuq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 17:50:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751349AbWDTVuq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 17:50:46 -0400
Received: from ishtar.tlinx.org ([64.81.245.74]:20618 "EHLO ishtar.tlinx.org")
	by vger.kernel.org with ESMTP id S1751348AbWDTVup (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 17:50:45 -0400
Message-ID: <44480228.3060009@tlinx.org>
Date: Thu, 20 Apr 2006 14:50:32 -0700
From: Linda Walsh <lkml@tlinx.org>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Tony Jones <tonyj@suse.de>, linux-kernel@vger.kernel.org,
       chrisw@sous-sol.org, linux-security-module@vger.kernel.org
Subject: Re: [RFC][PATCH 11/11] security: AppArmor - Export namespace	semaphore
References: <20060419174905.29149.67649.sendpatchset@ermintrude.int.wirex.com>	 <20060419175034.29149.94306.sendpatchset@ermintrude.int.wirex.com> <1145536742.16456.35.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1145536742.16456.35.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Stephen Smalley wrote:
> The alternative I would recommend is to not use LSM. It isn't suitable
> for your path-based approach.  If your path-based approach is deemed
> legitimate, then introduce new hooks at the proper point in processing
> where the information you need is available.
>   
---
    I thought LSM was supposed to provide the hooks to allow virtually
any access control scheme to be implemented?  I've seen complaints
before on either here or the LSM list that one of the hurdles for
"legitimacy" was whether or not it fit on top of the current set of
LSM hooks.  I also saw it asked whether or not LSM had been
designed around, primarily, the needs of SELinux and if it was
going to remain so.  If it was, then why not remove all non-SELinux
hooks?  If LSM is to support alternate security methods, it is
logical to believe that LSM was not implemented with calls to
support every desired security model people might want.  There
are known, insecure, race conditions in linux auditing, for
example, due to lack of LSM hooks.  This was a conscious
design decision made by the LSM majority over objections
of people who wanted greater flexibility to support security
mechanisms not supportable with the current set of hooks.

    In regards to "legitimacy", while I share the reservations
of many people in using a path based approach to security, I
might point out that this model is a basic one integrated into
Windows NT (XP & later, 2k?).  That doesn't mean it is "good",
but it certainly should add some weight to the claim of
"legitimacy".  I.e. - it provides a "comfortable", known
security mechanism for people switching to Linux servers from
from "Windows Server 2003".

    In the Windows approach, you can specify allowed and disallowed
paths by unique name and using wildcards.  This allowed/disallowed
hash is checked before every program execution.

    If you start with a large, multi-user system, and allow no
user-level mounts (they just sign in and can pick from a
limited menu of choices, the pathname approach can have some
merit.  For example, one might have a security policy only
allowing execution of binaries in "/usr/bin".  The employer
puts all of his "reservation-system" or "database-access" routines
in "/usr/bin" (or adds the app path(s) to the allowed hash).  
The end users run the allowed binaries and that's it.

    I'm not saying it's an approach I would find useful to control
security on my systems, but I can see a potential usefulness
for it, in that it is relatively easy for people to understand,
setup and use.

Linda W

