Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269208AbUJMP3r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269208AbUJMP3r (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Oct 2004 11:29:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269190AbUJMP3r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Oct 2004 11:29:47 -0400
Received: from facesaver.epoch.ncsc.mil ([144.51.25.10]:33021 "EHLO
	epoch.ncsc.mil") by vger.kernel.org with ESMTP id S269102AbUJMP3d
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Oct 2004 11:29:33 -0400
Subject: Re: [patch 2/3] lsm: add bsdjail module
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: Ulrich Drepper <drepper@redhat.com>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20041013012206.GA368@IBM-BWN8ZTBWA01.austin.ibm.com>
References: <1097094103.6939.5.camel@serge.austin.ibm.com>
	 <1097094270.6939.9.camel@serge.austin.ibm.com>
	 <20041006162620.4c378320.akpm@osdl.org>
	 <20041007190157.GA3892@IBM-BWN8ZTBWA01.austin.ibm.com>
	 <20041010104113.GC28456@infradead.org>
	 <1097502444.31259.19.camel@localhost.localdomain>
	 <20041012131124.GA2484@IBM-BWN8ZTBWA01.austin.ibm.com>
	 <416C5C26.9020403@redhat.com>
	 <20041013005856.GA3364@IBM-BWN8ZTBWA01.austin.ibm.com>
	 <416C8048.1000602@redhat.com>
	 <20041013012206.GA368@IBM-BWN8ZTBWA01.austin.ibm.com>
Content-Type: text/plain
Organization: National Security Agency
Message-Id: <1097681181.32468.291.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 13 Oct 2004 11:26:21 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-10-12 at 21:22, Serge E. Hallyn wrote:
> Then they would have to check for an optional "selinux: " at the front
> of each security_setprocattr entry read in the kernel, in order to handle
> an lsm infrastructure change which might never be accepted into the kernel
> anyway.  I suppose it's pretty trivial anyway, but then why would they
> bother...

The changes to libselinux and procps and any scripts that directly
access /proc/pid/attr to deal with multi-entry values would be more
important; changing the kernel to prepend "selinux: " on getprocattr and
to strip it on setprocattr would indeed be trivial (but one wonders
whether we can be confident that userspace will never try to pass one of
these multi-entry values read from /proc/pid/attr to another interface
that expects a single context, e.g. selinuxfs or
setxattr("security.selinux")).

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

