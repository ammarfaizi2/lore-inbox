Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261641AbVE0T2T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261641AbVE0T2T (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 15:28:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262554AbVE0T2T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 15:28:19 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:41721 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S261641AbVE0T2C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 15:28:02 -0400
Subject: Re: disowning a process
From: Steven Rostedt <rostedt@goodmis.org>
To: Davy Durham <pubaddr2@davyandbeth.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <42976F62.6000701@davyandbeth.com>
References: <42975945.7040208@davyandbeth.com>
	 <1117217088.4957.24.camel@localhost.localdomain>
	 <42976D3A.5020200@davyandbeth.com>  <42976F62.6000701@davyandbeth.com>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Fri, 27 May 2005 15:27:56 -0400
Message-Id: <1117222076.6477.9.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-05-27 at 14:05 -0500, Davy Durham wrote:
> Davy Durham wrote:

> I added "waitpid(pid,NULL,0);" after the outer-most if.. which is where 
> the grand parent cleans up the pid of the intermediate parent. 

That's correct.

> 
> However, now trying the daemon() function..  which seems to work the 
> same way.. it definately leaves a pid around.. so I guess you really 
> need to do a wait() in the parent after forking.. however you don't know 
> exactly which pid to wait for so you might be reaping some other child 
> you've previously spawned.. 

The daemon function is really just the inner fork and setsid. So with
using the daemon function it looks like this:

       if ((pid = fork()) < 0) {
                perror("fork");
        } else if (!pid) {
                if (daemon(0,0) < 0) {
                        exit(-1);
                }
		/* daemon code here */
		exit(0);
        }

        waitpid(pid,NULL,0);

-- Steve


