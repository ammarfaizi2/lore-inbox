Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277622AbRJHXoY>; Mon, 8 Oct 2001 19:44:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277624AbRJHXoE>; Mon, 8 Oct 2001 19:44:04 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.29]:51466 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S277625AbRJHXn7>; Mon, 8 Oct 2001 19:43:59 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: "Oleg A. Yurlov" <kris@spylog.com>
Date: Tue, 9 Oct 2001 09:26:32 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15298.13864.971940.46509@notabene.cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: RAID sync
In-Reply-To: message from Oleg A. Yurlov on Monday October 1
In-Reply-To: <1101445461994.20011001182753@spylog.com>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday October 1, kris@spylog.com wrote:
> 
>         Kernel 2.4.6.SuSE-4GB-SMP, 2 CPU, 2Gb RAM, 4 HDD SCSI, M/B Intel L440GX.
> Messages from dmesg:
snip
> md: now!
> md: sdb2's event counter: 0000001c
> md: sda2's event counter: 0000001d
snip
> 
>         Why RAID do not start synchronization ? It is normal ?

Yes.
A difference of 1 in the event counters isn't considered enough to
treat on of them as old, and presumably the newest one (sda2) was
marked clean.
This could happen if the array was shut down cleanly, the new super
block (with the dirty bit cleared) was written to sda2, but the new
superblock was NOT written to sdb2 for some reason.  In this situation
there is no need to resync the array.

Could this be what happened in your case?

NeilBrown


> 
> --
> Oleg A. Yurlov aka Kris Werewolf, SysAdmin      OAY100-RIPN
> mailto:kris@spylog.com                          +7 095 332-03-88
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
