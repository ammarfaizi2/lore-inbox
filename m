Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262776AbTC0CEk>; Wed, 26 Mar 2003 21:04:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262780AbTC0CEk>; Wed, 26 Mar 2003 21:04:40 -0500
Received: from cerebus.wirex.com ([65.102.14.138]:27120 "EHLO
	figure1.int.wirex.com") by vger.kernel.org with ESMTP
	id <S262776AbTC0CEk>; Wed, 26 Mar 2003 21:04:40 -0500
Date: Wed, 26 Mar 2003 18:14:09 -0800
From: Chris Wright <chris@wirex.com>
To: Jakub Jelinek <jakub@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: setfs[ug]id syscall return value and include/linux/security.h question
Message-ID: <20030326181409.B20611@figure1.int.wirex.com>
Mail-Followup-To: Jakub Jelinek <jakub@redhat.com>,
	linux-kernel@vger.kernel.org
References: <20030326181509.Q13397@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030326181509.Q13397@devserv.devel.redhat.com>; from jakub@redhat.com on Wed, Mar 26, 2003 at 06:15:09PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Jakub Jelinek (jakub@redhat.com) wrote:
> Hi!
> 
> Before include/linux/security.h was added, setfsuid/setfsgid always returned
> old_fsuid, no matter if the fsuid was actually changed or not.
> With the default security ops it seems to do the same, because both
> security_task_setuid and security_task_post_setuid return 0, but these are
> hooks which seem to return 0 on success, -errno on failure, so if some
> non-default security hook is installed and ever returns -errno
> in setfsuid/setfsgid, -errno will be returned from the syscall instead
> of the expected old_fsuid. This makes it hard to distinguish uids
> 0xfffff001 .. 0xffffffff from errors of security hooks.
> Shouldn't sys_setfsuid/sys_setfsgid be changed:

Yes, thanks for the patch.  I'll apply this to the LSM tree and push to
Linus with the next batch of changes.  It's unfortunate that the
sys_setfs[ug]id interface can't report an error.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
