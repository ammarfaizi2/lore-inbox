Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262008AbVFQQSY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262008AbVFQQSY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Jun 2005 12:18:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262010AbVFQQSX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Jun 2005 12:18:23 -0400
Received: from mtagate2.de.ibm.com ([195.212.29.151]:62142 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP id S262008AbVFQQSU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Jun 2005 12:18:20 -0400
Subject: Re: [PATCH 1/1] SELinux: memory leak in selinux_sb_copy_data()
From: Gerald Schaefer <geraldsc@de.ibm.com>
Reply-To: geraldsc@de.ibm.com
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: akpm@osdl.org, jmorris@redhat.com, schwidefsky@de.ibm.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <1119023825.15306.30.camel@moss-spartans.epoch.ncsc.mil>
References: <1119014283.7006.58.camel@thinkpad>
	 <1119023249.7006.71.camel@thinkpad>
	 <1119023825.15306.30.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Fri, 17 Jun 2005 18:18:16 +0200
Message-Id: <1119025096.7006.83.camel@thinkpad>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-06-17 at 11:57 -0400, Stephen Smalley wrote:
> 
> Shouldn't that be nosec_save?  nosec is advanced by take_option().
> 
That's right, I muddled that up. Hope I got this one-line patch right
this time...

diff -pruN linux-2.6-git/security/selinux/hooks.c linux-2.6-git_xxx/security/selinux/hooks.c
--- linux-2.6-git/security/selinux/hooks.c	2005-06-16 20:01:03.000000000 +0200
+++ linux-2.6-git_xxx/security/selinux/hooks.c	2005-06-17 14:38:08.000000000 +0200
@@ -1945,6 +1945,7 @@ static int selinux_sb_copy_data(struct f
 	} while (*in_end++);
 
 	copy_page(in_save, nosec_save);
+	free_page((unsigned long)nosec_save);
 out:
 	return rc;
 }

