Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286172AbRLZIkv>; Wed, 26 Dec 2001 03:40:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286177AbRLZIkm>; Wed, 26 Dec 2001 03:40:42 -0500
Received: from [202.99.6.10] ([202.99.6.10]:52099 "EHLO mail.zhengmai.net.cn")
	by vger.kernel.org with ESMTP id <S286172AbRLZIk3>;
	Wed, 26 Dec 2001 03:40:29 -0500
Message-ID: <009a01c18de8$ba084dc0$d20101c0@T21laser>
From: "Weiping He" <laser@zhengmai.com.cn>
To: "Oleg Drokin" <green@namesys.com>
Cc: <linux-kernel@vger.kernel.org>, <reiserfs-list@namesys.com>
In-Reply-To: <005401c18dc6$f3e3fb10$d20101c0@T21laser> <20011226094209.B871@namesys.com>
Subject: Re: anybody know about "journal-615" and/or "journal-601" log error?
Date: Wed, 26 Dec 2001 16:38:11 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mangalore.zipworld.com.au id TAA23745

> 
> >     but I've experienced server hang up of my box, the syslog entity is:
> >     (this show up after I re-compile the kernel with the reiserfs's:
> >         Have reiserfs do extra internal checking
> >         Stats in /proc/fs/reiserfs
> >      options set to enable)
> > Dec 26 09:47:10 x200 kernel: journal-615: buffer write failed
> > Dec 18 10:19:13 x200 kernel: journal-601, buffer write failed
> Any other errors in the logs?

no, there is the only log I can find related in syslog, but I'v seen some kernel stack dump on the screen, 
and I havn't got chance to copy them out. I'm observing it now, if I repeat the error, I'll sent them.

> Reading the code these errors appear after we put IO request
> and then watitng for it to be complete with wait_on_buffer().
> But after wait_on_buffer returns, bufer is still not up to date,
> which usually means IO request have failed for some reason.
> 

yeah, that's what I thought too.

> Right now it looks more like a HW problem.

I guest so at present, but let me wait to see if I can repeat the problem later.

> Can you dig more messages from your kernel log.

there are some other log messages in /var/log/debug, looks like:

----------------------------------------------8<-----------------------------------------
Dec 26 01:58:55 x200 kernel: journal_read_transaction, commit offset 5581 had bad time 232573 or length 4
Dec 26 01:58:55 x200 kernel: journal-1299: Setting newest_mount_id to 28
Dec 26 02:07:06 x200 kernel: CPU: Before vendor init, caps: 0383f9ff 00000000 00000000, vendor = 0
Dec 26 02:07:06 x200 kernel: CPU: After vendor init, caps: 0383f9ff 00000000 00000000 00000000
Dec 26 02:07:06 x200 kernel: CPU:     After generic, caps: 0383f9ff 00000000 00000000 00000000
Dec 26 02:07:06 x200 kernel: CPU:             Common caps: 0383f9ff 00000000 00000000 00000000
Dec 26 02:07:10 x200 kernel: journal-1153: found in header: first_unflushed_offset 405, last_flushed_trans_id 119668
Dec 26 02:07:10 x200 kernel: journal-1206: Starting replay from offset 405, trans_id 119669
Dec 26 02:07:11 x200 kernel: journal-1299: Setting newest_mount_id to 34
Dec 26 02:07:12 x200 kernel: journal-1153: found in header: first_unflushed_offset 7579, last_flushed_trans_id 15604
Dec 26 02:07:12 x200 kernel: journal-1206: Starting replay from offset 7579, trans_id 15605
Dec 26 02:07:12 x200 kernel: journal-1299: Setting newest_mount_id to 34
Dec 26 02:07:12 x200 kernel: journal-1153: found in header: first_unflushed_offset 4260, last_flushed_trans_id 44372
----------------------------------------------8<-----------------------------------------

but I think their are unrelevented here, because I think their are the normal log check after power failure.

> Can you try to run reiserfsck on a problematic partition and see
> if there is anything wrong?

I've run it using command like :

#reiserfsck -x -o -l logfile /dev/sdc6

to all my partitions in linux, and  the `logfile' is empty, so may be I should observing to 
see if the problem could repeated and get more information.
BTW: if there another log helpful I can found, please inform me, I just checked `syslog',
`message' and `debug' in my system log directory.

    Thanks and Regards   Laser
ı:.Ë›±Êâmçë¢kaŠÉb²ßìzwm…ébïîË›±Êâmébìÿ‘êçz_âØ^n‡r¡ö¦zËëh™¨è­Ú&£ûàz¿äz¹Ş—ú+€Ê+zf£¢·hšˆ§~†­†Ûiÿÿïêÿ‘êçz_è®æj:+v‰¨ş)ß£ømšSåy«­æ¶…­†ÛiÿÿğÃí»è®å’i
