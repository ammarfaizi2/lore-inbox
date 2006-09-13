Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751633AbWIMGtv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751633AbWIMGtv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 02:49:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751637AbWIMGtv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 02:49:51 -0400
Received: from smtpout.mac.com ([17.250.248.171]:27884 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1751633AbWIMGtu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 02:49:50 -0400
In-Reply-To: <ee88af$fgo$1@taverner.cs.berkeley.edu>
References: <20060907182304.GA10686@danisch.de> <20060913043319.GH541@1wt.eu> <ee8589$e70$1@taverner.cs.berkeley.edu> <1BB4231A-7D69-4A77-A050-1C633BDFA545@mac.com> <ee88af$fgo$1@taverner.cs.berkeley.edu>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <B7C6636B-03E9-4D4C-AC0E-2898181F419B@mac.com>
Cc: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: R: Linux kernel source archive vulnerable
Date: Wed, 13 Sep 2006 02:49:45 -0400
To: daw-usenet@taverner.cs.berkeley.edu (David Wagner)
X-Mailer: Apple Mail (2.752.2)
X-Brightmail-Tracker: AAAAAQAAA+k=
X-Language-Identified: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 13, 2006, at 02:26:23, David Wagner wrote:
> Kyle Moffett  wrote:
>> On Sep 13, 2006, at 01:34:01, David Wagner wrote:
>>> So it sounds like git-tar-tree has a bug; its default isn't setting
>>> meaningful permissions on the files that it puts into the tar  
>>> archive.
>>> I hope the maintainers of git-tar-tree will consider fixing this  
>>> bug.
>>
>> Let me reiterate:  This is not a bug!
>
> I think it is a bug.  It sounds like git-tar-tree is storing the  
> wrong set of permissions in the tar archive.

No, git-tar-tree is storing the desired permissions (0666 and 0777)  
in the tar archive.  This is not a bug, those are actually the  
permissions we want in the tar archive.

> When I run "tar cf foo.tar bar", and bar has permissions 0644, then  
> tar inserts an entry into the archive for "bar" with its  
> permissions listed as 0644 (*not* 0666).

This is irrelevant because the actual permissions copied from GIT to  
the tar archive are 0666 (as desired).

> If "tar cf foo.tar bar" just ignored the permissions on bar and  
> always used a default of 0666 out of laziness, that would be a bug  
> in "tar cf". The same goes for git-tar-tree.  It seems to me that  
> git-tar-tree ought to behave the same as "tar cf".

It does; except the permissions in git are 0666 for files and 0777  
for directories so that your umask takes effect when you check out  
from GIT or extract a tar archive exported from GIT.

> In any case, regardless of whether this is by design or not, it is  
> not courteous to your users to distribute tar files where all the  
> files have permissions 0666.  That's not a user-friendly to do.

No, it is user-friendly.  This is like distributing programs who use  
open(..., 0666) when opening globally-readable files.  Programs that  
use open(..., 0644) are considered uncourteous because they  
intentionally ignore your umask.  The only cases where that is  
acceptable is user SSH private key files.  Likewise we store files  
with permissions 0666 in the tar archive so that the user's umask is  
applied to them properly.

o   Do *not* extract kernel trees as root
o   Do *not* build kernel trees as root
o   Do *not* package kernel trees as root
o   Do install kernel packages as root

It's that simple.  Please drop this discussion as it was brought up  
repeatedly on this list and the fairly general consensus is that this  
is not a bug in either the kernel source trees or GIT.

Cheers,
Kyle Moffett

