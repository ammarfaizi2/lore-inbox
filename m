Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932382AbWE3Sju@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932382AbWE3Sju (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 14:39:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932383AbWE3Sju
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 14:39:50 -0400
Received: from wr-out-0506.google.com ([64.233.184.224]:46815 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932382AbWE3Sjs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 14:39:48 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=swbzc32m+eZswBTtYDM+m1m7v7cTkJ5bjhRjuWXikqu6m7EvLidUJSqyyksfFPYa2mpALvYP6+EVnhEOkKuUonEKy4AIFsUpj7D8ccjmUO8dpFAnXOwYliCYI71Zg8NsMxN6uWTJINHrVwW6EuzO+eqrSegIkA1ZIyla3yHGl14=
Message-ID: <6bffcb0e0605301139l2b4895d0mbecffb422fb2c0cf@mail.gmail.com>
Date: Tue, 30 May 2006 20:39:48 +0200
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: 2.6.17-rc5-mm1
Cc: "Ingo Molnar" <mingo@elte.hu>, "Arjan van de Ven" <arjan@linux.intel.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060530022925.8a67b613.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060530022925.8a67b613.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 30/05/06, Andrew Morton <akpm@osdl.org> wrote:
>
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17-rc5/2.6.17-rc5-mm1/
>

I get this on 2.6.17-rc5-mm1 + hot fixes + Arjan's net/ipv4/igmp.c patch.

May 30 20:25:56 ltg01-fedora kernel:
May 30 20:25:56 ltg01-fedora kernel:
=====================================================
May 30 20:25:56 ltg01-fedora kernel: [ BUG: possible circular locking
deadlock detected! ]
May 30 20:25:56 ltg01-fedora kernel:
-----------------------------------------------------
May 30 20:25:56 ltg01-fedora kernel: umount/2322 is trying to acquire lock:
May 30 20:25:56 ltg01-fedora kernel:  (sb_security_lock){--..}, at:
[<c01d6400>] selinux_sb_free_security+0x17/0x4e
May 30 20:25:56 ltg01-fedora kernel:
May 30 20:25:56 ltg01-fedora kernel: but task is already holding lock:
May 30 20:25:56 ltg01-fedora kernel:  (sb_lock){--..}, at:
[<c0178a89>] put_super+0x10/0x24
May 30 20:25:56 ltg01-fedora kernel:
May 30 20:25:56 ltg01-fedora kernel: which lock already depends on the new lock,
May 30 20:25:56 ltg01-fedora kernel: which could lead to circular deadlocks!
May 30 20:25:56 ltg01-fedora kernel:
May 30 20:25:56 ltg01-fedora kernel: the existing dependency chain (in
reverse order) is:
May 30 20:25:56 ltg01-fedora kernel:
May 30 20:25:56 ltg01-fedora kernel: -> #1 (sb_lock){--..}:
May 30 20:25:56 ltg01-fedora kernel:        [<c0139a56>]
lockdep_acquire+0x69/0x82
May 30 20:25:56 ltg01-fedora kernel:        [<c02f2171>] _spin_lock+0x21/0x2f
May 30 20:25:56 ltg01-fedora kernel:        [<c01d72de>]
selinux_complete_init+0x45/0xda
May 30 20:25:56 ltg01-fedora kernel:        [<c01e0a4e>]
security_load_policy+0xb3/0x22d
May 30 20:25:56 ltg01-fedora kernel:        [<c01da975>]
sel_write_load+0xa3/0x2a1
May 30 20:25:56 ltg01-fedora kernel:        [<c0172e2a>] vfs_write+0xcd/0x179
May 30 20:25:56 ltg01-fedora kernel:        [<c01734d3>] sys_write+0x3b/0x71
May 30 20:25:56 ltg01-fedora kernel:        [<c02f2aa5>]
sysenter_past_esp+0x56/0x8d
May 30 20:25:56 ltg01-fedora kernel:
May 30 20:25:56 ltg01-fedora kernel: other info that might help us debug this:
May 30 20:25:56 ltg01-fedora kernel:
May 30 20:25:56 ltg01-fedora kernel: 1 locks held by umount/2322:
May 30 20:25:56 ltg01-fedora kernel:  #0:  (sb_lock){--..}, at:
[<c0178a89>] put_super+0x10/0x24
May 30 20:25:56 ltg01-fedora kernel:
May 30 20:25:56 ltg01-fedora kernel: stack backtrace:
May 30 20:25:56 ltg01-fedora kernel:  [<c0103e52>] show_trace_log_lvl+0x4b/0xf4
May 30 20:25:56 ltg01-fedora kernel:  [<c01044b3>] show_trace+0xd/0x10
May 30 20:25:56 ltg01-fedora kernel:  [<c010457b>] dump_stack+0x19/0x1b
May 30 20:25:56 ltg01-fedora kernel:  [<c0138bd6>]
print_circular_bug_tail+0x59/0x64
May 30 20:25:56 ltg01-fedora kernel:  [<c0139429>] __lockdep_acquire+0x848/0xa39
May 30 20:25:56 ltg01-fedora kernel:  [<c0139a56>] lockdep_acquire+0x69/0x82
May 30 20:25:56 ltg01-fedora kernel:  [<c02f2171>] _spin_lock+0x21/0x2f
May 30 20:25:56 ltg01-fedora kernel:  [<c01d6400>]
selinux_sb_free_security+0x17/0x4e
May 30 20:25:56 ltg01-fedora kernel:  [<c0178a68>] __put_super+0x24/0x35
May 30 20:25:56 ltg01-fedora kernel:  [<c0178a90>] put_super+0x17/0x24
May 30 20:25:56 ltg01-fedora kernel:  [<c01793a3>] deactivate_super+0xa3/0xad
May 30 20:25:56 ltg01-fedora kernel:  [<c018e010>] mntput_no_expire+0x52/0x85
May 30 20:25:56 ltg01-fedora kernel:  [<c017fcb0>]
path_release_on_umount+0x15/0x18
May 30 20:25:56 ltg01-fedora kernel:  [<c018f535>] sys_umount+0x292/0x2aa
May 30 20:25:56 ltg01-fedora kernel:  [<c018f55a>] sys_oldumount+0xd/0xf
May 30 20:25:56 ltg01-fedora kernel:  [<c02f2aa5>] sysenter_past_esp+0x56/0x8d

Here is config
http://www.stardust.webpages.pl/files/mm/2.6.17-rc5-mm1/mm-config2

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)
