Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269771AbUICUQm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269771AbUICUQm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 16:16:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269776AbUICUOS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 16:14:18 -0400
Received: from pfepb.post.tele.dk ([195.41.46.236]:63843 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S269754AbUICUFE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 16:05:04 -0400
Message-ID: <4138CE6F.10501@cs.aau.dk>
Date: Fri, 03 Sep 2004 22:05:03 +0200
From: =?UTF-8?B?S3Jpc3RpYW4gU8O4cmVuc2Vu?= <ks@cs.aau.dk>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040814)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: umbrella-devel@lists.sourceforge.net
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Umbrella-devel] Re: Getting full path from dentry in LSM hooks
References: <41385FA5.806@cs.aau.dk> <1094220870.7975.19.camel@localhost.localdomain>
In-Reply-To: <1094220870.7975.19.camel@localhost.localdomain>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Gwe, 2004-09-03 at 13:12, Kristian Sørensen wrote:
> 
>>I have a short question, concerning how to get the full path of a file 
>>from a LSM hook.
> 
> 
> The full path or a full path. It may have several. They may also have
> changed under you. 
> 
> 
>>Can some one reveal the trick to get the full path nomater if the 
>>filesystem is root or mounted elsewhere in the filesystem?
> 
> 
> You can get the namespace and the name within that namespace that
> represents at least one of the names of the file within the vfs layer
> (this is what the VFS itself uses for the struct nameidata).
> 
> There may be multiple links to a file, it may be mounted in multiple
> places and someone on a seperate NFS server may have moved it while you
> are thinking about it.
Umbrella is mostly designed for embedded systems (where selinux is 
overkill) and also it is very easy to understand. Most restrictions will 
be made to e.g. stop viruses from spreading, and it is quite easy, yet 
very effective:

If an email client receives an malformed email (like the countless 
attacks on outlook), a simple restriction could be for the process 
handeling the mail would be "$HOME/.addressbook", furthermore, you could 
specify that attachments executed _from_ the emailprogram would not have 
access to the network. Thus the virus cannot find mail addresses to send 
itself to - and it cannot even get network access. Simple and effective.

Also simple bufferoverflows in suid-root programs may be avoided. The 
simple way would to set the restriction "no fork", and thus if an 
attacker tries to fork a (root) shell, this would be denied. Another way 
could be to heavily restrict access to the filesystem. If the program is 
restricted from /var, the root shell spawned by the attack would not 
have access either. (restrictions are enherited from parent to children).


Best regards, Kristian.
