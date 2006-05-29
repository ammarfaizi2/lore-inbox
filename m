Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751167AbWE2Sct@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751167AbWE2Sct (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 14:32:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751171AbWE2Sct
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 14:32:49 -0400
Received: from wr-out-0506.google.com ([64.233.184.235]:11322 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751167AbWE2Sct convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 14:32:49 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=DRRDzOpJOXdBd5yVeu0VO+Kt4eBf8kcAFuWsZQK+ohwBdJ4z+ptch4CWQKeuDwkseEEWwzUYBmZiKsBFi3dz3VP22dX19sYeKliYKgA0uqqsHx7IV8guncaC5QauJxYXamoi1qCS1gRmp8u+ydkPSpkxUui8xLrsuFLwFe/dCks=
Message-ID: <6bffcb0e0605291132u701cd69tb855cf60fa317994@mail.gmail.com>
Date: Mon, 29 May 2006 20:32:47 +0200
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "Ingo Molnar" <mingo@elte.hu>
Subject: 2.6.17-rc4-mm3-lockdep BUG: possible deadlock detected!
Cc: perex@suse.cz, alsa-devel@alsa-project.org,
       "Andrew Morton" <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I get this with Ingo's lockdep patch from
http://people.redhat.com/mingo/generic-irq-subsystem/

====================================
[ BUG: possible deadlock detected! ]
------------------------------------
modprobe/592 is trying to acquire lock:
 (&grp->list_mutex){----}, at: [<fd9ee555>]
snd_seq_port_connect+0xc0/0x337 [snd_seq]

but task is already holding lock:
 (&grp->list_mutex){----}, at: [<fd9ee4fb>]
snd_seq_port_connect+0x66/0x337 [snd_seq]

which could potentially lead to deadlocks!

other info that might help us debug this:
1 locks held by modprobe/592:
 #0:  (&grp->list_mutex){----}, at: [<fd9ee4fb>]
snd_seq_port_connect+0x66/0x337 [snd_seq]

stack backtrace:
 <c1003f36> show_trace+0xd/0xf  <c1004449> dump_stack+0x17/0x19
 <c1039792> __lockdep_acquire+0xa1a/0xa39  <c1039bed> lockdep_acquire+0x69/0x82
 <fd9ee570> snd_seq_port_connect+0xdb/0x337 [snd_seq]  <fd9ea5f5>
snd_seq_ioctl_subscribe_port+0x96/0xe6 [snd_seq]
 <fd9e91d4> snd_seq_do_ioctl+0x5d/0x68 [snd_seq]  <fd9e921c>
snd_seq_kernel_client_ctl+0x2d/0x3b [snd_seq]
 <f8877274> snd_seq_oss_create_client+0x12d/0x142 [snd_seq_oss]
<f88770f7> alsa_seq_oss_init+0xf7/0x147 [snd_seq_oss]
 <c104116d> sys_init_module+0xa6/0x230  <c11efa8b> sysenter_past_esp+0x54/0x8d

Here is dmesg http://www.stardust.webpages.pl/files/lockdep/2.6.17-rc4-mm3-lockdep1/lockdep-dmesg

Here is config
http://www.stardust.webpages.pl/files/lockdep/2.6.17-rc4-mm3-lockdep1/lockdep-config

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)
