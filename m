Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130380AbRBHOCB>; Thu, 8 Feb 2001 09:02:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129961AbRBHOBl>; Thu, 8 Feb 2001 09:01:41 -0500
Received: from oberon.gaumina.lt ([193.219.244.227]:34319 "HELO
	oberon.gaumina.lt") by vger.kernel.org with SMTP id <S129388AbRBHOBa> convert rfc822-to-8bit;
	Thu, 8 Feb 2001 09:01:30 -0500
From: Andrius Adomaitis <charta@gaumina.lt>
To: linux-kernel@vger.kernel.org
Subject: Problems with 2.4.2-pre1 & reiser & vfs
Date: Thu, 8 Feb 2001 16:00:26 +0100
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain; charset=US-ASCII
MIME-Version: 1.0
Message-Id: <0102081600260I.32334@castle.gaumina.lt>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

I have  dual PIII 800 machine running as mail server on DAC 960 RAID & 
reiserfs comming with 2.4.1kernel.

Under very high loads I get  following messages in my kernel log:

kernel: vs-13060: reiserfs_update_sd: stat data of object [7906789 
7906806 0x0 SD](nlink == 1) not found (pos 23)
kernel: vs-13060: reiserfs_update_sd: stat data of object [7906789 
7906806 0x0 SD] (nlink == 1) not found (pos 23)
kernel: PAP-5660: reiserfs_do_truncate: wrong result -1 of search for 
[7906789 7906806 0xfffffffffffffff DIRECT]
kernel: vs-13060: reiserfs_update_sd: stat data of object [7906789 
7906806 0x0 SD] (nlink == 1) not found (pos 23)
kernel: PAP-5660: reiserfs_do_truncate: wrong result -1 of search for 
[7906789 7906806 0xfffffffffffffff DIRECT]
.....

and afterwards come these:

kernel: vs-3050: wait_buffer_until_released: nobody releases buffer 
(dev 30:09, size 4096, blocknr 1661732, count 16,
kernel: vs-3050: wait_buffer_until_released: nobody releases buffer 
(dev 30:09, size 4096, blocknr 1661732, count 16,
...
and so on.

The interesting thing is that system is still operational, but load 
jumps up to 260 or so, and any attempts to reboot system fail. ps aux 
shows that there exists imortal (kill -9 $PID doesn't kill it) qmail 
process that consumes 97% of one CPU's resources.  Also `vmstat` shows 
tons of processes in uninterruptable sleep, but `free` reports that it 
is still enough memory (no swap used) and huge buffers... Machine gets 
slugish but works for a while (0.5-2h dependent on mail request rate).

System is Debian potato, 
gcc version 2.95.2 20000220 (Debian GNU/Linux),
reiserfs utils 3.6.25.

Any patches or suggestions to fix that would be appreciated...

P.S. Also I thought wouldn't it be good to have some sysctl entry in 
proc that rebooted machine dependent on the value in control file when 
proper software reboot is impossible (like in situation described 
above)? Or probably there already exist(s) such thing(s)?

Thanks.
-- 
Andrius
charta@gaumina.lt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
