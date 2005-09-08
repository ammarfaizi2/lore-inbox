Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932489AbVIHMuo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932489AbVIHMuo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 08:50:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932496AbVIHMuo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 08:50:44 -0400
Received: from mummy.ncsc.mil ([144.51.88.129]:58779 "EHLO jazzhorn.ncsc.mil")
	by vger.kernel.org with ESMTP id S932489AbVIHMuo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 08:50:44 -0400
Subject: Re: How is SELinux integrated into kernel 2.6?
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Xin Zhao <uszhaoxin@gmail.com>
Cc: Chris Wright <chrisw@osdl.org>, James Morris <jmorris@namei.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <4ae3c14050907234669ef3b6e@mail.gmail.com>
References: <4ae3c14050907234669ef3b6e@mail.gmail.com>
Content-Type: text/plain
Organization: National Security Agency
Date: Thu, 08 Sep 2005 08:47:47 -0400
Message-Id: <1126183667.1705.25.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-09-08 at 02:46 -0400, Xin Zhao wrote:
> Sorry if this question is dumb.
> 
> SELinux is included in 2.6. But I think it works by putting LSM hooks a lot
> of place in Linux and then it can define its own policy enforcement codes.
> 
> However, I cannot find hooks in kernel 2.6.9 and 2.6.11. How can
> SELinux work with kernel 2.6 to protect system without hooks?
> 
> Thanks in advance for your help!

The hooks are there, but possibly you are confused by the out-of-date
documentation (e.g. Documentation/DocBook/lsm.tmpl still says to look
for "security_ops->" in the core kernel for the hook calls, but they
have long since been replaced with calls to static inline functions
defined in include/linux/security.h).  As an example,
fs/namei.c:permission calls security_inode_permission, which is defined
in include/linux/security.h and will invoke the corresponding hook if
CONFIG_SECURITY=y.  SELinux provides its implementations of the hook
functions in security/selinux/hooks.c, e.g. selinux_inode_permission.
Hence, you should be looking for calls to functions with the security_
prefix instead of explicit references to security_ops in the core
kernel.

Chris - feel free to rip out lsm.tmpl and replace it with something more
up-to-date and complete.

-- 
Stephen Smalley
National Security Agency

