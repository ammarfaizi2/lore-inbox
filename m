Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262761AbTIVDZ1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Sep 2003 23:25:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262762AbTIVDZ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Sep 2003 23:25:27 -0400
Received: from ns2.eclipse.net.uk ([212.104.129.133]:54032 "EHLO
	smtp2.ex.eclipse.net.uk") by vger.kernel.org with ESMTP
	id S262761AbTIVDZ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Sep 2003 23:25:26 -0400
From: Ian Hastie <lkml@ordinal.freeserve.co.uk>
To: linux-kernel@vger.kernel.org
Subject: Re: suid bit behaviour modification in 2.6.0-test5
Date: Mon, 22 Sep 2003 04:25:19 +0100
User-Agent: KMail/1.5.3
References: <3F6CF491.9030205@free.fr>
In-Reply-To: <3F6CF491.9030205@free.fr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309220425.21862.lkml@ordinal.freeserve.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 21 Sep 2003 01:45, Jean-pierre Cartal wrote:
> Hello,
>
> I'm running a standard RH 9 installation upgraded to kernel 2.6.0-test5
> with rpms from http://people.redhat.com/arjanv/2.5/RPMS.kernel/.
>
> I noticed that contrary to what was happening with 2.4.x kernel, suid
> root files don't loose their suid bit when they get overwritten by a
> normal user (see example below)
>
> Is this the intended behaviour or a bug ?

I got the same results.  However it seems the bug is something to do with a 
directory listing cache somewhere.  If you sync after copying over the file 
the suid bit is shown as having been cleared.

$ touch suid_test

# chown root suid_test
# chmod 4775 suid_test

$ ls -l
total 0
-rwsrwxr-x    1 root     ianh            0 Sep 22 04:21 suid_test
$ cp /bin/ls suid_test
$ ls -l
total 68
-rwsrwxr-x    1 root     ianh        69228 Sep 22 04:22 suid_test
$ sync
$ ls -l
total 68
-rwxrwxr-x    1 root     ianh        69228 Sep 22 04:22 suid_test

-- 
Ian.

