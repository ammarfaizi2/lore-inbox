Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130540AbRANOfF>; Sun, 14 Jan 2001 09:35:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130462AbRANOez>; Sun, 14 Jan 2001 09:34:55 -0500
Received: from barn.holstein.com ([198.134.143.193]:2830 "EHLO holstein.com")
	by vger.kernel.org with ESMTP id <S129994AbRANOep>;
	Sun, 14 Jan 2001 09:34:45 -0500
Message-Id: <3A61B841.81B1D0F5@holstein.com>
Date: Sun, 14 Jan 2001 09:31:29 -0500
From: "Todd M. Roy" <troy@holstein.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>,
        "Heinz J. Mauelshagen" <Heinz.Mauelshagen@t-online.de>,
        linux-kernel@vger.kernel.org
Subject: lvm 0.9.1-beta1 still segfaults vgexport
In-Reply-To: <3A45192F.8C149F93@softhome.net> <20001227205336.A10446@athlon.random> <200101081918.f08JIrT06681@pcx4168.holstein.com> <20010108234339.F27646@athlon.random> <3A5B3422.F63D7DDD@holstein.com> <20010109170424.A29468@athlon.random> <3A5BBD0E.9F7DA88B@holstein.com> <20010110024743.R29904@athlon.random>
X-MIMETrack: Itemize by SMTP Server on Imail/Holstein(Release 5.0.1b|September 30, 1999) at
 01/14/2001 09:29:49 AM,
	Serialize by Router on Imail/Holstein(Release 5.0.1b|September 30, 1999) at
 01/14/2001 09:29:50 AM,
	Serialize complete at 01/14/2001 09:29:50 AM
X-Priority: 3 (Normal)
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea,
  Sorry to say but lvm 0.9.1-beta1 still segfaults
at the same place, line 140 of pv_read_all_pv_of_vg.c
pv_this is still null.
This with a straight 2.4.0 kernel with an onstream tape
patch and the generated lvm patch.  Lvm is a module (on
my home machine).

-- todd --
gdb /sbin/vgexport core:
...

#0  0x400427f3 in pv_read_all_pv_of_vg (vg_name=0xbffff794 "vg01PV_EXP", 
    pv=0xbffff710, reread=0) at pv_read_all_pv_of_vg.c:140
140	      for ( p = 0; pv_this[p] != NULL; p++) {
(gdb) print pv_this
$1 = (pv_v2_t **) 0x0
(gdb) bt
#0  0x400427f3 in pv_read_all_pv_of_vg (vg_name=0xbffff794 "vg01PV_EXP", 
    pv=0xbffff710, reread=0) at pv_read_all_pv_of_vg.c:140
#1  0x400487af in vg_read (vg_name=0xbffff794 "vg01PV_EXP",
vg=0xbffff750)
    at vg_read.c:61
#2  0x4004733d in vg_check_exist (vg_name=0xbffff794 "vg01PV_EXP")
    at vg_check_exist.c:54
#3  0x80491ee in main (argc=2, argv=0xbffff8cc) at vgexport.c:182
#4  0x4007b213 in __libc_start_main (main=0x8048d00 <main>, argc=2, 
    ubp_av=0xbffff8cc, init=0x80489c4 <_init>, fini=0x80495b4 <_fini>, 
    rtld_fini=0x4000d660 <_dl_fini>, stack_end=0xbffff8c4)
    at ../sysdeps/generic/libc-start.c:129
...
**********************************************************************
This footnote confirms that this email message has been swept by 
MIMEsweeper for the presence of computer viruses.
**********************************************************************
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
