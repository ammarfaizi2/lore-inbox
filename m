Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262811AbTI2DFO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Sep 2003 23:05:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262814AbTI2DFO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Sep 2003 23:05:14 -0400
Received: from smtp-node1.eclipse.net.uk ([212.104.129.76]:5898 "EHLO
	smtp1.ex.eclipse.net.uk") by vger.kernel.org with ESMTP
	id S262811AbTI2DFI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Sep 2003 23:05:08 -0400
From: Ian Hastie <ianh@iahastie.clara.net>
To: Andries Brouwer <aebr@win.tue.nl>
Subject: Re: suid bit behaviour modification in 2.6.0-test5
Date: Mon, 29 Sep 2003 04:05:03 +0100
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org, bill davidsen <davidsen@tmr.com>
References: <3F6CF491.9030205@free.fr> <20030923195449.A1572@pclin040.win.tue.nl> <200309262341.32000.ianh@iahastie.local.net>
In-Reply-To: <200309262341.32000.ianh@iahastie.local.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309290405.05669.ianh@iahastie.local.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 26 Sep 2003 23:41, Ian Hastie wrote:
> Just did a slightly different test and got this from it...
>
> $ uname -a
> Linux iahastie 2.6.0-test5-bk13-athlon #1 Fri Sep 26 19:26:30 BST 2003 i686
> GNU/Linux
> $ touch suid_test
> $ ls -l
> total 0
> -rw-r--r--    1 ianh     ianh            0 Sep 26 23:16 suid_test
>
> # chown root suid_test
> # chmod 4775 suid_test
>
> $ ls -l
> total 0
> -rwsrwxr-x    1 root     ianh            0 Sep 26 23:16 suid_test
> $ cp /usr/bin/id suid_test
> $ ls -l
> total 16
> -rwsrwxr-x    1 root     ianh        13880 Sep 26 23:16 suid_test
> $ ./suid_test
> uid=1000(ianh) gid=1000(ianh) euid=0(root) groups=1000(ianh), ...
>
> Note it *does* come up as euid root.
>
> $ sync
> $ ls -l
> total 16
> -rwxrwxr-x    1 root     ianh        13880 Sep 26 23:16 suid_test
> $ ./suid_test
> uid=1000(ianh) gid=1000(ianh) groups=1000(ianh), ...
>
> But not after it has been synced.  Odd, but that's how it works.

Just tried it again with 2.6.0-test6.  Same initial results, but the suid bit 
didn't clear directly after a sync, so that's probably just a coincidence.  
Can't say for sure that there isn't some other change though.  The only 
certain thing here is that your suid bit fix doesn't work, at least not with 
XFS.

-- 
Ian.

