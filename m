Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751245AbVJKU2M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751245AbVJKU2M (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 16:28:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751255AbVJKU2M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 16:28:12 -0400
Received: from smtp105.mail.sc5.yahoo.com ([66.163.169.225]:53397 "HELO
	smtp105.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1751245AbVJKU2L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 16:28:11 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.de;
  h=Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:User-Agent;
  b=RydlrJYwAtkJI7C8FbLrFpLWJ/RHZQN+lzQYFdK982LB6dlHW1om9h5mUsd9SVMAyH1pTtFBb5T66ujIDooKZL6vPS53uXAweWQb6plKsPDCNkGXVyjFHnZGhBHT+LA2ojHgn7XPXNsPX5ZM+sFd1ELAbL9pu60gZGJIsEo4aGI=  ;
Date: Tue, 11 Oct 2005 16:54:54 +0200
From: Borislav Petkov <bbpetkov@yahoo.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, tgraf@suug.ch,
       pablo@eurodev.net
Subject: [was: Linux v2.6.14-rc4] fix textsearch build warning
Message-ID: <20051011145454.GA30786@gollum.tnic>
References: <Pine.LNX.4.64.0510101824130.14597@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0510101824130.14597@g5.osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 10, 2005 at 06:31:12PM -0700, Linus Torvalds wrote:
> 
> Here's the final -rc before a 2.6.14 release.
> 
> In the diffstat, most of the changes are one-liners, with the main 
> exceptions being some sparc64 work (fix user-space corruption due to FP 
> save/restore) and the new Megaraid SAS driver. There's some networking 
> fixes, and a couple of driver updates (scsi: aacraid, net: cassini, and 
> watchdog: pcwd_pci).
> 
> Along with a x86-64 suspend/resume page table corruption and some new 
> defconfig files for ARM, that rounds out the bigger chunks.
> 
> The shortlog (appended) should be a pretty good idea of the rest.

I get this when building 14-rc4:

lib/ts_kmp.c:125: warning: initialization from incompatible pointer type
lib/ts_bm.c:165: warning: initialization from incompatible pointer type
lib/ts_fsm.c:318: warning: initialization from incompatible pointer type

The following trivial patch fixes it.

Signed-off-by: Borislav Petkov <petkov@uni-muenster.de>


--- 14-rc4/include/linux/textsearch.h.orig	2005-10-11 16:36:16.000000000 +0200
+++ 14-rc4/include/linux/textsearch.h	2005-10-11 16:36:45.000000000 +0200
@@ -40,7 +40,7 @@ struct ts_state
 struct ts_ops
 {
 	const char		*name;
-	struct ts_config *	(*init)(const void *, unsigned int, int);
+	struct ts_config *	(*init)(const void *, unsigned int, gfp_t);
 	unsigned int		(*find)(struct ts_config *,
 					struct ts_state *);
 	void			(*destroy)(struct ts_config *);

	

	
		
___________________________________________________________ 
Gesendet von Yahoo! Mail - Jetzt mit 1GB Speicher kostenlos - Hier anmelden: http://mail.yahoo.de
