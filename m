Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129267AbRACVu0>; Wed, 3 Jan 2001 16:50:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129324AbRACVuQ>; Wed, 3 Jan 2001 16:50:16 -0500
Received: from [64.64.109.142] ([64.64.109.142]:8971 "EHLO quark.didntduck.org")
	by vger.kernel.org with ESMTP id <S129267AbRACVuG>;
	Wed, 3 Jan 2001 16:50:06 -0500
Message-ID: <3A539E27.E101ED30@didntduck.org>
Date: Wed, 03 Jan 2001 16:48:23 -0500
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.73 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Dan Aloni <karrde@callisto.yi.org>
CC: linux-kernel <linux-kernel@vger.kernel.org>, mark@itsolve.co.uk
Subject: Re: [RFC] prevention of syscalls from writable segments, breaking 
 bugexploits
In-Reply-To: <Pine.LNX.4.21.0101032259550.20246-100000@callisto.yi.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Aloni wrote:
> 
> It is known that most remote exploits use the fact that stacks are
> executable (in i386, at least).
> 
> On Linux, they use INT 80 system calls to execute functions in the kernel
> as root, when the stack is smashed as a result of a buffer overflow bug in
> various server software.
> 
> This preliminary, small patch prevents execution of system calls which
> were executed from a writable segment. It was tested and seems to work,
> without breaking anything. It also reports of such calls by using printk.

Do you realise how much overhead you just added to every single
syscall?  It won't work anyways, for the same reasons every other
non-exec stack patch has been rejected - exploits exist that don't write
any code to the stack, you just need two pointers.

--

				Brian Gerst
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
