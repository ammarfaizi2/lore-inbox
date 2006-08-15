Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751420AbWHOCHE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751420AbWHOCHE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 22:07:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751456AbWHOCHD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 22:07:03 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:40081 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751420AbWHOCHA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 22:07:00 -0400
Date: Mon, 14 Aug 2006 21:06:47 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>,
       linux-security-module@vger.kernel.org, chrisw@sous-sol.org
Subject: Re: [RFC] [PATCH] file posix capabilities
Message-ID: <20060815020647.GB16220@sergelap.austin.ibm.com>
References: <20060730011338.GA31695@sergelap.austin.ibm.com> <20060814220651.GA7726@sergelap.austin.ibm.com> <m1r6zirgst.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1r6zirgst.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Eric W. Biederman (ebiederm@xmission.com):
> "Serge E. Hallyn" <serue@us.ibm.com> writes:
> 
> > Quoting Serge E. Hallyn (serue@us.ibm.com):
> >> This patch implements file (posix) capabilities.  This allows
> >> a binary to gain a subset of root's capabilities without having
> >> the file actually be setuid root.
> >> 
> >> There are some other implementations out there taking various
> >> approaches.  This patch keeps all the changes within the
> >> capability LSM, and stores the file capabilities in xattrs
> >> named "security.capability".  First question is, do we want
> >> this in the kernel?  Second is, is this sort of implementation
> >> we'd want?
> >> 
> >> Some userspace tools to manipulate the fscaps are at
> >> www.sr71.net/~hallyn/fscaps/.  For instance,
> >> 
> >> 	setcap writeroot "cap_dac_read_search,cap_dac_override+eip"
> >> 
> >> allows the 'writeroot' testcase to write to /root/ab when
> >> run as a normal user.
> >> 
> >> This patch doesn't address the need to update
> >> cap_bprm_secureexec().
> 
> Looking at your ondisk format it doesn't look like you include a
> version.  There is no reason to believe the current set of kernel
> capabilities is fixed for all time.

In fact my version knowingly ignores CAP_AUDIT_WRITE and
CAP_AUDIT_CONTROL (because on my little test .iso they didn't exist).
So a version number may make sense.

> So we need some for of
> forward/backward compatibility.  Maybe in the cap name?

You mean as in use 'security.capability_v32" for the xattr name?
Or do you really mean add a cap name to the structure?

thanks,
-serge
