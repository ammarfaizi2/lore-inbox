Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271110AbTHGXrz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 19:47:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271116AbTHGXrz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 19:47:55 -0400
Received: from obsidian.spiritone.com ([216.99.193.137]:10436 "EHLO
	obsidian.spiritone.com") by vger.kernel.org with ESMTP
	id S271110AbTHGXrw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 19:47:52 -0400
Date: Thu, 07 Aug 2003 16:47:07 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
cc: Bill Irwin <wli@holomorphy.com>, Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.0-test2-mm5
Message-ID: <14340000.1060300025@[10.10.2.4]>
In-Reply-To: <20030806223716.26af3255.akpm@osdl.org>
References: <20030806223716.26af3255.akpm@osdl.org>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Andrew Morton <akpm@osdl.org> wrote (on Wednesday, August 06, 2003 22:37:16 -0700):

> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test2/2.6.0-test2-mm5/
> 
> 
> Lots of different things.  Mainly trying to get this tree stabilised again;
> there has been some breakage lately.

Mmmm. 4/4 split now boots again, but behaves rather oddly. This is with
Nick's AS fix, plus the 4/4 fix Andrew sent me last night, which I presume
is the same as what Bill sent out.

Difficult to tell what's going on exactly. For one, the machine has lost 
it's hostname, for another, it seems to have mounted the root fs readonly. 
End of the bootlog looks like this:

----------------------

EXT2-fs warning (device sda2): ext2_fill_super: mounting ext3 filesystem as ext2

VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 288k freed
INIT: version 2.84 booting
INIT: Entering runlevel: 2
Starting system log daemon: syslogdchmod: changing permissions of `/dev/xconsole': Read-only file system
/etc/init.d/rc: line 101:   118 Trace/breakpoint trap   $debug "$@"
Starting kernel log daemon: klogdstart-stop-daemon: nothing in /proc - not mounted?
/etc/init.d/rc: line 101:   120 Trace/breakpoint trap   $debug "$@"

Debian GNU/Linux testing/unstable (none) ttyS0

(none) login: 

------------------------

Mounting the ext3 root as ext2 is normal (it's hard to un-ext3 it
whilst standing on it). The debug stuff & loss of hostname is not.
Won't accept incoming ssh connections. I can sorta start to log in
on the serial console, but readonly-ness screws it:


(none) login: root
Password: 
login(pam_unix)[129]: session opened for user root by (uid=0)
Linux larry 2.6.0-test2-mm5 #1 SMP Thu Aug 7 07:28:59 PDT 2003 i686 unknown unknown GNU/Linux
Unable to change tty /dev/ttyS0: Read-only file system
login[129]: unable to change tty `/dev/ttyS0' for user `root'

login[129]: ROOT LOGIN  on `ttyS0'

Debian GNU/Linux testing/unstable (none) ttyS0

(none) login: 

----------------------------

If I can grab any more useful info, let me know ...

M.
