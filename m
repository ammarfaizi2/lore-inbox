Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266968AbTAFPKg>; Mon, 6 Jan 2003 10:10:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266987AbTAFPKf>; Mon, 6 Jan 2003 10:10:35 -0500
Received: from hell.ascs.muni.cz ([147.251.60.186]:11136 "EHLO
	hell.ascs.muni.cz") by vger.kernel.org with ESMTP
	id <S266968AbTAFPKf>; Mon, 6 Jan 2003 10:10:35 -0500
Date: Mon, 6 Jan 2003 16:19:08 +0100
From: Lukas Hejtmanek <xhejtman@mail.muni.cz>
To: Jan Kara <jack@suse.cz>
Cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.54 - quota support
Message-ID: <20030106151908.GA640@mail.muni.cz>
References: <20030106003801.GA522@mail.muni.cz> <3E18E2F0.1F6A47D0@digeo.com> <20030106103656.GA508@mail.muni.cz> <20030106144842.GD24714@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030106144842.GD24714@atrey.karlin.mff.cuni.cz>
User-Agent: Mutt/1.4i
X-Muni: zakazka, vydelek, firma, komerce, vyplata
X-echelon: NSA, CIA, CI5, MI5, FBI, KGB, BIS, Plutonium, Bin Laden, Mossad, Iraq, Pentagon, WTC, president, assassination, A-bomb, kua, vic joudu uz neznam
X-policie-CR: Neserte mi nebo ukradnu, vyloupim, vybouchnu, znasilnim, zabiju, podpalim, umucim, podriznu, zapichnu a vubec vsechno
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 06, 2003 at 03:48:43PM +0100, Jan Kara wrote:
>   I seems like quotaon (or better quotactl()) waits on some lock
> forever... I'll try to reproduce it but in the mean time can you print
> list of processes, write down a few addresses from the top of the stack
> of quotaon and try to match it in the system.map to function in which
> is process stuck?

according to strace quotaon freezes at
quotactl(0xff800002, "/dev/hda1", 2

call trace is: (sysrq-t)
vfs_permission
__rwsem_do_wake
rwsem_down_read_failed
module_put
dqinit_needed
vfs_quota_off
resolve_dev
d_free
deny_write_access
check_quotactl_valid
d_free
scheduling_functions_start_here
do_quotactl
system_call


Btw, freeze on quotaon is not regular. After some time that system is up,
quotaon reports only no such device and terminates.

so looks like
1) freeze on quotactl
2) reports no such device

in both cases not working.

-- 
Luká¹ Hejtmánek
