Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964844AbWCACp2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964844AbWCACp2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 21:45:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964846AbWCACp2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 21:45:28 -0500
Received: from watts.utsl.gen.nz ([202.78.240.73]:44456 "EHLO mail.utsl.gen.nz")
	by vger.kernel.org with ESMTP id S964844AbWCACp0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 21:45:26 -0500
Message-ID: <44050AB7.7020202@vilain.net>
Date: Wed, 01 Mar 2006 15:45:11 +1300
From: Sam Vilain <sam@vilain.net>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Hauke Laging <mailinglisten@hauke-laging.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: VFS: Dynamic umask for the access rights of linked objects
References: <200603010328.42008.mailinglisten@hauke-laging.de>
In-Reply-To: <200603010328.42008.mailinglisten@hauke-laging.de>
X-Enigmail-Version: 0.92.1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hauke Laging wrote:
> I tried to send this to the VFS maintainer but the address I found on 
> http://www.kernelnewbies.org/maintainers/ and in 
> my /usr/src/linux/MAINTAINERS seems not to exist any more 
> (viro@parcelfarce.linux.theplanet.co.uk).
> 
> The complete version of the following text ist avaiable at 
> http://www.hauke-laging.de/ideen/symlink-umask/konzept_en.html
> 
> the problem
> (At least) If applications store data in directories which are 
> write-accessible by other users then symlink attacks become possible. A 
> file is erased and replaced by a symlink. The (buggy) application can be 
> abused if it can read or write the linked-to file but the abusing user 
> cannot. These attacks are mostly denial of service attacks.

Of course this doesn't work if, like /tmp and /var/tmp are shipped as on 
every distribution, the directory has permissions 1777.

But go on...

> Solution
> The kernel should be extended by a function (which can be enabled and 
> disabled) which would solve the problem. The access rights of a symlink 
> are ignored but its creator is stored. The kernel should do additional 
> checks when determining whether a file system object can be accessed in 
> the requested way:
> 
> - Is the accessed object a symlink?
> 
> - Has the creator of the symlink got the access rights which the respective 
> process is requesting?
> 
> If the situation turns out to be critical then the kernel would deny the 
> respective rights. The process cannot access the file via the symlink 
> though it could have if it had tried to access it directly. The access 
> rights of the symlink creator (through the whole path, not just for the 
> file) would be used as a mask for the applications rights.

What problem you are trying to solve?  Why does it matter what the 
ownership of the symlink is?

> This approach does not solve every kind of this problem but should be quite 
> easy to implement. I don't want this mail to get too long so I have left 
> out some considerations about hard links. See the URL.

Reading the page, the considerations about hard links seem quite off the 
mark.  If somebody creates a hard link to one of your files, it *is* the 
same file, just with a different name.  So it becomes the same problem 
as the first one.

That is, if I understand what you're saying correctly.  It's not very 
clear.  You should at least describe your envisioned scenario in a step 
by step basis, highlighting your concerns.

But frankly, see the FAQ answer to "I have discovered a huge security 
hole in rm!"

Sam.
