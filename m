Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130873AbQJ1EsG>; Sat, 28 Oct 2000 00:48:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130736AbQJ1Er5>; Sat, 28 Oct 2000 00:47:57 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:55824 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S129915AbQJ1Erm>;
	Sat, 28 Oct 2000 00:47:42 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: David Won <phlegm@home.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: kernel newby help.... What's causing my Oops 
In-Reply-To: Your message of "Fri, 27 Oct 2000 02:26:10 EDT."
             <00102702261003.01068@phlegmish.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 28 Oct 2000 15:47:36 +1100
Message-ID: <6010.972708456@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Oct 2000 02:26:10 -0400, 
David Won <phlegm@home.com> wrote:
>Oct 22 22:37:20 phlegmish kernel: Unable to handle kernel paging request at 
>virtual address 00018486
>Oct 22 22:37:20 phlegmish kernel: EIP:    
>0010:[smbfs:__insmod_smbfs_O/lib/modules/2.4.0-test8/kernel/fs/smbfs/sm+-234781/96]
>Oct 22 22:37:20 phlegmish kernel: Call Trace: 
>[smbfs:__insmod_smbfs_O/lib/modules/2.4.0-test8/kernel/fs/smbfs/sm+-220073/96] 
>[smbfs:__insmod_smbfs_O/lib/modules/2.4.0-test8/kernel/fs/smbfs/sm+-237584/96] 
>[smbfs:__insmod_smbfs_O/lib/modules/2.4.0-test8/kernel/fs/smbfs/sm+-245443/96] 
>[__fput+35/144] [_fput+17/64] [fput+18/24] [filp_close+82/92] 
>Oct 22 22:37:20 phlegmish kernel: Code: 0f b7 aa 84 40 00 00 89 ef 83 c7 04 
>89 4c 24 1c 83 c6 04 8b 
>Using defaults from ksymoops -t elf32-i386 -a i386

You did everything right, alas the data was corrupted in the log files
before you even saw it.  klogd tries to converts oops itself and far to
often it gets it wrong, yielding gibberish.  Edit /etc/rc.d/init.d/syslog
(assuming you use SysV init), change
  daemon klogd
to
  daemon klogd -x
then /etc/rc.d/init.d/syslog restart.  Any new oops will be left alone
so you will have clean data to feed to ksymoops.  When you get a clean
oops, feed it to ksymoops and mail the result to linux-kernel.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
