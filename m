Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265002AbTGGPb4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jul 2003 11:31:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265021AbTGGPb4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jul 2003 11:31:56 -0400
Received: from vana.vc.cvut.cz ([147.32.240.58]:6016 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id S265002AbTGGPbz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jul 2003 11:31:55 -0400
Date: Mon, 7 Jul 2003 17:46:28 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: linux-kernel@vger.kernel.org
Cc: trond.myklebust@fys.uio.no
Subject: opening symlinks with O_CREAT under latest 2.5.74
Message-ID: <20030707154628.GA3220@vana.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
  couple of things stopped working on my box
where I have /dev/vc/XX as symlinks to /dev/ttyXX, and some
things use /dev/vc/XX and some /dev/ttyXX. After last update
hour ago things which use /dev/vc/XX stopped working for
non-root - they now fail with EACCES error if they attempt
to redirect its input or output through '>' or '<>' bash
redirection operators:

$ touch /tmp/xx
$ ln -s /tmp/xx yy
$ cat > yy
-bash: yy: Permission denied

Strace says:

[pid  3268] open("yy", O_WRONLY|O_CREAT|O_TRUNC|O_LARGEFILE, 0666) = -1 EACCES (Permission denied)

This command succeeds on kernel from thursday. Simillar problem is
that

$ rm /tmp/xx
$ ln -s /tmp/xx yy
$ cat > yy
-bash: yy: No such file or directory

while it creates /tmp/xx file on older kernels.

  Currently I suspect Trond's LOOKUP_CONTINUE change in 
'[PATCH] Add open intent information to the 'struct nameidata', but I
did not tried reverting it yet to find whether it is culprit or no. But
other changes than these four from Trond looks completely innocent.
					Thanks,
						Petr Vandrovec
						vandrove@vc.cvut.cz


