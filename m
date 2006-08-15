Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932749AbWHOAU1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932749AbWHOAU1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 20:20:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932746AbWHOAU1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 20:20:27 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:22237 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932745AbWHOAU0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 20:20:26 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>, linux-security-module@vger.kernel.org,
       chrisw@sous-sol.org
Subject: Re: [RFC] [PATCH] file posix capabilities
References: <20060730011338.GA31695@sergelap.austin.ibm.com>
	<20060814220651.GA7726@sergelap.austin.ibm.com>
Date: Mon, 14 Aug 2006 18:20:02 -0600
In-Reply-To: <20060814220651.GA7726@sergelap.austin.ibm.com> (Serge
	E. Hallyn's message of "Mon, 14 Aug 2006 17:06:51 -0500")
Message-ID: <m1r6zirgst.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Serge E. Hallyn" <serue@us.ibm.com> writes:

> Quoting Serge E. Hallyn (serue@us.ibm.com):
>> This patch implements file (posix) capabilities.  This allows
>> a binary to gain a subset of root's capabilities without having
>> the file actually be setuid root.
>> 
>> There are some other implementations out there taking various
>> approaches.  This patch keeps all the changes within the
>> capability LSM, and stores the file capabilities in xattrs
>> named "security.capability".  First question is, do we want
>> this in the kernel?  Second is, is this sort of implementation
>> we'd want?
>> 
>> Some userspace tools to manipulate the fscaps are at
>> www.sr71.net/~hallyn/fscaps/.  For instance,
>> 
>> 	setcap writeroot "cap_dac_read_search,cap_dac_override+eip"
>> 
>> allows the 'writeroot' testcase to write to /root/ab when
>> run as a normal user.
>> 
>> This patch doesn't address the need to update
>> cap_bprm_secureexec().

Looking at your ondisk format it doesn't look like you include a
version.  There is no reason to believe the current set of kernel
capabilities is fixed for all time.  So we need some for of
forward/backward compatibility.  Maybe in the cap name?

Eric
