Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272869AbSISUUI>; Thu, 19 Sep 2002 16:20:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272935AbSISUUI>; Thu, 19 Sep 2002 16:20:08 -0400
Received: from kim.it.uu.se ([130.238.12.178]:45230 "EHLO kim.it.uu.se")
	by vger.kernel.org with ESMTP id <S272869AbSISUUH>;
	Thu, 19 Sep 2002 16:20:07 -0400
From: Mikael Pettersson <mikpe@csd.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15754.12963.763811.307755@kim.it.uu.se>
Date: Thu, 19 Sep 2002 22:25:07 +0200
To: Daniel Jacobowitz <dan@debian.org>
Cc: Brian Gerst <bgerst@didntduck.org>, Petr Vandrovec <VANDROVE@vc.cvut.cz>,
       "Richard B. Johnson" <root@chaos.analogic.com>,
       dvorak <dvorak@xs4all.nl>, linux-kernel@vger.kernel.org
Subject: Re: Syscall changes registers beyond %eax, on linux-i386
In-Reply-To: <20020919192434.GA3286@nevyn.them.org>
References: <24181C771D3@vcnet.vc.cvut.cz>
	<3D8A11BB.4090100@didntduck.org>
	<20020919192434.GA3286@nevyn.them.org>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Jacobowitz writes:
 > That's not going to help.  As Richard said, the memory in question
 > belongs to the called function.  GCC knows this.  It can freely modify
 > it.  The fact that the value of the parameter is const is a
 > language-level, semantic thing.  It doesn't say anything about the
 > const-ness of that memory.  Only the ABI does.

Does Linux/x86 even have a proper ABI document? I've never seen one.
The closest I've seen would be the SVR4 i386 psABI, but it
deliberately doesn't define the raw syscall interface, only the
each-syscall-is-a-C-function one implemented by the C library,
and that interface doesn't suffer from the current issue.

IOW, the kernel may not be at fault if user-space code invokes int
$0x80 directly and then sees clobbered registers.

/Mikael
