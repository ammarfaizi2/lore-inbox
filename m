Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269843AbUIDJGl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269843AbUIDJGl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 05:06:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269847AbUIDJGl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 05:06:41 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:42639 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S269843AbUIDJGV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 05:06:21 -0400
Message-ID: <41398597.2040506@cs.aau.dk>
Date: Sat, 04 Sep 2004 11:06:31 +0200
From: =?ISO-8859-1?Q?Kristian_S=F8rensen?= <ks@cs.aau.dk>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040814)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: umbrella-devel@lists.sourceforge.net
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Umbrella-devel] Re: Getting full path from dentry in LSM hooks
References: <41385FA5.806@cs.aau.dk> <1094220870.7975.19.camel@localhost.localdomain>            <4138CE6F.10501@cs.aau.dk> <200409032039.i83Kd1ZR028638@turing-police.cc.vt.edu>
In-Reply-To: <200409032039.i83Kd1ZR028638@turing-police.cc.vt.edu>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Valdis.Kletnieks@vt.edu wrote:
> On Fri, 03 Sep 2004 22:05:03 +0200, =?UTF-8?B?S3Jpc3RpYW4gU8O4cmVuc2Vu?= said:
> 
> 
>>Also simple bufferoverflows in suid-root programs may be avoided. The 
>>simple way would to set the restriction "no fork", and thus if an 
>>attacker tries to fork a (root) shell, this would be denied.
> 
> 
> All this does is stop fork().  I'm not sure, but most shellcodes I've seen
> don't bother forking, they just execve() a shell....
I was not precise enough - it is not just fork, but the LSM catches 
every time a new process is created - so we do have some way of generic 
catching creation of processes, and denying so, if prohibited.

> It doesn't stop a buffer overflow that does this:
> 
> 	f1 = open("/bin/bash");
> 	f2 = open("/tmp/bash", O_CREAT);
> 	while ((bytes = read(f1,buffer,sizeof(buffer))) > 0)
> 		write(f2,buffer,bytes);
> 	fchmod(f2,4775);
> 	close(f1); close(f2);
You are right! ... as long as a new process is not created, this may do 
some damage ... but:

> Papering over *that* one by restricting fchmod just means the exploit needs to
> append a line to /etc/passwd, or create a trojan inetd.conf or crontab entry,
Not mny suid programs would really need to be able to access the /etc 
and everything below... E.g. cdrecord (there were a bug a year ago or 
something)... it should definitely not have access to the possiblílities 
you mention!

> Remember - just papering over the fact that most shellcodes just execve() a
> shell doesn't fix the fundemental problem, which is that the attacker is able
> to run code of his choosing as root.
Good point!

Best, Kristian.
