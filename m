Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270001AbUJHPIH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270001AbUJHPIH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 11:08:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270005AbUJHPIH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 11:08:07 -0400
Received: from open.hands.com ([195.224.53.39]:16080 "EHLO open.hands.com")
	by vger.kernel.org with ESMTP id S270001AbUJHPIC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 11:08:02 -0400
Date: Fri, 8 Oct 2004 16:18:37 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Brian Gerst <bgerst@didntduck.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: how do you call userspace syscalls (e.g. sys_rename) from inside kernel
Message-ID: <20041008151837.GI5551@lkcl.net>
References: <20041008130442.GE5551@lkcl.net> <41669DE0.9050005@didntduck.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41669DE0.9050005@didntduck.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-hands-com-MailScanner: Found to be clean
X-hands-com-MailScanner-SpamScore: s
X-MailScanner-From: lkcl@lkcl.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 08, 2004 at 10:02:08AM -0400, Brian Gerst wrote:
> Luke Kenneth Casson Leighton wrote:
> >could someone kindly advise me on the location of some example code in
> >the kernel which calls one of the userspace system calls from inside the
> >kernel?
> >
> >alternatively if this has never been considered before, please could
> >someone advise me as to how it might be achieved?
> 
> What are you trying to do?  

 call sys_rename, sys_pread, sys_create, sys_mknod, sys_rmdir
 etc. - everything that does file access.

> In most cases needing to use syscalls from 
> within the kernel is an indication of a design flaw.  

 in this case it's an attempt to avoid cutting and pasting
 the entire contents of sys_rename, sys_pread, sys_this,
 sys_that, removing the first couple and last few lines (that
 do copy_from_user) and replacing the arguments with either
 a dentry or a kernel-side char* instead of an __user char*.

 my alternative is to patch every single vfs-related sys_* in fs/*.c to
 be able to "plug in" to these functions.

 l.

