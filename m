Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317435AbSFXIlI>; Mon, 24 Jun 2002 04:41:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317436AbSFXIlH>; Mon, 24 Jun 2002 04:41:07 -0400
Received: from m206-234.dsl.tsoft.com ([198.144.206.234]:60616 "EHLO
	jojda.2y.net") by vger.kernel.org with ESMTP id <S317435AbSFXIlH>;
	Mon, 24 Jun 2002 04:41:07 -0400
Message-ID: <3D16DB21.5B0BBC7D@bigfoot.com>
Date: Mon, 24 Jun 2002 01:41:05 -0700
From: Erik Steffl <steffl@bigfoot.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18 i686)
X-Accept-Language: en, sk, ru
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: non-killable program - kernel problem?
References: <3D1582E4.7016EA1F@bigfoot.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Erik Steffl wrote:
> 
>   cleanup (part of postfix) is eating up most of CPU cycles and I cannot
> kill it (-9 is ignored) - I guess that means that the problem is
> somewhere in kernel (system call). Is it true? Is there anything I can
> do to kill it? to find out what the problem is?
> 
>   I attached gdb to it but now gdb is stuck as well... I didn't see
> anything suspicious in system log...
> 
>   kernel 2.4.18, I didn't upgrade it for a long time and this cleanup
> problem only occured recently (last few weeks, twice).
> 
>   TIA

  now this is really strange - after FEW DAYS of load 99% and not being
able to interrupt cleanup (I attached gdb to it and hit ctrl-c) it was
finally interrupted and now it's in:

(gdb) where
#0  0x401f82e4 in open () from /lib/libc.so.6
#1  0x4004354c in rewrite_clnt_stream () from
/usr/lib/libpostfix-global.so.1
#2  0x40038151 in mail_stream_file () from
/usr/lib/libpostfix-global.so.1
#3  0x0804be05 in dict_changed ()
#4  0x08049a65 in dict_changed ()
#5  0x40027b85 in _init () from /usr/lib/libpostfix-master.so.1
#6  0x40027ce1 in _init () from /usr/lib/libpostfix-master.so.1
#7  0x40051e05 in event_loop () from /usr/lib/libpostfix-util.so.1
#8  0x400286ce in single_server_main () from
/usr/lib/libpostfix-master.so.1
#9  0x08049c4e in dict_changed ()
#10 0x4014e14f in __libc_start_main () from /lib/libc.so.6
(gdb) 

  I guess that since it's still in open function of libc it was stuck in
open system call?

  any ideas about what's going on?

	erik
