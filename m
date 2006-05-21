Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932282AbWEUXaX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932282AbWEUXaX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 May 2006 19:30:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751560AbWEUXaX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 May 2006 19:30:23 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:28049 "EHLO
	watts.utsl.gen.nz") by vger.kernel.org with ESMTP id S1751557AbWEUXaX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 May 2006 19:30:23 -0400
Message-ID: <4470F7FD.4030608@vilain.net>
Date: Mon, 22 May 2006 11:30:05 +1200
From: Sam Vilain <sam@vilain.net>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, dev@sw.ru, herbert@13thfloor.at,
       devel@openvz.org, ebiederm@xmission.com, xemul@sw.ru,
       Dave Hansen <haveblue@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       Cedric Le Goater <clg@fr.ibm.com>
Subject: Re: [PATCH 1/9] namespaces: add nsproxy
References: <20060518154700.GA28344@sergelap.austin.ibm.com> <20060518154837.GB28344@sergelap.austin.ibm.com>
In-Reply-To: <20060518154837.GB28344@sergelap.austin.ibm.com>
X-Enigmail-Version: 0.92.1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Serge E. Hallyn wrote:

>@@ -1585,7 +1591,15 @@ asmlinkage long sys_unshare(unsigned lon
> 
> 	if (new_fs || new_ns || new_sigh || new_mm || new_fd || new_ulist) {
> 
>+		old_nsproxy = current->nsproxy;
>+		new_nsproxy = dup_namespaces(old_nsproxy);
>+		if (!new_nsproxy) {
>+			err = -ENOMEM;
>+			goto bad_unshare_cleanup_semundo;
>+		}
>+
> 		task_lock(current);
>  
>

We'll get lots of duplicate nsproxy structures before we move all of the
pointers for those subsystems into it. Do we need to dup namespaces on
all of those conditions?

Sam.
