Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262178AbVAACeg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262178AbVAACeg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Dec 2004 21:34:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262179AbVAACeg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Dec 2004 21:34:36 -0500
Received: from smtp202.mail.sc5.yahoo.com ([216.136.129.92]:39278 "HELO
	smtp202.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262178AbVAACeb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Dec 2004 21:34:31 -0500
Message-ID: <41D60C35.9000503@yahoo.com.au>
Date: Sat, 01 Jan 2005 13:34:29 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041007 Debian/1.7.3-5
X-Accept-Language: en
MIME-Version: 1.0
To: Justin Pryzby <justinpryzby@users.sourceforge.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.5isms
References: <20041231230624.GA29411@andromeda>
In-Reply-To: <20041231230624.GA29411@andromeda>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Justin Pryzby wrote:
> Hi all, I have more 2.5isms for the list.  ./fs/binfmt_elf.c:
> 
>   #ifdef CONFIG_X86_HT
>                   /*
>                    * In some cases (e.g. Hyper-Threading), we want to avoid L1
>                    * evictions by the processes running on the same package. One
>                    * thing we can do is to shuffle the initial stack for them.
>                    *
>                    * The conditionals here are unneeded, but kept in to make the
>                    * code behaviour the same as pre change unless we have
>                    * hyperthreaded processors. This should be cleaned up
>                    * before 2.6
>                    */
> 
>                   if (smp_num_siblings > 1)
>                           STACK_ALLOC(p, ((current->pid % 64) << 7));
>   #endif
> 

Can we just kill it? Or do it unconditionally? Or maybe better yet, wrap
it properly in arch code?

