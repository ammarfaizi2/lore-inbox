Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750801AbWDSGkm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750801AbWDSGkm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 02:40:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750796AbWDSGkm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 02:40:42 -0400
Received: from smtpout.mac.com ([17.250.248.177]:17874 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1750780AbWDSGkl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 02:40:41 -0400
In-Reply-To: <20060419014857.35628.qmail@web36606.mail.mud.yahoo.com>
References: <20060419014857.35628.qmail@web36606.mail.mud.yahoo.com>
Mime-Version: 1.0 (Apple Message framework v746.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <CD11FD59-4E2E-4AD7-9DD0-5811CE792B24@mac.com>
Cc: James Morris <jmorris@namei.org>, linux-security-module@vger.kernel.org,
       linux-kernel@vger.kernel.org, fireflier-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [RESEND][RFC][PATCH 2/7] implementation of LSM hooks
Date: Wed, 19 Apr 2006 02:40:25 -0400
To: casey@schaufler-ca.com
X-Mailer: Apple Mail (2.746.3)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Apr 18, 2006, at 21:48:56, Casey Schaufler wrote:
> --- James Morris <jmorris@namei.org> wrote:
>> With pathnames, there is an unbounded and unknown number of  
>> effective security policies on the system, as there are an
>> unbounded and unknown number of ways of viewing the files via  
>> pathnames.
>
> I agree that for traditional DAC and MAC (including the flavors  
> supported by SELinux) inodes is the only way to go. SELinux is a  
> traditional Trusted OS architecture and addresses the traditional  
> Trusted OS issues.

Perhaps the SELinux model should be extended to handle (dir-inode,  
path-entry) pairs.  For example, if I want to protect the /etc/shadow  
file regardless of what tool is used to safely modify it, I would set  
up security as follows:

o  Protect the "/" and "/etc" directory inodes as usual under SELinux  
(with attributes on directory inodes).
o  Create pairs with (etc_inode,"shadow") and (etc_inode,"gshadow")  
and apply security attributes to those potentially nonexistent pairs.

I'm not terribly familiar with the exact internal semantics of  
SELinux, but that should provide a 90% solution (it fixes bind mounts  
and namespaces).  The remaining 2 issues are hardlinks and fd- 
passing.  For hardlinks you don't care about other links to that  
data, you're concerned with protecting a particular filesystem  
location, not particular contents, so you just need to prevent _new_  
hardlinks to a protected (dir_inode, path_elem) pair, which doesn't  
seem very hard.  For fd-passing, I don't know what to do.  Perhaps  
nothing.

Anyways, just a few ideas for consideration

Cheers,
Kyle Moffett

