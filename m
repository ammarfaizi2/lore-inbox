Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262501AbULOVWO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262501AbULOVWO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 16:22:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262500AbULOVWO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 16:22:14 -0500
Received: from facesaver.epoch.ncsc.mil ([144.51.25.10]:35741 "EHLO
	epoch.ncsc.mil") by vger.kernel.org with ESMTP id S262501AbULOVVT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 16:21:19 -0500
Subject: Re: [PATCH] Split bprm_apply_creds into two functions
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, Chris Wright <chrisw@osdl.org>,
       James Morris <jmorris@redhat.com>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20041215200005.GB3080@IBM-BWN8ZTBWA01.austin.ibm.com>
References: <20041215200005.GB3080@IBM-BWN8ZTBWA01.austin.ibm.com>
Content-Type: text/plain
Organization: National Security Agency
Message-Id: <1103145355.32732.55.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 15 Dec 2004 16:15:55 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-12-15 at 15:00, Serge E. Hallyn wrote:
> The security_bprm_apply_creds() function is called from
> fs/exec.c:compute_creds() under task_lock(current).  SELinux must
> perform some work which is unsafe in that context, and therefore
> explicitly drops the task_lock, does the work, and re-acquires the
> task_lock.  This is unsafe if other security modules are stacked after
> SELinux, as their bprm_apply_creds assumes that the 'unsafe' variable is
> still meaningful, that is, that the task_lock has not been dropped.
> 
> The attached patch splits bprm_apply_creds into two functions,
> bprm_apply_creds and bprm_final_setup, where final_setup is called right
> after the task_lock has been dropped.

Two minor notes:
1) I'd suggest moving the unsafe field from task_security_struct to
bprm_security_struct, as there is no reason for this flag to live beyond
the lifecycle of the binprm.
2) Comment in security.h says 'task_list' where it should be
'task_lock'.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

