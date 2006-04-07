Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964903AbWDGTUa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964903AbWDGTUa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 15:20:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964904AbWDGTUa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 15:20:30 -0400
Received: from mta08-winn.ispmail.ntl.com ([81.103.221.48]:35009 "EHLO
	mtaout02-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S964903AbWDGTU3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 15:20:29 -0400
Message-ID: <4436BBDF.8000802@plan99.net>
Date: Fri, 07 Apr 2006 20:22:07 +0100
From: Mike Hearn <mike@plan99.net>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: Bodo Eggert <7eggert@gmx.de>, Neil Brown <neilb@suse.de>,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] Add a /proc/self/exedir link
References: <5XGlt-GY-23@gated-at.bofh.it> <5XGOz-1eP-35@gated-at.bofh.it>	<E1FRSqP-0000g3-9i@be1.lrz> <443515E1.1000600@plan99.net>	<Pine.LNX.4.58.0604061841150.1941@be1.lrz> <44356DAA.90209@plan99.net> <m164llns9p.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m164llns9p.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:
>> In practice most desktop apps use "prefix paths" to locate their own data
>> files. They don't usually send those file paths to other processes, not even in
>> the case of things like GIMP plugins.
> 
> Programs that ssh to another machine and run commands are likely
> to send paths.

I'm confused again, sorry, these paths would be on the remote machine in 
such a case surely?

> I looked at your original proposal some more and it fails
> miserably for shell scripts.  Basically they all get / as
> their prefix, no matter where in the filesystem you put them.

There is no good way for a shell script to find out where it is, that's 
always been true on Linux and fixing it wasn't a goal of the patch as it 
can be easily done in userspace using a little stub program.

It'd definitely be nice to fix it though.

> Also there is a very serious problem with suid exectuables.
> If a non privileged user has write access to the same filesystem
> the exectuables live on they can create a hard link to those
> files and change the prefix.  Quite possibly getting the suid
> executables to trust a new set of exectuables.

Yes. I don't think that can be fixed in a general way. Again I guess the 
solution would be "don't do that". Maybe the patch could be adapted so 
/proc/self/exedir is not available for suid root programs, to stop 
people making that mistake. Ditto for the fd passing scheme.

> Given that mostly it will be junior programmers packaging applications
> behind the backs of the authors of the code that will implement this
> scheme we could introduce all kinds of problems that no one will
> notice for quite a while.

I guess you are referring to autopackages - whilst simplifying 
relocatability will certainly help junior programmers build such things, 
they're designed to be built or maintained by the original authors of 
the programs themselves (unlike other package formats). Because anybody 
can build them on their own systems, they can be treated like source 
tarballs and maintained as a team.

Allowing packages to be correctly built taking into account the 
subtleties of the software was one of the motivations behind developing 
autopackage ...

thanks -mike
