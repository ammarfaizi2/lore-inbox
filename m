Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261987AbUDHQ5M (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 12:57:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262005AbUDHQ5M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 12:57:12 -0400
Received: from facesaver.epoch.ncsc.mil ([144.51.25.10]:44501 "EHLO
	epoch.ncsc.mil") by vger.kernel.org with ESMTP id S261987AbUDHQ5J
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 12:57:09 -0400
Subject: Re: capwrap: granting capabilities without fs support
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Andy Lutomirski <luto@myrealbox.com>
Cc: Neil Schemenauer <nas@arctrix.com>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <40755CAC.60502@myrealbox.com>
References: <fa.g8lp2iv.1vlsqhp@ifi.uio.no>  <40755CAC.60502@myrealbox.com>
Content-Type: text/plain
Organization: National Security Agency
Message-Id: <1081443414.6379.164.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Thu, 08 Apr 2004 12:56:54 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-04-08 at 10:07, Andy Lutomirski wrote:
> When I have time (hopefully real soon now), I'll post a patch to actually fix 
> capabilities.  With that patch, this can be a trivial wrapper script instead of 
> a kernel module.  Note that this could be _very_ dangerous if glibc does the 
> wrong thing (I don't know whether it does, though).

The security_bprm_secureexec hook can be used to cause the AT_SECURE
flag to be set in the ELF auxiliary table, and glibc now uses that flag
to determine whether to enable secure mode.  You would need to patch
cap_bprm_secureexec to do the right thing, but otherwise the support is
ready.  SELinux uses this to enable glibc secure mode for role/domain
changes.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

