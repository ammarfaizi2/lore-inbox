Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261511AbUL3Dw6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261511AbUL3Dw6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Dec 2004 22:52:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261513AbUL3Dw6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Dec 2004 22:52:58 -0500
Received: from [220.181.31.170] ([220.181.31.170]:37282 "HELO 126.com")
	by vger.kernel.org with SMTP id S261511AbUL3Dwz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Dec 2004 22:52:55 -0500
X-Originating-IP: [219.133.178.194]
Message-ID: <41D37B7B.2010400@126.com>
Date: Thu, 30 Dec 2004 11:52:27 +0800
From: Walter Liu <Walter.liu@126.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.2; en-US; rv:1.7.3) Gecko/20040910
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tetsuo Handa <from-linux-kernel@i-love.sakura.ne.jp>
CC: linux-kernel@vger.kernel.org
Subject: Re: Is CAP_SYS_ADMIN checked by every program !?
References: <200412291347.JEH41956.OOtStPFFNMLJVGMYS@i-love.sakura.ne.jp>
In-Reply-To: <200412291347.JEH41956.OOtStPFFNMLJVGMYS@i-love.sakura.ne.jp>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tetsuo Handa wrote:

>  Hello.
>
>I found a strange behavior with kernel 2.6.9 and later. ( I haven't tested for 2.6.8 and earlier. )
>It seems to me that every program calls capable(CAP_SYS_ADMIN),
>even for programs such as cat(1) sed(1) ls(1).
>My environment is Fedora Core 3.
>
>The following is the patch for checking.
>
>----- Start of Patch -----
>*** sched.h.org Sat Dec 25 06:33:59 2004
>--- sched.h     Wed Dec 29 13:00:53 2004
>***************
>*** 870,875 ****
>--- 870,882 ----
>  #else
>  static inline int capable(int cap)
>  {
>+       if (cap == CAP_SYS_ADMIN) {
>+               static pid_t last_pid = 0;
>+               if (current->pid != last_pid) {
>+                       printk("euid=%d uid=%d %s %s\n", current->euid, current->uid, cap_raised(current->cap_effective, CAP_SYS_ADMIN) ? "true" : "fa
>lse", current->comm);
>+                       last_pid = current->pid;
>+               }
>+       }
>        if (cap_raised(current->cap_effective, cap)) {
>                current->flags |= PF_SUPERPRIV;
>                return 1;
>----- End of Patch -----
>
>Programs run as root always show "true", and run as non-root always show "false",
>but it's will be OK.
>I can't understand why every program checks for CAP_SYS_ADMIN .
>With 2.4.28 and RedHat 9, no such behavior happens.
>
>Is this normal behavior for 2.6 ?
>
>  
>
The POSIX capability mechanism  is  the OS privilege  mechanism ,
like the privilege mechanism in  VMS  or NT .
I think that every process  for  any capability  have to check them,
This is a must operation..

Regards
LWT

