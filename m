Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263354AbTFJPmM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 11:42:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263365AbTFJPmM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 11:42:12 -0400
Received: from mail.ithnet.com ([217.64.64.8]:32519 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id S263354AbTFJPlz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 11:41:55 -0400
Date: Tue, 10 Jun 2003 17:55:06 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: linux-kernel@vger.kernel.org, willy@w.ods.org, gibbs@scsiguy.com,
       marcelo@conectiva.com.br, green@namesys.com
Subject: Re: Undo aic7xxx changes (now rc7+aic20030603)
Message-Id: <20030610175506.27f3a669.skraw@ithnet.com>
In-Reply-To: <Pine.LNX.4.50.0306100949040.19137-100000@montezuma.mastecende.com>
References: <Pine.LNX.4.55L.0305071716050.17793@freak.distro.conectiva>
	<2804790000.1052441142@aslan.scsiguy.com>
	<20030509120648.1e0af0c8.skraw@ithnet.com>
	<20030509120659.GA15754@alpha.home.local>
	<20030509150207.3ff9cd64.skraw@ithnet.com>
	<20030605181423.GA17277@alpha.home.local>
	<20030608131901.7cadf9ea.skraw@ithnet.com>
	<20030608134901.363ebe42.skraw@ithnet.com>
	<20030609171011.7f940545.skraw@ithnet.com>
	<Pine.LNX.4.50.0306092135000.19137-100000@montezuma.mastecende.com>
	<20030610123015.4242716e.skraw@ithnet.com>
	<Pine.LNX.4.50.0306100847580.19137-100000@montezuma.mastecende.com>
	<20030610153815.57f7a563.skraw@ithnet.com>
	<Pine.LNX.4.50.0306100949040.19137-100000@montezuma.mastecende.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Jun 2003 09:51:34 -0400 (EDT)
Zwane Mwaikambo <zwane@linuxpower.ca> wrote:

> > Reading around the whole interrupt stuff I came across a very simple idea which
> > I am going to test right now. See you in some hours ;-)
> 
> Cool

Hoho, how about this one:

ksymoops 2.4.8 on i686 2.4.21-rc7-aic.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.21-rc7-aic/ (default)
     -m /boot/System.map-2.4.21-rc7-aic (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Jun 10 17:50:53 admin kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000b2c
Jun 10 17:50:53 admin kernel: c0221c37
Jun 10 17:50:53 admin kernel: *pde = 00000000
Jun 10 17:50:53 admin kernel: Oops: 0000
Jun 10 17:50:53 admin kernel: CPU:    0
Jun 10 17:50:53 admin kernel: EIP:    0010:[st_do_scsi+295/384]    Not tainted
Jun 10 17:50:53 admin kernel: EIP:    0010:[<c0221c37>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
Jun 10 17:50:53 admin kernel: EFLAGS: 00010246
Jun 10 17:50:53 admin kernel: eax: 00000000   ebx: 00000001   ecx: 00000000   edx: c34a0424
Jun 10 17:50:53 admin kernel: esi: f5f2c180   edi: 00000b00   ebp: 00008090   esp: dead5edc
Jun 10 17:50:53 admin kernel: ds: 0018   es: 0018   ss: 0018
Jun 10 17:50:53 admin kernel: Process tar (pid: 4004, stackpage=dead5000)
Jun 10 17:50:53 admin kernel: Stack: f5f2c180 00000000 c0090000 00008000 c0221a10 00015f90 00000000 dead5f7c
Jun 10 17:50:53 admin kernel:        c34a0400 00000001 00008000 c0223abd 00000000 c34a0400 dead5f40 00008000
Jun 10 17:50:53 admin kernel:        00000002 00015f90 00000000 00000001 00000000 00000000 c34a04c0 c34a0450
Jun 10 17:50:53 admin kernel: Call Trace:    [st_sleep_done+0/256] [read_tape+269/1024] [scsi_finish_command+152/208] [st_read+1015/1152] [sys_read+155/384]
Jun 10 17:50:53 admin kernel: Call Trace:    [<c0221a10>] [<c0223abd>] [<c01ede38>] [<c02241a7>] [<c0141c0b>]
Jun 10 17:50:53 admin kernel:   [<c010782f>]
Jun 10 17:50:53 admin kernel: Code: 8b 5f 2c 89 74 24 04 89 3c 24 e8 ea fb ff ff 89 43 1c eb a5


>>EIP; c0221c37 <st_do_scsi+127/180>   <=====

>>edx; c34a0424 <_end+310e0e4/38547d20>
>>esi; f5f2c180 <_end+35b99e40/38547d20>
>>esp; dead5edc <_end+1e743b9c/38547d20>

Trace; c0221a10 <st_sleep_done+0/100>
Trace; c0223abd <read_tape+10d/400>
Trace; c01ede38 <scsi_finish_command+98/d0>
Trace; c02241a7 <st_read+3f7/480>
Trace; c0141c0b <sys_read+9b/180>
Trace; c010782f <system_call+33/38>

Code;  c0221c37 <st_do_scsi+127/180>
00000000 <_EIP>:
Code;  c0221c37 <st_do_scsi+127/180>   <=====
   0:   8b 5f 2c                  mov    0x2c(%edi),%ebx   <=====
Code;  c0221c3a <st_do_scsi+12a/180>
   3:   89 74 24 04               mov    %esi,0x4(%esp,1)
Code;  c0221c3e <st_do_scsi+12e/180>
   7:   89 3c 24                  mov    %edi,(%esp,1)
Code;  c0221c41 <st_do_scsi+131/180>
   a:   e8 ea fb ff ff            call   fffffbf9 <_EIP+0xfffffbf9>
Code;  c0221c46 <st_do_scsi+136/180>
   f:   89 43 1c                  mov    %eax,0x1c(%ebx)
Code;  c0221c49 <st_do_scsi+139/180>
  12:   eb a5                     jmp    ffffffb9 <_EIP+0xffffffb9>


1 warning issued.  Results may not be reliable.

Anybody able to comment on that?

Regards,
Stephan

