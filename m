Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263158AbTLAFhr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Dec 2003 00:37:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263166AbTLAFhr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Dec 2003 00:37:47 -0500
Received: from m17.lax.untd.com ([64.136.30.80]:19634 "HELO m17.lax.untd.com")
	by vger.kernel.org with SMTP id S263158AbTLAFhq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Dec 2003 00:37:46 -0500
To: hugh@veritas.com
Cc: linux-kernel@vger.kernel.org
Date: Sun, 30 Nov 2003 18:59:11 -0800
Subject: Re: Oops with tmpfs on both 2.4.22 & 2.6.0-test11
Message-ID: <20031130.185915.-1591395.7.mcmechanjw@juno.com>
X-Mailer: Juno 5.0.33
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Juno-Line-Breaks: 0-11,13-15,17-27,29-37
From: James W McMechan <mcmechanjw@juno.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, I have a test program  which will generate the Oops easily.
No maintainer was listed for tmpfs and the best Google reference is
about 2 years back, and it does not seem to be about this issue.

This Oops both 2.4.22 and 2.6.0-test11
It results from a ARCH=um bugreport and I kept making the
test program shorter, now down to one executable line.

It oops with the list poison address on 2.6.0-test11
Neither myself nor William Lee Irwin III know what the
list_del(q);
list_add(q, &dentry->d_subdirs);
from fs/libfs.c:90 or 137 is intended to do but he suggested you might
know
I think that is where it is corrupting the list entries.

/* by James_McMechan at hotmail com */                                   
      
/* test2 program to Oops shmfs mounted at /dev/shm */
/* yes it is dumb but unprivileged users should not be able */
/* to Oops the kernel regardless of how dumb the program */
#include <sys/types.h>
#include <dirent.h>
main()
{/* off 0 is "." off 1 is ".." off 2 is empty */
        seekdir(opendir("/dev/shm"), (off_t) 2);
}

On Sun, 30 Nov 2003 20:51:01 -0800 William Lee Irwin III
<wli@holomorphy.com> writes:
> On Sun, Nov 30, 2003 at 06:06:41PM -0800, James W McMechan wrote:
> > Have you got a suggestion on who to bug, I have not found
> > maintainers on tmpfs or now the libfs section.
> 
> Hugh Dickins is highly clueful and generally maintains tmpfs. He's
> fixed bugs in fs/libfs.c before, too.
> 
> 
> -- wli

________________________________________________________________
The best thing to hit the internet in years - Juno SpeedBand!
Surf the web up to FIVE TIMES FASTER!
Only $14.95/ month - visit www.juno.com to sign up today!
