Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266123AbTLaFVz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Dec 2003 00:21:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266124AbTLaFVz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Dec 2003 00:21:55 -0500
Received: from mail2.megatrends.com ([155.229.80.16]:22792 "EHLO
	atl-ms1.megatrends.com") by vger.kernel.org with ESMTP
	id S266123AbTLaFVk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Dec 2003 00:21:40 -0500
Message-ID: <8CCBDD5583C50E4196F012E79439B45C0568D7F6@atl-ms1.megatrends.com>
From: Srikumar Subramanian <SrikumarS@ami.com>
To: "'Andrew Morton'" <akpm@osdl.org>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Cc: Boopathi Veerappan <BoopathiV@ami.com>,
       Srikumar Subramanian <SrikumarS@ami.com>
Subject: RE: memory leak in call_usermodehelper()
Date: Wed, 31 Dec 2003 00:22:50 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is my sample syscall implementation

---
asmlinkage int sys_mysyscall (int arg1, char * arg2)
{
	char * argv[2], * envp[3];
	
	argv[0] = "/usr/test";  //this program does nothing, simply returns
0
	argv[1] = 0;
	
	envp[0] = "HOME=/";
	envp[1] = "PATH=/bin:/sbin/:/usr/bin:/usr/sbin";
	envp[2] = 0;

	call_usermodehelper (argv[0], argv, envp);  //calling this way leads
to memory leak in kernel.

	return 1;
}
---

Is there any alternative to call_usermodehelper in kernel 2.4.20?

Any suggestion of patch will be greatly appreciated.

Thanks & regards,
Srikumar

-----Original Message-----
From: Srikumar Subramanian 
Sent: Tuesday, December 30, 2003 12:14 PM
To: 'Andrew Morton'
Cc: linux-kernel@vger.kernel.org; Srikumar Subramanian; Boopathi Veerappan
Subject: RE: memory leak in call_usermodehelper()

Hi,
I am using 2.4.20-8 Redhat 9 kernel.

-----Original Message-----
From: Andrew Morton [mailto:akpm@osdl.org]
Sent: Tuesday, December 30, 2003 6:20 AM
To: Srikumar Subramanian
Cc: linux-kernel@vger.kernel.org; SrikumarS@ami.com; BoopathiV@ami.com
Subject: Re: memory leak in call_usermodehelper()

Srikumar Subramanian <SrikumarS@ami.com> wrote:
>
> Hi All,
>
> >From my customized system call, I merely call call_usermodehelper() to
spawn
> a process. When I call my_system_call around 1000 times in order to spawn
> 'hello world' program, I noticed in 'top' program that system has lost 200
> KB of free memory.
> I just increased the iteration to 700000, I lost the entire 128 MB free
> memory from my system and eventually the system is freezed.
>

What version of the kernel were you using?
