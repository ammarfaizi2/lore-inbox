Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932311AbWDRUO5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932311AbWDRUO5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 16:14:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932313AbWDRUO5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 16:14:57 -0400
Received: from 216.255.188.82-custblock.intercage.com ([216.255.188.82]:50109
	"EHLO main.astronetworks.net") by vger.kernel.org with ESMTP
	id S932311AbWDRUO4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 16:14:56 -0400
From: =?iso-8859-2?q?T=F6r=F6k_Edwin?= <edwin@gurde.com>
To: fireflier-devel@lists.sourceforge.net
Subject: Re: [Fireflier-devel] Re: [RESEND][RFC][PATCH 2/7] implementation of LSM hooks
Date: Tue, 18 Apr 2006 23:13:05 +0300
User-Agent: KMail/1.9.1
Cc: Arjan van de Ven <arjan@infradead.org>, Crispin Cowan <crispin@novell.com>,
       Karl MacMillan <kmacmillan@tresys.com>, Gerrit Huizenga <gh@us.ibm.com>,
       Christoph Hellwig <hch@infradead.org>, James Morris <jmorris@namei.org>,
       "Serge E. Hallyn" <serue@us.ibm.com>,
       Stephen Smalley <sds@tycho.nsa.gov>, casey@schaufler-ca.com,
       linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
References: <E1FVtPV-0005zu-00@w-gerrit.beaverton.ibm.com> <44453E7B.1090009@novell.com> <1145389813.2976.47.camel@laptopd505.fenrus.org>
In-Reply-To: <1145389813.2976.47.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604182313.05604.edwin@gurde.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - main.astronetworks.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - gurde.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 18 April 2006 22:50, Arjan van de Ven wrote:
>
> I would suspect that the "filename" thing will be the biggest achilles
> heel...
> after all what does filename mean in a linux world with
> * hardlinks
> * chroot
> * namespaces
> * bind mounts
> * unlink of open files
> * fd passing over unix sockets
> * relative pathnames
> * multiple threads (where one can unlink+replace file while the other is
> in the validation code)

FYI fireflier v1.1.x created rules based on filenames.
In the current version we intended to use mountpoint+inode to identify 
programs. This reduces the potential problems from your list to: fd passing.

Can't AppArmor use inodes in addition to filenames to implement its rules? 
The user could still make its choice based on a "filename" (in an interactive 
userspace program), but by storing additional info along with the filename in 
the rules it would at least uniquely identify the program. 
(P.S.: I don't know how apparmor works, so what i said might not be directly 
applicable).

Note, that since fireflier is going to use SELinux (as soon as I get the 
policy done) program identification isn't shouldn't be a  problem for 
fireflier, but we still have two alternatives:

- use extended attributes to label files, using selinux's setfiles. Most 
secure option IMHO
(BTW can SELinux be told to use another xattr instead of security.selinux? 
Purpose: having multiple policies, and switching between them without the 
need to relabel, i.e. switching between a distro-provided policy/ a custom 
policy/ a fireflier generated policy)

- store rules based on mountpoint+inode+program hash/checksum, and then get 
selinux to label files according to this. Not sure how to do this, and if it 
is worth at all


Cheers,
Edwin
