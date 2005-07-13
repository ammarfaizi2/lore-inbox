Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262543AbVGMBTj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262543AbVGMBTj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 21:19:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262430AbVGMBTi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 21:19:38 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:42377 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S262543AbVGMBSp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 21:18:45 -0400
Message-ID: <42D46BF4.4000207@namesys.com>
Date: Tue, 12 Jul 2005 18:18:44 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Vlad C." <vladc6@yahoo.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux On-Demand Network Access (LODNA)
References: <20050712234425.55899.qmail@web54409.mail.yahoo.com>
In-Reply-To: <20050712234425.55899.qmail@web54409.mail.yahoo.com>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You might look into SFS by David Mazieres, some concepts in it are
likely to interest you.

Hans

Vlad C. wrote:

>--- Hans Reiser <reiser@namesys.com> wrote:
>  
>
>>Please treat at greater length how your proposal
>>differs from NFS.
>>    
>>
>
>I think NFS is not flexible enough because:
>
>1) NFS requires synchronization of passwd files or
>NIS/LDAP to authenticate users (which themselves
>require root access on both server and client to
>install)
>2) NFS by definition understands only its own network
>protocol.
>3) NFS requires root privileges on the client to
>mount. I'm not aware of a way to let normal users
>mount an NFS partition other than listing it in the
>client's fstab and adding the 'users' option... but
>then changing fstab still requires root access.
>4) Users have to contact their sysadmin every time
>they want to mount a different partition, a different
>subdirectory of the same partition, or if they want to
>change the local mountpoint, all because the partition
>and mountpoint are hard-coded in fstab.
>
>On the other hand, I envision the following:
>
>1) No authentication layer required other than the
>authentication built into the protocol. All the user
>needs is the DNS/IP address of the server, a username,
>a password, a path on the server, and a local
>directory they own to act as a mountpoint. Note that
>the user's identity on the server is not tied to his
>identity on the client, as it is the case with NFS,
>but rather the user can chose which username to
>"Connect As" when he performs the mount.
>2) Support for multiple network protocols.
>3) No need for root privileges when choosing what to
>mount and where to mount. Some may say this is a
>security risk, but I see it as improved usability.
>After all, DE-level implementations like KDE's fish:/
>don't require root privileges either. Nevertheless, I
>think there should be some sort of switch where the
>sysadmin can allow/deny user mounting on a global or
>per user basis  (rather than a per fstab-line basis).
>
>Reasons 3 and 4 for why NFS is not flexible enough
>could also apply to the current Linux implementation
>of smbfs, which leads me to believe that part of the
>problem lies in the fact that users can't mount
>locations that aren't explicitly listed in fstab. I
>guess a per fstab-line basis of allowing mounts makes
>sense when there are a finite number of devices, but
>it doesn't make much sense when there are an infinite
>number of network addresses. I'm just thinking out
>loud here, but would it be possible to specify ranges
>of addresses and directories using wildcards? Such a
>line in fstab would look like:
>*.myhost.com:/home/* /home/* nfs
>rsize=8192,wsize=8192,timeo=14,users
>
>In this case, users could do:
>mount -t nfs host1.myhost.com:/home/username
>~/remote_home
>
>but they couldn't do:
>mount -t nfs host1.myhost.com:/tmp ~/remote_tmp
>
>After receiving several suggestions, it appears that
>FUSE (http://fuse.sourceforge.net/) and the various
>projects that build on it
>(http://fuse.sourceforge.net/filesystems.html) have
>the potential to do a lot of what I had envisioned
>LODNA doing. Therefore, I realize that there's
>probably no need for yet another VFS framework ;)
>Nevertheless, I think there is room for improvement
>when it comes to giving users more flexibility in
>mounting network locations (as described above).
>
>Thanks,
>Vlad
>
>__________________________________________________
>Do You Yahoo!?
>Tired of spam?  Yahoo! Mail has the best spam protection around 
>http://mail.yahoo.com 
>
>
>  
>

