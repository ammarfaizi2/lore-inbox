Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262003AbVFQPri@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262003AbVFQPri (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Jun 2005 11:47:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262004AbVFQPri
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Jun 2005 11:47:38 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:4602 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP id S262003AbVFQPrd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Jun 2005 11:47:33 -0400
Subject: Re: [PATCH 1/1] SELinux: memory leak in selinux_sb_copy_data()
From: Gerald Schaefer <geraldsc@de.ibm.com>
Reply-To: geraldsc@de.ibm.com
To: akpm@osdl.org
Cc: jmorris@redhat.com, sds@epoch.ncsc.mil, schwidefsky@de.ibm.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <1119014283.7006.58.camel@thinkpad>
References: <1119014283.7006.58.camel@thinkpad>
Content-Type: text/plain
Date: Fri, 17 Jun 2005 17:47:29 +0200
Message-Id: <1119023249.7006.71.camel@thinkpad>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-06-17 at 15:18 +0200, Gerald Schaefer wrote:
> [PATCH 1/1] SELinux: memory leak in selinux_sb_copy_data()
> There is a memory leak during mount when SELinux is active and mount options
> are specified.
> 
> Signed-off-by: Gerald Schaefer <geraldsc@de.ibm.com>
> ---
> 
> diff -pruN linux-2.6-git/security/selinux/hooks.c linux-2.6-git_xxx/security/selinux/hooks.c
> --- linux-2.6-git/security/selinux/hooks.c      2005-06-16 20:01:03.000000000 +0200
> +++ linux-2.6-git_xxx/security/selinux/hooks.c  2005-06-17 14:38:08.000000000 +0200
> @@ -1945,6 +1945,7 @@ static int selinux_sb_copy_data(struct f
>         } while (*in_end++);
>  
>         copy_page(in_save, nosec_save);
> +       free_page((unsigned long)nosec);
>  out:
>         return rc;
>  }
> 

Sorry, there was a whitespace accident and the above patch would not
apply.
Here is the fixed version:

diff -pruN linux-2.6-git/security/selinux/hooks.c linux-2.6-git_xxx/security/selinux/hooks.c
--- linux-2.6-git/security/selinux/hooks.c	2005-06-16 20:01:03.000000000 +0200
+++ linux-2.6-git_xxx/security/selinux/hooks.c	2005-06-17 14:38:08.000000000 +0200
@@ -1945,6 +1945,7 @@ static int selinux_sb_copy_data(struct f
 	} while (*in_end++);
 
 	copy_page(in_save, nosec_save);
+	free_page((unsigned long)nosec);
 out:
 	return rc;
 }


