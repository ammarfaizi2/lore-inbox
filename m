Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264665AbUHWO3y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264665AbUHWO3y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 10:29:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264668AbUHWO3y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 10:29:54 -0400
Received: from chaos.analogic.com ([204.178.40.224]:50306 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S264665AbUHWO3t
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 10:29:49 -0400
Date: Mon, 23 Aug 2004 10:29:20 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Lei Yang <leiyang@nec-labs.com>
cc: Lee Revell <rlrevell@joe-job.com>, Sam Ravnborg <sam@ravnborg.org>,
       Kernel Newbies Mailing List <kernelnewbies@nl.linux.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Problems compiling kernel modules
In-Reply-To: <4129FAC8.3040502@nec-labs.com>
Message-ID: <Pine.LNX.4.53.0408231018001.7732@chaos>
References: <4127A15C.1010905@nec-labs.com>  <20040821214402.GA7266@mars.ravnborg.org>
 <4127A662.2090708@nec-labs.com>  <20040821215055.GB7266@mars.ravnborg.org>
  <4127B49A.6080305@nec-labs.com> <1093121824.854.167.camel@krustophenia.net>
 <4129FAC8.3040502@nec-labs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Aug 2004, Lei Yang wrote:

> Hi friends,
>
> I've askeed questions about errors compiling kernel modules caused by
> including <stdio.h> and got some very helpful info here.
>
> I changed those I/O stream and file operation in the code and get the
> module compiled, however, there would be warnings like
>
> In file included from /home/lei/modules/test.c:49:
> /home/lei/modules/Kcomp.h:21: warning: function declaration isn't a
> prototype
> /home/lei/modules/Kcomp.h:27: warning: function declaration isn't a
> prototype
> /home/lei/modules/Kcomp.h:69: warning: function declaration isn't a
> prototype
>
> And the no prototype fuction looks like
>
> int preset() // with no arguments
> {
> 	p = &nodes[0][0];
> 	return 0;
> }
>

A function looks like this:

int present()
{

}

A prototype for the same function looks like this:

int present(void);

Functions always have "{}". Prototypes never do.
-- Yes there's some troll who might cite some obscure
case... ignore them.

If you compile above a certain warning-level, then prototypes
are required. The prototype usually goes in header files
and the function (the actual code) goes in the source files.

>
> So when I tried to install the module with insmod ./test.ko ,
> there would be an error,
>
> insmod: error inserting './test.ko': -1 Unknown symbol in module
>
> Could anyone tell me what is wrong here? Is that because of the no
> prototype function declaration?
>

Do `depmod -e test.ko` to see what it's complaining about. You
can see all the symbols by using `nm`. Try it. Your code
probably didn't define the necessary stuff to make a module.
You need to look at a typical module (driver) that comes with the
kernel. Just find one of the shortest ".c" files in the driver
tree.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.26 on an i686 machine (5570.56 BogoMips).
            Note 96.31% of all statistics are fiction.


