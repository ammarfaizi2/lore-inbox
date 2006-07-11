Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932165AbWGKV6Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932165AbWGKV6Z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 17:58:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932166AbWGKV6Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 17:58:24 -0400
Received: from terminus.zytor.com ([192.83.249.54]:6798 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S932165AbWGKV6X
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 17:58:23 -0400
Message-ID: <44B41EC0.70404@zytor.com>
Date: Tue, 11 Jul 2006 14:57:20 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Cedric Le Goater <clg@fr.ibm.com>
CC: Ulrich Drepper <drepper@gmail.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Kirill Korotaev <dev@openvz.org>,
       Andrey Savochkin <saw@sw.ru>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Herbert Poetzl <herbert@13thfloor.at>,
       Sam Vilain <sam.vilain@catalyst.net.nz>,
       "Serge E. Hallyn" <serue@us.ibm.com>, Dave Hansen <haveblue@us.ibm.com>
Subject: Re: [PATCH -mm 0/7] execns syscall and user namespace
References: <20060711075051.382004000@localhost.localdomain>	 <44B3EA16.1090208@zytor.com> <44B3ED3B.3010401@fr.ibm.com>	 <44B3EDBA.4090109@zytor.com> <a36005b50607111250k70598c31nbc9c0de661dba9e6@mail.gmail.com> <44B41D39.801@fr.ibm.com>
In-Reply-To: <44B41D39.801@fr.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cedric Le Goater wrote:
> 
> How's that ?
> 
> int execvef(int flags, const char *filename, char *const argv [], char
> *const envp[]);
> 
> initially, flags would be :
> 
> #define EXECVEF_NEWNS	0x00000100
> #define EXECVEF_NEWIPC	0x00000200
> #define EXECVEF_NEWUTS	0x00000400
> #define EXECVEF_NEWUSER	0x00000800
> 
> execvef() would behave like execve() if flags == 0 and would return EINVAL
> if flags is invalid. unshare of a namespace can fail and usually returns
> ENOMEM.
> 

If flags comes first, I would rather like to call it execfve(), or 
perhaps execxve() ("extended") or execove() ("options").  execfve() 
sounds like it executes a file descriptor (which would probably be 
called fexecve()).

Perhaps more seriously, if we're adding more functionality already, it 
should acquire -at functionality (execveat) and take a directory argument.

	-hpa

