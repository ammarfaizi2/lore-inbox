Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262509AbVE0SSG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262509AbVE0SSG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 14:18:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262511AbVE0SSG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 14:18:06 -0400
Received: from ms-smtp-01.texas.rr.com ([24.93.47.40]:13198 "EHLO
	ms-smtp-01-eri0.texas.rr.com") by vger.kernel.org with ESMTP
	id S262509AbVE0SR4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 14:17:56 -0400
Message-ID: <429763A5.1080905@davyandbeth.com>
Date: Fri, 27 May 2005 13:15:01 -0500
From: Davy Durham <pubaddr2@davyandbeth.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050322
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff.Fellin@rflelect.com
CC: linux-kernel@vger.kernel.org
Subject: Re: disowning a process
References: <OFA0F07206.30BD7843-ON8525700E.00611011@teal.com>
In-Reply-To: <OFA0F07206.30BD7843-ON8525700E.00611011@teal.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the reply!

Well this seems straight-forward enough, but it doesn't seem to work for 
me.. see if I have everything straight..

#include <unistd.h>
#include <stdio.h>
int main()
{
    if(fork())
    { /* parent */
       sleep(15);
    }
    else
    { /* child */
       printf("setpgrp returned: %d\n",setpgrp());
       sleep(5);
    }
}

I run the program.. setpgrp is returning zero.. then I quickly look at 
the ps listing.. the child's pid is still the parent's, but that may be 
okay..     Then after 5 seconds when the child exits.. I do the ps again 
and I do still see that the child is now defunct.. the desired effect is 
that the child would go away because I don't care what the exit status 
was.  I was thinking that if init could become the parent of the newly 
forked child, then it would clean it up when it exits.

Any ideas?

-- Davy

Jeff.Fellin@rflelect.com wrote:

>Davy,
>After you fork the process, use setpgrp() to make the process the head of
>it's own process group.
>check man -S2 setpgrp for details.
>
>  
>

>Hi,  I'm not sure if there's a posix way of doing this, but wanted to
>check if there is a way in linux.
>
>I want to have a daemon that fork/execs a new process, but don't want
>(for various reasons) the responsibility for cleaning up those process
>with the wait() function family.   I'm assuming that if the init process
>became the parent of one of these forked processes, then it would clean
>them up for me (is this assumption true?).    Besides the daemon process
>exiting, is there a way to disown the process on purpose so that init
>inherits it?
>
>Thanks,
>   Davy
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>
>  
>


