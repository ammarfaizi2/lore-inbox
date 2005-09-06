Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964798AbVIFKiF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964798AbVIFKiF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 06:38:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964799AbVIFKiF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 06:38:05 -0400
Received: from ns.firmix.at ([62.141.48.66]:15582 "EHLO ns.firmix.at")
	by vger.kernel.org with ESMTP id S964798AbVIFKiC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 06:38:02 -0400
Subject: Re: what will connect the fork() with its following code ? a
	simple example below:
From: Bernd Petrovitsch <bernd@firmix.at>
To: walking.to.remember@gmail.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <6b5347dc0509060215128d477e@mail.gmail.com>
References: <6b5347dc0509060215128d477e@mail.gmail.com>
Content-Type: text/plain
Organization: Firmix Software GmbH
Date: Tue, 06 Sep 2005 12:37:55 +0200
Message-Id: <1126003076.31664.5.camel@tara.firmix.at>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-09-06 at 17:15 +0800, Sat. wrote:
> if(!(pid=fork())){
>      ......
>      printk("in child process");
>      ......
> }else{
>      .....
>      printk("in father process"); 
>      .....
> }
> 
> this is a classical example, when the fork() system call runs, it will
> build a new process and active it . while the schedule() select the
> new process it will run. this is rather normal.
> 
> but there is always a confusion in my minds. 
> because , sys_fork() only copies father process and configure some new
> values., and do nothing . so the bridge  between the new process and
> its following code, printk("in child process"), seems disappear . so I

No, it is the same point as in the parent process - just the fork()
call. In fact the fork() returns twice - once within the parent process
(returning as result the pid of the child) and once within the child
(returning 0) [ and we ignore the error case for simplicity ].
Basically you are not forced to do a if() or switch() on the return
value(s) of fork()
----  snip  ----
printf("1. fork() in process %d returned %d\n", getpid(), fork());
printf("2. fork() in process %d returned %d\n", getpid(), fork());
printf("3. fork() in process %d returned %d\n", getpid(), fork());
printf("4. fork() in process %d returned %d\n", getpid(), fork());
printf("5. fork() in process %d returned %d\n", getpid(), fork());
----  snip  ----
Put this in a main() function and try it out.

> always believe that the new process should have a pointer which point
> the code "printk("in child process");". except this , there are not
> any connection between them ?

The kernel doesn't know (or care) about the C code (e.g. if(), ...) in
your application.
The "pointer" (if you want to call it) is the normal instruction pointer
(or what else it is called on your CPU).

> very confused :( 

	Bernd
-- 
Firmix Software GmbH                   http://www.firmix.at/
mobil: +43 664 4416156                 fax: +43 1 7890849-55
          Embedded Linux Development and Services

