Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261450AbVACN6s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261450AbVACN6s (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 08:58:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261452AbVACN6s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 08:58:48 -0500
Received: from [144.51.25.10] ([144.51.25.10]:25547 "EHLO epoch.ncsc.mil")
	by vger.kernel.org with ESMTP id S261450AbVACN6n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 08:58:43 -0500
Subject: Re: Is CAP_SYS_ADMIN checked by every program !?
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Tetsuo Handa <from-linux-kernel@i-love.sakura.ne.jp>
Cc: lkml <linux-kernel@vger.kernel.org>, Chris Wright <chrisw@osdl.org>
In-Reply-To: <200412301640.FCB13564.FtFPMSMGJtSOLVOYN@i-love.sakura.ne.jp>
References: <200412291347.JEH41956.OOtStPFFNMLJVGMYS@i-love.sakura.ne.jp>
	 <9033584D-5A24-11D9-989E-000393ACC76E@mac.com>
	 <200412301640.FCB13564.FtFPMSMGJtSOLVOYN@i-love.sakura.ne.jp>
Content-Type: text/plain
Organization: National Security Agency
Message-Id: <1104760366.16598.40.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 03 Jan 2005 08:52:46 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-12-30 at 02:40, Tetsuo Handa wrote:
> I'm developing a kernel patch that provides simple and handy
> MAC(mandatory access control) functionality, much easier than SELinux.
> And now I'm porting the patch from 2.4 to 2.6,
> though the patch can't support LSM, for it refers 'struct vfsmount'.
> 
> At first, I doubted that some kernel function (do_execve(), memory management
> functions, or any kernel functions that are always called by every process) is
> doing this CAP_SYS_ADMIN checking. But may be this CAP_SYS_ADMIN checking is
> caused by the Fedora Core 3's libc, not by the kernel.
> I don't have 2.6 kernel environment other than Fedora Core 3.
> 
> But anyway, I have to give up checking for CAP_SYS_ADMIN .

Just override the vm_enough_memory security hook with your own function,
as we do in SELinux, to avoid auditing the CAP_SYS_ADMIN check there.
Note that this issue has also come up again on the linux-security-module
mailing list recently, and might be addressed through a change to the
cap_vm_enough_memory hook function.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

