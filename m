Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262293AbVAJPkO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262293AbVAJPkO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 10:40:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262295AbVAJPkN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 10:40:13 -0500
Received: from fire.osdl.org ([65.172.181.4]:23700 "EHLO fire-1.osdl.org")
	by vger.kernel.org with ESMTP id S262293AbVAJPkB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 10:40:01 -0500
Message-ID: <41E295AA.8050204@osdl.org>
Date: Mon, 10 Jan 2005 06:48:10 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
Organization: OSDL
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: selvakumar nagendran <kernelselva@yahoo.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Module : Pipefs : doubts
References: <20050110063825.83428.qmail@web60601.mail.yahoo.com>
In-Reply-To: <20050110063825.83428.qmail@web60601.mail.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

selvakumar nagendran wrote:
> Hello Randy,
>      Thanks for ur help. See I do know that pipe.o is
> compiled into the main kernel image. But the following
> code block in pipe.c, made me to think as if pipefs
> has been implemented as a module in the kernel. Bcoz
> it used module_init and module_exit macros. That's why
> I got confused. Can u explain the reason for this?

Here's what I suggest.  Look at the kernel header files,
in particular: include/linux/init.h .

Find /module_init/ in that header file.
It has different #defines depending on whether the
including file (e.g., pipe.c) is being
built as a module or not (#ifdef MODULE).

Once you have found that module_init() means __initcall(),
then you can find that __initcall() means device_initcall(),
which in turns means define_initcall("6",fn);
which is a (normal, common) method of setting up a
"module" (functional module, not only for separate
loadable modules) initialization entry point.
There, darn, I've said too much and my rubout key
doesn't work.



> ------------------
> static DECLARE_FSTYPE(pipe_fs_type, "pipefs",
> pipefs_read_super, FS_NOMOUNT);
> 
> static int __init init_pipe_fs(void)
> {
> 	int err = register_filesystem(&pipe_fs_type);
> 	if (!err) {
> 		pipe_mnt = kern_mount(&pipe_fs_type);
> 		err = PTR_ERR(pipe_mnt);
> 		if (IS_ERR(pipe_mnt))
> 			unregister_filesystem(&pipe_fs_type);
> 		else
> 			err = 0;
> 	}
> 	return err;
> }
> 
> static void __exit exit_pipe_fs(void)
> {
> 	unregister_filesystem(&pipe_fs_type);
> 	mntput(pipe_mnt);
> }
> 
> module_init(init_pipe_fs)
> module_exit(exit_pipe_fs)
> 
> 
> --- "Randy.Dunlap" <rddunlap@osdl.org> wrote:
> 
>>selvakumar nagendran wrote:
>>
>>>Hello linux-experts,
>>>    I went through the kernel source code file
>>>/fs/pipe.c and I found that the pipe file system
>>>configured as a module. But in lsmod I am unable
>>
>>to
>>
>>>see it. This is my first doubt.
> 
>  
>  Where do you see that?
>  fs/pipe.o is always built into the kernel image.


-- 
~Randy
