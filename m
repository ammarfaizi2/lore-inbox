Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264624AbSJRKJH>; Fri, 18 Oct 2002 06:09:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265061AbSJRKJG>; Fri, 18 Oct 2002 06:09:06 -0400
Received: from tsv.sws.net.au ([203.36.46.2]:65033 "EHLO tsv.sws.net.au")
	by vger.kernel.org with ESMTP id <S264624AbSJRKJF>;
	Fri, 18 Oct 2002 06:09:05 -0400
Content-Type: text/plain; charset=US-ASCII
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Alexander Viro <viro@math.psu.edu>
Subject: Re: [PATCH] remove sys_security
Date: Fri, 18 Oct 2002 12:14:54 +0200
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org, linux-security-module@wirex.com
References: <Pine.GSO.4.21.0210180309540.18575-100000@weyl.math.psu.edu>
In-Reply-To: <Pine.GSO.4.21.0210180309540.18575-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210181214.54820.russell@coker.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Oct 2002 09:28, Alexander Viro wrote:
> As for "highly secure"...  Could we please
> see some proof?  Clearly stated properties with code audit to verify them
> would be nice.
>
> I'm yet to see a single shred of evidence that so-called security
> improvements actually do improve security (as opposed to feeling of
> security - quite a different animal).  And in this case burden of proof is
> clearly on your side.

Some people at IBM are working on analysis of SE Linux policy to prove that it 
does what it is supposed to do.  The benefits of MAC as a general concept are 
well documented.


For real-world examples of the benefits of SE Linux:

With the recent terrible PAM bug, in a default Debian setup you could login as 
"man" and then replace the man program (owned by user "man") with a trojan 
(and wait for root to read a man page).  With a default SE Linux setup the 
man binary is in bin_t and the default SE Linux role (which is applied to the 
"man" account) is not permitted to write to it.  Of course setting the file 
to be immutable or configuring the man-db package for the man program to not 
be SUID would get the same result, but that's not generally done.  Also it 
should be noted that there's an infinite number of potential attacks, 
removing access that's not needed is the best way to address them.

The recent Apache SSL exploit gave attackers the full access rights of the 
Apache process, and the recent scoreboard Apache bug allowed someone who can 
write to Apache data the ability to send a signal to any process.  Taking 
advantage of both bugs a remote attacker could send a signal to any process 
(including root).  With SE Linux Apache only gets control over it's own 
cgi-bin scripts and it's own processes.  It can kill itself and some of it's 
children, but that's all.  It can't interfere with other daemons or user 
processes.

After the recent ssh bug the default SE Linux policy was changed to not allow 
sshd_t to transition directly to priviledged domains.  So the next time sshd 
is broken the worst you can do with a default SE Linux machine is to login as 
user_r (which allows you to kill any user processes and write to any user 
files but not kill daemons, change system configuration, or read 
/etc/shadow).  You could configure a SE Linux system to have ssh log you in 
with a role that is only allowed to transition to the real role (which 
requires password authentication) not actually do anything useful.  So then 
if sshd is cracked the attacker can't directly do anything useful.  Of course 
this still wouldn't solve the problem of sshd being trojaned...

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

