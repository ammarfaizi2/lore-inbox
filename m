Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267330AbUBSSsX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 13:48:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267466AbUBSSsW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 13:48:22 -0500
Received: from vana.vc.cvut.cz ([147.32.240.58]:59009 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id S267330AbUBSSsU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 13:48:20 -0500
Date: Thu, 19 Feb 2004 19:48:17 +0100
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: Kieran <kieran@ihateaol.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: proc_pid_stat crashes in 2.6.2 (was 2.6.0-test11: Crash in ps axH)
Message-ID: <20040219184816.GA14321@vana.vc.cvut.cz>
References: <20040219182329.GA10868@vana.vc.cvut.cz> <403500DA.3060906@ihateaol.co.uk> <20040219183416.GA12962@vana.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040219183416.GA12962@vana.vc.cvut.cz>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 19, 2004 at 07:34:16PM +0100, Petr Vandrovec wrote:
> On Thu, Feb 19, 2004 at 06:30:50PM +0000, Kieran wrote:
> > >Hi,
> > >  I already reported this crash twice on 2.6.0-test11, and now I
> > >reproduced it on something more fresh - on 2.6.2-bk-something like it
> > >was actual on Feb 4. It is really annoying, as any user can do 'ps axH'
> > >and crash system after some uptime :-( Crash is identical to one
> > >I got with 2.6.0-test11, so it looks like that I'll have to go back
> > >to 2.4.x on publicly accessible machines. After about 14 days uptime. 
> > >
> > >  I've got no replies to previous reports.
> > >  						Thanks,
> > >							Petr Vandrovec
> > >							vandrove@vc.cvut.cz
> > 
> > what version of procps?
> 
> Not that it should matter, as walking through /proc/* could do same,
> but... 3.1.15-3. I have no idea what procps were installed at the
> beginning of February or in the December. Until crash 'ps ax' does not
> cause problem. Only 'axH', which descends to /task/ subdirectories,
> crashes.

With Kieran questions I was able to get quickly reproducible case:

Connect through ssh.
Stop both openldap's I have running (/etc/init.d/slapd-perl stop; /etc/init.d/slapd stop)
Start them again (/etc/init.d/slapd start; /etc/init.d/slapd-perl start)
Disconnect.
Connect back.
Stop ssh (/etc/init.d/ssh stop)
Do 'ps axH'. Kaboom... Well, it is a bit different, but...
							Petr Vandrovec


Unable to handle kernel paging request at virtual address 6962738b
 printing eip:
c018ea16
*pde = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<c018ea16>]    Not tainted
EFLAGS: 00010286
EIP is at proc_pid_stat+0xa6/0x510
eax: 31203639   ebx: 6962732f   ecx: ea43c000   edx: ea5c12a0
esi: ea5f1940   edi: ea5c12a0   ebp: 00000000   esp: f3263e3c
ds: 007b   es: 007b   ss: 0068
Process ps (pid: 537, threadinfo=f3262000 task=ea6fd310)
Stack: ea5c12a0 ea62c000 f3262000 f3263e9f c025d6b7 ea62c000 f3263ea0 00000000
       00000000 0000002f 6c726570 7061646c 6374652f f7c3ed14 c1ccc854 f7c3ed14
       c0176991 00000000 f7e4b648 f7c3ed14 c1ccc854 f7c3ed14 c0176991 00000000
Call Trace:
 [<c025d6b7>] pty_write+0x1c7/0x1d0
 [<c0176991>] dput+0x31/0x1b0
 [<c0176991>] dput+0x31/0x1b0
 [<c018c371>] pid_revalidate+0x41/0xd0
 [<c01433c4>] buffered_rmqueue+0xd4/0x180
 [<c0145e3b>] check_poison_obj+0x2b/0x1a0
 [<c015fc48>] get_empty_filp+0x68/0xe0
 [<c018b7d4>] proc_info_read+0x54/0x150
 [<c015df48>] filp_open+0x68/0x70
 [<c015ed78>] vfs_read+0xb8/0x130
 [<c015e3be>] sys_open+0x7e/0x90
 [<c015f022>] sys_read+0x42/0x70
 [<c010939f>] syscall_call+0x7/0xb
Code: 0f bf 43 5c 0f bf 5b 5e c1 e0 14 09 d8 8b 59 08 01 d8 89 c1
