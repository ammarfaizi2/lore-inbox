Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267101AbTBDCoi>; Mon, 3 Feb 2003 21:44:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267102AbTBDCoi>; Mon, 3 Feb 2003 21:44:38 -0500
Received: from fubar.phlinux.com ([216.254.54.154]:21172 "EHLO
	fubar.phlinux.com") by vger.kernel.org with ESMTP
	id <S267101AbTBDCog>; Mon, 3 Feb 2003 21:44:36 -0500
Date: Mon, 3 Feb 2003 18:54:03 -0800 (PST)
From: Matt C <wago@phlinux.com>
To: Nohez <nohez@cmie.com>
Cc: linux-kernel@vger.kernel.org, <bgana@cmie.com>
Subject: Re: timer interrupts on HP machines
In-Reply-To: <Pine.LNX.4.33.0302031706090.28669-100000@venus.cmie.ernet.in>
Message-ID: <Pine.LNX.4.44.0302031851470.4764-100000@fubar.phlinux.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nohez:

That's interesting. We've traced almost all of the times when this happens 
back to an incorrect MP spec. I know it sounds goofy, but have you tried 
unplugging AC power from the machine for ~5 minutes or so? We've seen that 
make a difference in the Netservers. Also make sure you're up-to-date with 
the firmware (latest is 4.06.43 or so?). Outside of that, I don't have any 
other suggestions besides calling HP and having them replace the system 
board.

-Matt

On Mon, 3 Feb 2003, Nohez wrote:

> 
> We have a similar problem with our HP servers. We are facing this problem
> for more than a year. We have reported this problem to HP support.
> 
> We have five HP Netserver LH6000 running k_smp-2.4.18-47 (SuSE7.1).
> We are sure that MP spec is v1.4 in the BIOS.  But we have not
> checked /proc/interrupts. Will check the next time this problem occurs.
> 
> Problem:
> --------
> 
> System Time behaved erratically but servers do not hang. We noticed that
> all time related apps (sendmail, ping, top, cron etc) stopped. We
> noticed that time goes forward & backward in seconds only.
> 
> server: # date
> Mon Feb  3 17:38:26 IST 2003
> server: # date
> Mon Feb  3 17:38:30 IST 2003
> server: # date
> Mon Feb  3 17:38:20 IST 2003
> server: # date
> Mon Feb  3 17:38:25 IST 2003
> server: # date
> Mon Feb  3 17:38:28 IST 2003
> server: # date
> Mon Feb  3 17:38:21 IST 2003
> 
> The above is just an example. We could not find any pattern.
> 
> We could not access the server remotely. But we could login from console.
> All programs using system time failed - like sendmail, top, cron etc.
> 
> We could umount filesystems. But the server had to be forcibly shut (power
> reset). After system reboot everything was ok.
> 
> We have xntpd daemon running on all our servers.
> 
> Four servers are file/print servers (samba/nfs/cups) and one is database
> server. The above problem has NEVER occured on the database server.
> The only difference between the file-server and database server is:
>    1. DB server has a external HP Ultrium & HP DDS4 tape drive
>       connected to Adaptec 29160N Ultra160 SCSI adapter.
>    2. DB server has a Intel PRO/1000 Network (gigabit ethernet card)
> 
> Hardware details :
> ----------------
> HP Netserver LH6000
> 6 * 550Mhz Xeon CPUs
> 1GB RAM
> Integrated Megaraid Ultra-2 SCSI Raid Controller
> BIOS MP spec is v1.4
> 
> Software:
> ---------
> SuSE Linux 7.1
> kernel 2.4.18 (k_smp-2.4.18-47)
> glibc-2.2-7
> samba-2.0.10-0
> xntp-4.0.99f-6
> "Unsynced TSC support" is enabled in default SuSE kernel k_smp-2.4.18-47
> Kernel debugging is set
> 
> 
> Nohez.
> 
> ------------------------------------------------------------------------
> List:     linux-kernel
> Subject:  Re: timer interrupts on HP machines
> From:     Matt C <wago () phlinux ! com>
> Date:     2003-01-30 17:01:50
> [Download message RAW]
> 
> Hi Praveen-
> 
> We have a few LT6000r servers as well, and have the same problem on all
> 2.4 kernels -- this happens when your MP spec is set to 1.1 in the BIOS.
> Change it to 1.4 and you should be okay.
> 
> The other common problem on these guys is the CPU speed misdetect, which
> causes the kernel to think your CPU is roughly 2x as fast as it really is.
> The solution to that one is to unplug and replug the power cords (even a
> power-off doesn't fix it, go figure).
> 
> Hope that helps.
> 
> -Matt
> 
> On Thu, 30 Jan 2003, Praveen Ray wrote:
> 
> > We have few HP (LPR NetServers and LT6000) which run 2.4.18  (from RedHat 8.0)
> > . The problem is that sometimes the time interrupts stop coming - i.e. the
> > (time) counts in /proc/interrupts stop getting incremented! When this
> > happens, the date on the system falls behind, 'sleep' calls stop working and
> > basically machine becomes unusable.Has anyone else encountered this problem?
> 
> > Is it an HP issue?
> 
> > Thanks.
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

