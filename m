Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268218AbRHAVEe>; Wed, 1 Aug 2001 17:04:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268221AbRHAVEZ>; Wed, 1 Aug 2001 17:04:25 -0400
Received: from zero.tech9.net ([209.61.188.187]:11282 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S268235AbRHAVEK>;
	Wed, 1 Aug 2001 17:04:10 -0400
Subject: Re: Basic question..
From: Robert Love <rml@tech9.net>
To: Raghava Raju <vraghava_raju@yahoo.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010801204401.21619.qmail@web20009.mail.yahoo.com>
In-Reply-To: <20010801204401.21619.qmail@web20009.mail.yahoo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.12.99 (Preview Release)
Date: 01 Aug 2001 17:04:51 -0400
Message-Id: <996699893.1420.7.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 01 Aug 2001 13:44:01 -0700, Raghava Raju wrote:
>         I am new to kernel programming. I have
>    just written a module consisting of init and
> cleanup
>    functions. I call init function of the module in
>    kernel initialization function. So when system
>    comes up, it shows that it entered module init 
>    function(printk in "init" print some string), but 
>    when I do lsmod it is not there in  list of 
>    modules. But if I do insmod module, the module is
>    listed in lsmod output. So is it that calling init
>    module and insmod are not equivalent?

this is correct. calling the init function from within the kernel is not
the same as using insmod.  calling the init function is just that --
calling some linked-in function from within the kernel.

if you want to load a module from within the kernel, what you want is:
#include<linux/kmod.h>
int request_module(const char * module_name);

you will need kmod compiled in.

however, i suppose this is not what you want.  if you want to load your
code into the kernel -- statically linked -- then its not a module.  its
a member of the kernel.  have fun, enjoy the place.

if you want it to be a module, then its seperate, and you should load it
via insmod/modprobe/kmod.

-- 
Robert M. Love
rml at ufl.edu
rml at tech9.net

