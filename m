Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318314AbSIBQOt>; Mon, 2 Sep 2002 12:14:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318317AbSIBQOs>; Mon, 2 Sep 2002 12:14:48 -0400
Received: from zikova.cvut.cz ([147.32.235.100]:62481 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S318314AbSIBQOs>;
	Mon, 2 Sep 2002 12:14:48 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Der Herr Hofrat <der.herr@mail.hofr.at>
Date: Mon, 2 Sep 2002 18:18:55 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: kthread execve question
CC: linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.50
Message-ID: <A811111E8C@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  2 Sep 02 at 17:03, Der Herr Hofrat wrote:
> 
>  any hint whats wrong ? any pointers to using kernel threads dosc/examples in 
>  general and how to execute user space apps would be appreciated.
> 
> char cmd_path[256] = "/bin/echo";
> 
> static int exec_cmd(void * kthread_arg)
> {
>     static char * envp[] = { "HOME=/", 
>         "TERM=linux", 
>         "PATH=/:/bin:/usr/bin:/usr/bin", 
>         NULL };
>     char *argv[] = { kthread_arg,
>         ">>",
>         "/tmp/kthread_echo", 

'>>' is bash thing. Try executing "/bin/touch" with "/tmp/testfile" instead.
If /tmp/testfile will appear, you got it.

And also do not forget that argv[0] should contain program name, not
first argument - so in most cases you want
exec_usermodehelper(argv[0], argv, envp) ...
                                                    Petr Vandrovec
                                                    
