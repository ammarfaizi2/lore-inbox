Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750949AbWDTNfS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750949AbWDTNfS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 09:35:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750952AbWDTNfS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 09:35:18 -0400
Received: from mummy.ncsc.mil ([144.51.88.129]:15270 "EHLO jazzhorn.ncsc.mil")
	by vger.kernel.org with ESMTP id S1750949AbWDTNfR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 09:35:17 -0400
Subject: Re: [RESEND][RFC][PATCH 2/7] implementation of LSM hooks
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: Valdis.Kletnieks@vt.edu, casey@schaufler-ca.com,
       James Morris <jmorris@namei.org>, linux-security-module@vger.kernel.org,
       linux-kernel@vger.kernel.org, fireflier-devel@lists.sourceforge.net
In-Reply-To: <32851499-DA27-46AF-A1A4-E668BBE0771D@mac.com>
References: <20060419014857.35628.qmail@web36606.mail.mud.yahoo.com>
	 <CD11FD59-4E2E-4AD7-9DD0-5811CE792B24@mac.com>
	 <200604190656.k3J6uSGW010288@turing-police.cc.vt.edu>
	 <32851499-DA27-46AF-A1A4-E668BBE0771D@mac.com>
Content-Type: text/plain
Organization: National Security Agency
Date: Thu, 20 Apr 2006 08:40:03 -0400
Message-Id: <1145536803.3313.32.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-04-20 at 02:51 -0400, Kyle Moffett wrote:
> On Apr 19, 2006, at 02:56:28, Valdis.Kletnieks@vt.edu wrote:
> > On Wed, 19 Apr 2006 02:40:25 EDT, Kyle Moffett said:
> >> Perhaps the SELinux model should be extended to handle (dir-inode,  
> >> path-entry) pairs.  For example, if I want to protect the /etc/ 
> >> shadow file regardless of what tool is used to safely modify it, I  
> >> would set
> >
> > Some of us think that the tools can protect /etc/shadow just fine  
> > on their own, and are concerned with rogue software that abuses / 
> > etc/shadow without bothering to safely modify it..
> 
> Here I'm talking about using SELinux to protect /etc/shadow both  
> before _and_ after it's edited with vipw.  A tool like vipw does creat 
> () write() rename() to overwrite the /etc/shadow file, so any SELinux  
> system relying _only_ on inode is guaranteed to break.

To clarify:
- SELinux kernel access controls are configured by policy to ensure that
only approved tools can manipulate the file (based on inode attribute,
initially established at install time),
- SELinux kernel labeling mechanism for new inodes is configured by
policy to ensure that new files created by such tools are labeled with
the most restrictive label (i.e. the one for shadow, not passwd data) by
default, so that we don't leak information accidentally,
- Approved tools/libraries are instrumented to specify the desired label
for passwd vs. shadow (and backup files), since the same code re-creates
both on a transaction (at least when adding/removing users), so the
kernel can't make that distinction automatically; only the tool knows
that.  This is consistent with how DAC mode is handled for passwd vs.
shadow. 

No pathname-based mechanism in the kernel required, or desired.  Names
are meaningless to real security properties.

-- 
Stephen Smalley
National Security Agency

