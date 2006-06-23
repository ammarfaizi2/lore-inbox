Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752126AbWFWWWq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752126AbWFWWWq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 18:22:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752128AbWFWWWp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 18:22:45 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:56751 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1752126AbWFWWWp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 18:22:45 -0400
Date: Fri, 23 Jun 2006 23:22:43 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Section mismatch warnings
Message-ID: <20060623222243.GB27946@ftp.linux.org.uk>
References: <Pine.LNX.4.61.0606231938080.26864@yvahk01.tjqt.qr> <20060623221217.GA372@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060623221217.GA372@mars.ravnborg.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 24, 2006 at 12:12:18AM +0200, Sam Ravnborg wrote:
> On Fri, Jun 23, 2006 at 07:40:12PM +0200, Jan Engelhardt wrote:
> > Hello,
> > 
> > 
> > as others have already seen to, 2.6.17 spits out a lot of section mismatch 
> > warnings on modpost. Some of them have may already been addressed; here is 
> > the output I get when MODPOST starts to run during the compile process of 
> > an almost-completely-compiled kernel. Need .config?
> 
> All the .smp_locks related warnings are gone when I get the kbuild.git
> tree pushed linus wise. Needs to spend only an hour or so before it is
> ready and will do so during the weekend.

BTW, I've also got some modpost.c patches dealing with false positives
(as well as fixes for real crap).  modpost.c delta follows, just in case
if some of that might be missing from your tree

>From nobody Mon Sep 17 00:00:00 2001
From: Al Viro <viro@zeniv.linux.org.uk>
Date: Wed, 14 Jun 2006 13:05:12 -0400
Subject: [PATCH] kill some false positives from modpost

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 scripts/mod/modpost.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

919db28eefd21a9c9f7d790c9f37694bad3a0b9a
diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 0b92ddf..cd94d6a 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -768,6 +768,8 @@ static int init_section_ref_ok(const cha
 		".pci_fixup_final",
 		".pdr",
 		"__param",
+		"__ex_table",
+		".fixup",
 		NULL
 	};
 	/* Start of section names */
@@ -793,6 +795,8 @@ static int init_section_ref_ok(const cha
 	for (s = namelist3; *s; s++)
 		if (strstr(name, *s) != NULL)
 			return 1;
+	if (strrcmp(name, ".init") == 0)
+		return 1;
 	return 0;
 }
 
@@ -837,6 +841,8 @@ static int exit_section_ref_ok(const cha
 		".exitcall.exit",
 		".eh_frame",
 		".stab",
+		"__ex_table",
+		".fixup",
 		NULL
 	};
 	/* Start of section names */
-- 
1.3.GIT

