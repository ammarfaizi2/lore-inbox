Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265093AbTAFSde>; Mon, 6 Jan 2003 13:33:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265190AbTAFSde>; Mon, 6 Jan 2003 13:33:34 -0500
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:56811
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id <S265093AbTAFSdd>; Mon, 6 Jan 2003 13:33:33 -0500
Message-ID: <3E19CE03.6090307@redhat.com>
Date: Mon, 06 Jan 2003 10:42:11 -0800
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3b) Gecko/20030102
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Luca Barbieri <ldb@ldb.ods.org>
CC: Linus Torvalds <torvalds@transmeta.com>,
       Linux-Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Set TIF_IRET in more places
References: <20030106144601.GA2447@ldb> <Pine.LNX.4.44.0301060755510.2084-100000@home.transmeta.com> <20030106181737.GA6867@ldb>
In-Reply-To: <20030106181737.GA6867@ldb>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Luca Barbieri wrote:

> 1. vfork seems to not set any TIF_ flags so a ptracer setting regs
> while a vforking task is stopped in ptrace_notify called from vfork
> would result in clobbered %ecx and %edx.


Just to be clear: the vfork syscall does not use sysenter.  It's not
possible with the current implementation.  The magic sysenter wrapping
code would have to recognize the syscall and handle it special by saving
the return address.  From glibc's POV the %edx register would be free
but I consider this interface far to fragile.

-- 
--------------.                        ,-.            444 Castro Street
Ulrich Drepper \    ,-----------------'   \ Mountain View, CA 94041 USA
Red Hat         `--' drepper at redhat.com `---------------------------

