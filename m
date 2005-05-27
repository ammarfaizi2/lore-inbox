Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262541AbVE0S7D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262541AbVE0S7D (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 14:59:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262539AbVE0S7D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 14:59:03 -0400
Received: from ms-smtp-01.texas.rr.com ([24.93.47.40]:30974 "EHLO
	ms-smtp-01-eri0.texas.rr.com") by vger.kernel.org with ESMTP
	id S262541AbVE0S6y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 14:58:54 -0400
Message-ID: <42976D3A.5020200@davyandbeth.com>
Date: Fri, 27 May 2005 13:55:54 -0500
From: Davy Durham <pubaddr2@davyandbeth.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050322
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Steven Rostedt <rostedt@goodmis.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: disowning a process
References: <42975945.7040208@davyandbeth.com> <1117217088.4957.24.camel@localhost.localdomain>
In-Reply-To: <1117217088.4957.24.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cool.. I looked at the daemon function and I might be able to use it..

However, I compiled your code... seems to work.. but where is the wait() 
done on the middle parrent so that it isn't left defunct?

Steven Rostedt wrote:

>Try man daemon.
>
>The way I use to do it was simply do a double fork. That is
>(simplified)...
>
>if ((pid = fork()) < 0) {
>	perror("fork");
>} else if (!pid) {
>	/* child */
>	if ((pid = fork()) < 0) {
>		perror("child fork");
>		exit(-1);
>	} if (pid) {
>		/* child parent */
>		/* Here we detach from the child */
>		exit(0);
>	}
>	/* Now this code is a child running almost as a daemon
>		with init as the parent. */
>	setsid();
>	/* Now the child is completely detached from the original
>	   parent */
>	/* ... daemon code here ... */
>	exit(0);
>}
>
>/* parent code here */
>
>-- Steve
>
>  
>



