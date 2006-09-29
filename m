Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030415AbWI2Ioi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030415AbWI2Ioi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 04:44:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030416AbWI2Ioi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 04:44:38 -0400
Received: from smtp.osdl.org ([65.172.181.4]:19097 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030415AbWI2Ioh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 04:44:37 -0400
Date: Fri, 29 Sep 2006 01:44:33 -0700
From: Andrew Morton <akpm@osdl.org>
To: Mark Lord <lkml@rtr.ca>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Arrr! Linux 2.6.18
Message-Id: <20060929014433.bc01e83c.akpm@osdl.org>
In-Reply-To: <451CDBE3.2080707@rtr.ca>
References: <Pine.LNX.4.64.0609192126070.4388@g5.osdl.org>
	<451CDBE3.2080707@rtr.ca>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Sep 2006 04:40:03 -0400
Mark Lord <lkml@rtr.ca> wrote:

> Linus Torvalds wrote:
> > ..
> > Cap'n Andrew Morton:
> >       Blimey! hvc_console suspend fix
> 
> Mmm.. I wonder if this could be what killed resume-from-RAM
> on my notebook, between -rc6 and -final ?
> 
> Andrew, can you send me just that one patch, and I'll try reverting it.
> 

From: Andrew Morton <akpm@osdl.org>

Fix http://bugzilla.kernel.org/show_bug.cgi?id=7152

Cc: Michael Tautschnig <tautschn@model.in.tum.de>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 drivers/char/hvc_console.c |    1 +
 1 file changed, 1 insertion(+)

diff -puN drivers/char/hvc_console.c~hvc_console-suspend-fix drivers/char/hvc_console.c
--- a/drivers/char/hvc_console.c~hvc_console-suspend-fix
+++ a/drivers/char/hvc_console.c
@@ -668,6 +668,7 @@ int khvcd(void *unused)
 	do {
 		poll_mask = 0;
 		hvc_kicked = 0;
+		try_to_freeze();
 		wmb();
 		if (cpus_empty(cpus_in_xmon)) {
 			spin_lock(&hvc_structs_lock);
_

