Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264186AbTGGSe6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jul 2003 14:34:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264242AbTGGSe6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jul 2003 14:34:58 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:11281 "EHLO
	small.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S264186AbTGGSe5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jul 2003 14:34:57 -0400
Subject: Re: opening symlinks with O_CREAT under latest 2.5.74
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: LKML <linux-kernel@vger.kernel.org>, trond.myklebust@fys.uio.no
In-Reply-To: <20030707154628.GA3220@vana.vc.cvut.cz>
References: <20030707154628.GA3220@vana.vc.cvut.cz>
Content-Type: text/plain
Message-Id: <1057603769.907.3.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 07 Jul 2003 20:49:29 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-07-07 at 17:46, Petr Vandrovec wrote:
> Hi,
>   couple of things stopped working on my box
> where I have /dev/vc/XX as symlinks to /dev/ttyXX, and some
> things use /dev/vc/XX and some /dev/ttyXX. After last update
> hour ago things which use /dev/vc/XX stopped working for
> non-root - they now fail with EACCES error if they attempt
> to redirect its input or output through '>' or '<>' bash
> redirection operators:
> 
> $ touch /tmp/xx
> $ ln -s /tmp/xx yy
> $ cat > yy
> -bash: yy: Permission denied
> 
> Strace says:
> 
> [pid  3268] open("yy", O_WRONLY|O_CREAT|O_TRUNC|O_LARGEFILE, 0666) = -1 EACCES (Permission denied)
> 
> This command succeeds on kernel from thursday. Simillar problem is
> that
> 
> $ rm /tmp/xx
> $ ln -s /tmp/xx yy
> $ cat > yy
> -bash: yy: No such file or directory
> 
> while it creates /tmp/xx file on older kernels.
> 
>   Currently I suspect Trond's LOOKUP_CONTINUE change in 
> '[PATCH] Add open intent information to the 'struct nameidata', but I
> did not tried reverting it yet to find whether it is culprit or no. But
> other changes than these four from Trond looks completely innocent.

JFYI, on Red Hat 9, I'm having problems when using "vi" to edit a file
through a symbolic link. For example, I can't save changes with ":wq!"
in vi when editing "/etc/grub.conf" on my RHL9 box (which is a symbolic
link to "/boot/grub/grub.conf").

