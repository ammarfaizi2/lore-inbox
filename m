Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132392AbRDJQMP>; Tue, 10 Apr 2001 12:12:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132395AbRDJQL4>; Tue, 10 Apr 2001 12:11:56 -0400
Received: from phoenix.datrix.co.za ([196.37.220.5]:34592 "EHLO
	phoenix.datrix.co.za") by vger.kernel.org with ESMTP
	id <S132392AbRDJQLv>; Tue, 10 Apr 2001 12:11:51 -0400
Content-Type: text/plain; charset=US-ASCII
From: Marcin Kowalski <kowalski@datrix.co.za>
Reply-To: kowalski@datrix.co.za
Organization: Datrix Solutions
To: linux-kernel@vger.kernel.org
Subject: Kernel 2.4.3 Crash - (Kernel BUG at highmem.c:155)
Date: Tue, 10 Apr 2001 18:11:15 +0200
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <0104101811150C.25951@webman>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All

This is quite a long email which I have split in two for those that are 
interested problem and background...

---Problem---

Kernel Panic Occured with Messages:
Kernel BUG at highmem.c:155
Invalid Operand ???? With sshd somewhere in the mix. 

Unfortunately I did a task dump with SYSRQ before I could get the rest of the 
info..  and syslogd had stopped logging to disk already. I then had to reboot.

Looking at line 155 :
/*
         * A count must never go down to zero
         * without a TLB flush!
         */
        switch (--pkmap_count[nr]) {
        case 0:
                BUG();
        case 1:
                wake_up(&pkmap_map_wait);
        }
        spin_unlock(&kmap_lock);

WHat went wrong???? to make the count go to zero??

---Background----

I am running Linux 2.4.3 on A HP netserver 2000r, it has 1.2gigs of RAM, at 
dual 933mhz Xeon (Piii actually, but paid for Xeons??) and a Netraid 4m SCSI 
Card with 6x 18.4gig HP Drives in a Raid 5 Configuration with No Hot Standby.
The Root FS is on a 9.2 GIG HP Scsi Drive. Both root and home are reiserfs 
(9.4 gig and 85gig respectively).
The kernel is patch with the axboe-scsi-patch and the latest aacraid patch. 
Running under SUse Linux 7.0 (new modutils).

THe server is running samba, httpd, sendmail, mrtg, named and a number of 
other porcesses but the loadaverage tends to stay below 1.0 mostly, although 
it exhibits erratic behaviour with load climbing to 3-5-6 with top showing no 
apparent candidate, with most of the time spent in SYStem calls. 
Occassional lockups lasting 5-20 seconds were experienced when working on the 
box under 2.4.2 but seem to be much better in 2.4.3.

Today the server tends to "eat up" shared+used memory over time eventually 
using +- 700mb of RAM with no process reflecting this in top.

Running SWAPoff today, when 64mb of swap was being used, resulted in complete 
machine lockup for about 30-40 seconds. 

I strongly suspect the aacraid drivers but need further proof to convince the 
powers that be to swap for a Mylex or something better supported....

Any advice/answers would be very welcome.

TIA
MARCin


-- 
-----------------------------
     Marcin Kowalski
     Linux/Perl Developer
     Datrix Solutions
     Cel. 082-400-7603
      ***Open Source Kicks Ass***
-----------------------------
