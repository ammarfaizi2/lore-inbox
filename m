Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261512AbTIZQS7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Sep 2003 12:18:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261522AbTIZQS7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Sep 2003 12:18:59 -0400
Received: from gaia.cela.pl ([213.134.162.11]:2054 "EHLO gaia.cela.pl")
	by vger.kernel.org with ESMTP id S261512AbTIZQS5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Sep 2003 12:18:57 -0400
Date: Fri, 26 Sep 2003 18:18:53 +0200 (CEST)
From: Maciej Zenczykowski <maze@cela.pl>
To: Davide Libenzi <davidel@xmailserver.org>
cc: Ingo Molnar <mingo@elte.hu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Syscall security
In-Reply-To: <Pine.LNX.4.56.0309260746140.1924@bigblue.dev.mdolabs.com>
Message-ID: <Pine.LNX.4.44.0309261814450.6080-100000@gaia.cela.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I beieve that what you're trying to do is a little bit more complicated
> then simply blocking a few system calls. There are security softwares
> doing this but they do more then blindly blocking system calls. Parameters
> of the system call do matter in this scenario. For example you don't want
> to block every write(), since the application you're trying to control
> must be able to write on its own installation dir for example. They do

Actually in this case all disk-access (and net-access) is illegal, and 
we're running in an empty chroot environment anyway. :)  We're not really 
running aps - they're more along the lines of CPU calculation pipes - data 
in -> calc in system memory -> data out.

> this by running the given application and "learning" system calls and
> params to create a per-application policy. Every behaviour that violates
> the policy trigger an event to the user running it (with a
> "human readable" description of what is happening) and the user can either
> accept it (by trainig the policy) or reject it.

I'm afraid this has to run without user-intervention and the policy is 
trivial - allow mem-management (brk/mmap...) + exit + read stdin + write 
stdout.

Thx,
MaZe.

