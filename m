Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933622AbWKWMaR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933622AbWKWMaR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 07:30:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933625AbWKWMaR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 07:30:17 -0500
Received: from wx-out-0506.google.com ([66.249.82.238]:62271 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S933622AbWKWMaP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 07:30:15 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=HArZIJDEaqRqI8ZA7sq1jOcVPsLYHO1bX/L7UDY47PF5DPZgywbKwkoaX8MAuYUJuXZOzNAvhbVa7XB4qMnuT+Crt2Ot5X4l+OH4CW8eJ7AxbGO3JxYVrq9Xk4JE+C7v0kk5vrP1EDOV16JIJJLGi92Nswwi8otpvUUoFdLI8cI=
Message-ID: <f36b08ee0611230430k9b2b625qc8d1b93031e09d14@mail.gmail.com>
Date: Thu, 23 Nov 2006 14:30:14 +0200
From: "Yakov Lerner" <iler.ml@gmail.com>
To: Kernel <linux-kernel@vger.kernel.org>
Subject: coping with swap-exhaustion in 2.4.33-4
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Where can I read anything about how kernel is supposed to
react to the 'swap-full' condition ? We have troubles on the
production machine which routinely arrives to the swap-full state
no matter how I increase the swap, because user proceses multi-fork
and then want to allocate a lot of virtual memory.

   I made a small test (below) and I run it as root and as non-root, having
two ssh sessions to the target machine (I run it as
as while true; do memstress; done ).

   Is the right solution in the kernel, or in the ulimiting the processes ?
I'm not sure what to do with forking, they fork many children ...
Is looking for kernel patches the right direction ? I want kernel not
to kill root-owned processes when non-root process is memory hog, but
that's not what I see.

Running my memstress, I see two things:
  1) if memory-hog process is non-root, then it is never killed
but hangs, and other pprocesses (which are root processes) are
killed instead of the mem-hog process.
  2) if memory-hog process is run as root, it is promptly
killed when swap is exhausted. Sometimes other processes
are killed, too (sshd server happen to be killed).

The (1) does not sound right for me. Is there a patch for it ?
Is there a redhat patch for this maybe ? Where can I find such
patches ?

Thanks
Yakov
