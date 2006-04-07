Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964873AbWDGSug@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964873AbWDGSug (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 14:50:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964879AbWDGSso
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 14:48:44 -0400
Received: from 216.255.188.82-custblock.intercage.com ([216.255.188.82]:1936
	"EHLO main.astronetworks.net") by vger.kernel.org with ESMTP
	id S964873AbWDGSsg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 14:48:36 -0400
From: =?utf-8?q?T=C3=B6r=C3=B6k_Edwin?= <edwin@gurde.com>
To: linux-security-module@vger.kernel.org
Subject: [RFC][PATCH 0/7] fireflier LSM for labeling sockets based on its creator (owner)
Date: Fri, 7 Apr 2006 21:24:23 +0300
User-Agent: KMail/1.9.1
Cc: James Morris <jmorris@namei.org>, linux-kernel@vger.kernel.org,
       fireflier-devel@lists.sourceforge.net, sds@tycho.nsa.gov
References: <200604021240.21290.edwin@gurde.com> <1144249591.25790.56.camel@moss-spartans.epoch.ncsc.mil> <200604072034.20972.edwin@gurde.com>
In-Reply-To: <200604072034.20972.edwin@gurde.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604072124.24000.edwin@gurde.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - main.astronetworks.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - gurde.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The purpose of the fireflier LSM is to "label" each socket with a context, 
where the context is a (list of) the program(s) that has/have access to it.

I've written fireflier LSM to allow filtering packets "per application". It is 
meant to be used only when SELinux is not available (not available/disabled 
at boot). For more details, see the initial discussion [1]

Summary of how fireflier LSM works:
- each program is associated a sid, depending on its mountpoint+inode, i.e. 2 
processes launched from the same program have the same sid
- each socket created by a processis labeled with the process's sid
- if 2 or more programs have access to the socket, it is labeled with a "group 
sid". A group sid contains a list of the sids of programs having access
- userspace, or iptables module can match packets on this "fireflier context"

As I stated in my previous mail, I intend to write a userspace policy module 
generator, that is to be used when selinux is enabled.
When it is disabled, then only would the fireflier lsm be used.

I am asking for your comments/suggestions on the following issues:
- security/correctness of the LSM (is there a way for a program to have access 
to a socket, and escaping the labeling?)
- how do I generate an SELinux policy, that does what this LSM module does?

If (and when) I succeed in writing this userspace policy generator, the 
fireflier lsm might be dropped, and replaced with the policy generator:
even if the user has no selinux policy & tools, he can use fireflier policy 
generator for labeling only, all he has to do, is boot with selinux=1.
However on many  distributions in that case a default policy is loaded, so we 
would have to deactivate that (we can't _require_ the user to actually have 
selinux set up). Not really a nice solution.
However dropping the lsm module can be done only in the fireflier 2.1, or 2.2 
it will most probably be included in fireflier 2.0 (currently in beta).
@Martin Maurer: what is your opinion on this?


Cheers,
Edwin
[1]http://www.uwsg.iu.edu/hypermail/linux/kernel/0604.0/0133.html
