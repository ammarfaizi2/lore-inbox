Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161570AbWHDWw4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161570AbWHDWw4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 18:52:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161571AbWHDWw4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 18:52:56 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:56094 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1161570AbWHDWwz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 18:52:55 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=iDVBzOwX+ixeZrt5tPgYD337hcvNT1FWR02l3ew5jVi5ojkiiBjrHL6yjlLw5CGpGgIchk9H4fYxJ5UzOO/dgi5NMQTeTMYg4xES9Hwh9USvsocD6C6G4Ov58F0to4O/Vs04CEZKN04PbeQC1NXuDu2HaVwbQNhaQ9KQFOg8T4k=
Message-ID: <44D3CFB9.9020208@gmail.com>
Date: Sat, 05 Aug 2006 00:52:41 +0200
From: RazorBlu <razorblu@gmail.com>
User-Agent: Thunderbird 1.5.0.5 (Windows/20060719)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: ACLs
References: <44D3BF62.10202@gmail.com> <1154729992.3573.35.camel@brianb>
In-Reply-To: <1154729992.3573.35.camel@brianb>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brian Beattie wrote:
> Having implemented ACLs twice on Unix and Unix-like systems, I don't see
> what the fetish some people have for them.  Frankly juts about anything
> you can do with ACLs (and anything you should want to do) you can do
> with users/groups and the standard Unix/Linux permissions.  Why add
> unneeded cruft to the kernel. 
Because instead of having an all-powerful account (which we so lovingly 
know as root), you can separate specific roles to different accounts. To 
use Windows' ACLs as an example:

- Adjust memory quotas for a process
- Allow/deny access to this computer from the network
- Backup files and directories
- Bypass traverse checking
- Change system time
- Increase scheduling priority
- Load and unload device drivers
- Manage auditing and security logs
- Restore files and directories
- Shutdown the system
- Take ownership of files or other objects

As you can see, those are finely-grained controls. Why would these be 
useful on Linux? Because you can have a root account which can bind 
Apache to a port <1024, and even if it is compromised it cannot 
"shutdown the system," or "deny access to this computer from the 
network," thus the attacker will be able to cause minimal damage. Yes, 
the same can be done on Linux using SELinux, AppArmor, or some other ACL 
system, but again - those aren't part of the kernel. They are extra 
apps, and adding layers is not always the best solution when it comes to 
security.
>  I know that some spooks think you have to
> have ACLs to have a trusted system, but these are the same people who
> think you need to violate my freedoms to protect them.
>   
Um.. Forgive me for a second, but are you suggesting that a Linux system 
running a service(s) under full root privileges (such as Apache) is just 
as secure as a Linux system running the same process but with 
compartmentalisation to make sure that each service has access to just 
the files and directories it needs, achieved (currently) via AppArmor, 
SELinux, or a similar ACL system? If you really do think that, you may 
want to read a few more papers and/or books. If Apache is bound to port 
80 as root and is not restricted (via ACLs) to just the directories, 
files, libraries and whatnot that it needs access to, and it is 
compromised, then the attacker has full control over your server. If you 
have ACLs in place, the attacker can only access the files that Apache 
has access to, thus protecting all other files on the server (and thus 
greatly decreasing the chances of the attacker implementing a 
hard-to-detect kernel rootkit, or some other malware).
