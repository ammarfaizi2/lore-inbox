Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262119AbVAJGid@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262119AbVAJGid (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 01:38:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262120AbVAJGic
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 01:38:32 -0500
Received: from web60601.mail.yahoo.com ([216.109.118.221]:52118 "HELO
	web60601.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262119AbVAJGi0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 01:38:26 -0500
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=ZB7nBEQlHtZjnd4rOzRShdfmqu1DYWA46JzoSaFIUoTwGBo+RkpmJySu6dPJUKbcikV4RFTnji9JgPa0Kvyc09Mom/IuwoOOdFj0n/RzkY79R0SXtSqTO2hzFwiN7xtjUZ58Nd0IL2BtzsXbpjnGDruqvGoHME+ZLcjrIWxhL8w=  ;
Message-ID: <20050110063825.83428.qmail@web60601.mail.yahoo.com>
Date: Sun, 9 Jan 2005 22:38:25 -0800 (PST)
From: selvakumar nagendran <kernelselva@yahoo.com>
Subject: Module : Pipefs : doubts
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <41E21957.7030406@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Randy,
     Thanks for ur help. See I do know that pipe.o is
compiled into the main kernel image. But the following
code block in pipe.c, made me to think as if pipefs
has been implemented as a module in the kernel. Bcoz
it used module_init and module_exit macros. That's why
I got confused. Can u explain the reason for this?

Thanks,
selva

------------------
static DECLARE_FSTYPE(pipe_fs_type, "pipefs",
pipefs_read_super, FS_NOMOUNT);

static int __init init_pipe_fs(void)
{
	int err = register_filesystem(&pipe_fs_type);
	if (!err) {
		pipe_mnt = kern_mount(&pipe_fs_type);
		err = PTR_ERR(pipe_mnt);
		if (IS_ERR(pipe_mnt))
			unregister_filesystem(&pipe_fs_type);
		else
			err = 0;
	}
	return err;
}

static void __exit exit_pipe_fs(void)
{
	unregister_filesystem(&pipe_fs_type);
	mntput(pipe_mnt);
}

module_init(init_pipe_fs)
module_exit(exit_pipe_fs)


--- "Randy.Dunlap" <rddunlap@osdl.org> wrote:
> selvakumar nagendran wrote:
> > Hello linux-experts,
> >     I went through the kernel source code file
> > /fs/pipe.c and I found that the pipe file system
> > configured as a module. But in lsmod I am unable
> to
> > see it. This is my first doubt.
 
 Where do you see that?
 fs/pipe.o is always built into the kernel image.





		
__________________________________ 
Do you Yahoo!? 
Yahoo! Mail - now with 250MB free storage. Learn more.
http://info.mail.yahoo.com/mail_250
