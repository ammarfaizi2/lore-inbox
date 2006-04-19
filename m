Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750743AbWDSM4E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750743AbWDSM4E (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 08:56:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750742AbWDSM4E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 08:56:04 -0400
Received: from iron1-mx.tops.gwu.edu ([128.164.127.227]:16313 "EHLO
	iron1-mx.tops.gwu.edu") by vger.kernel.org with ESMTP
	id S1750741AbWDSM4B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 08:56:01 -0400
X-SenderBase: 4.2
X-IronPort-AV: i="4.04,134,1144036800"; 
   d="scan'208"; a="257765072:sNHT26889880"
From: Yuichi Nakamura <ynakam@gwu.edu>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: Kurt Garloff <garloff@suse.de>, Christoph Hellwig <hch@infradead.org>,
       Gerrit Huizenga <gh@us.ibm.com>, James Morris <jmorris@namei.org>,
       Stephen Smalley <sds@tycho.nsa.gov>, casey@schaufler-ca.com,
       linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
       fireflier-devel@lists.sourceforge.net
Message-ID: <e133c9da8fcba.8fcbae133c9da@gwu.edu>
Date: Wed, 19 Apr 2006 08:55:56 -0400
X-Mailer: iPlanet Messenger Express 5.2 HotFix 2.09 (built Nov 18 2005)
MIME-Version: 1.0
Content-Language: en
Subject: Re: [RESEND][RFC][PATCH 2/7] implementation of LSM hooks
X-Accept-Language: en
In-Reply-To: <20060419121034.GE20481@sergelap.austin.ibm.com>
References: <20060417225525.GA17463@infradead.org>
 <E1FVfGt-0003Wy-00@w-gerrit.beaverton.ibm.com>
 <20060418115819.GB8591@infradead.org>
 <20060418213833.GC5741@tpkurt.garloff.de>
 <20060419121034.GE20481@sergelap.austin.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,it is my first post to the LSM list.

"Serge E. Hallyn" wrote:
> Have you ever tried, at 4pm some afternoon, sitting in a room with 
> somepaper and implementing the AA user interface on top of selinux?
We've implemented AppArmor like configuration on top of SELinux.
SELinux Policy Editor(http://seedit.sourceforge.net/) does this.
In its current development version(not released yet, only in CVS), 
Configuration for httpd is like below.

#####
{
domain httpd_t;
program /usr/sbin/httpd;
include common-relaxed.sp;
include daemon.sp;
include nameservice.sp;
allow /etc s;
allow /etc/httpd/** r,s;
allow /var/log/httpd/** r,a,s;
allow /var/www/** r,s;
allow /var s;
allow /var/run/** s;
allow /etc/php.d/** r,s;
allow /etc/php.ini r,s;
allow /etc/mime.types r,s;
allow /etc/pki/** r,s;
allownet -protocol tcp -port 80,443 server;
}
#####
Above is converted into SELinux Policy language.
Types, allow rules,domain transision rules are generated.
It works, and can also restrict IPC and privilege other than POSIX
capability(because it is based on SELinux).

However, path-name based configuration can not be achieved on SELinux in
following cases.
1) Files on file system that does not support xattr(such as sysfs)
   SELinux policy editor handles all files as same on such file systems.
2) Files that are dynamically created/deleted(inode number is not fixed).
   Example is files on /tmp and /etc/mtab. SELinux Policy Editor is
using file type transition to configure access control for them.


--
---
Yuichi Nakamura
Japan SELinux Users Group(JSELUG)
SELinux Policy Editor:  http://seedit.sourceforge.net/
