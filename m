Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261413AbVCHEyB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261413AbVCHEyB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 23:54:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261543AbVCHEyB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 23:54:01 -0500
Received: from adsl-110-19.38-151.net24.it ([151.38.19.110]:19656 "HELO
	develer.com") by vger.kernel.org with SMTP id S261413AbVCHExw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 23:53:52 -0500
Message-ID: <422D2FDE.2090104@develer.com>
Date: Tue, 08 Mar 2005 05:53:50 +0100
From: Bernardo Innocenti <bernie@develer.com>
User-Agent: Mozilla Thunderbird  (X11/20041216)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
CC: Neil Conway <nconway_kernel@yahoo.co.uk>, nfs@lists.sourceforge.net
Subject: NFS client bug in 2.6.8-2.6.11
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This problem was previously described by Neil Conway.
All relevant information here:

  http://lkml.org/lkml/2005/2/10/97


I still see this very same problem on 2.6.11 vanilla and in
Fedora/RawHide hernels.  It has haunted me for a couple of
months on several Fedora clients.  Strangely, a Gentoo
client isn't affected, but I couldn't investigate further.

When the current directory becomes inaccessible, it remains
so until I cd somewhere else and then cd back to it.
Sometimes I must wait a few seconds before cd succeeds.

Here's a sample session:

 [executing a find / in another shell to trigger the bug]
 beetle:/pub/linux/distro/fedora-devel# ll
 ls: .: No such file or directory
 beetle:/pub/linux/distro/fedora-devel# cd -
 /
 beetle:/# cd -
 bash: cd: /pub/linux/distro/fedora-devel: No such file or directory
 beetle:/#
 [...a few seconds later...]
 beetle:/# cd -
 /pub/linux/distro/fedora-devel


Appears to be a client bug.  The problem only happens
when there's heavy filesystem activity on other
filesystems (local or NFS).

NFS mount options: rw,_netdev,rsize=32768,wsize=32768,hard,intr,proto=udp,addr=10.3.3.1

-- 
  // Bernardo Innocenti - Develer S.r.l., R&D dept.
\X/  http://www.develer.com/

