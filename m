Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030224AbWILNe3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030224AbWILNe3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 09:34:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030226AbWILNe3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 09:34:29 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:38795 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1030224AbWILNe2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 09:34:28 -0400
Subject: Re: OT: calling kernel syscall manually
From: David Woodhouse <dwmw2@infradead.org>
To: guest01 <guest01@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <4506A295.6010206@gmail.com>
References: <4506A295.6010206@gmail.com>
Content-Type: text/plain
Date: Tue, 12 Sep 2006 14:34:04 +0100
Message-Id: <1158068045.9189.93.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-09-12 at 14:05 +0200, guest01 wrote:
> Hi
> 
> Sorry guys, this question is a little bit off topic, but maybe someone
> has an answer, I am sure that there is a simple one. :-)
> 
> Ok, I have to find 3 possibilities to create a directory with 3 small c
> programs:
> 1 -> using libc: mkdir(dir,mode)
> 2 -> using libcsyscall:  syscall(__NR_mkdir, "mkdirLibcSyscall", 0777);
> 3 -> using kernel directly
> 
> Ok, the third one is a little bit tricky, at least for me. I found an
> example for lseek, but I don't know how to convert that for mkdir. I
> don't know the necessary arguments, ..

The third one has always been broken on i386 for PIC code and was
pointless anyway, since glibc provides this functionality. The kernel
method has been removed from userspace visibility all architectures, and
we plan to remove it entirely in 2.6.19 since it's not at all useful. 

However, there was a patch which was sneaked to Linus in private which
reverted that cleanup on i386 and x86_64 and made them visible again --
but they'll be going away again on those two architectures shortly;
hopefully before 2.6.18.

Don't bother with it -- just use glibc's syscall().

-- 
dwmw2

