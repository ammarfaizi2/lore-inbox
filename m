Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261746AbVEZUwY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261746AbVEZUwY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 16:52:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261745AbVEZUtN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 16:49:13 -0400
Received: from fire.osdl.org ([65.172.181.4]:204 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261746AbVEZUrA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 16:47:00 -0400
Date: Thu, 26 May 2005 13:45:32 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: jamagallon@able.es, tomlins@cam.org, linux-kernel@vger.kernel.org,
       alsa-devel@lists.sourceforge.net
Subject: Re: 2.6.12-rc5-mm1
Message-Id: <20050526134532.1580defc.akpm@osdl.org>
In-Reply-To: <200505261554.54807.rjw@sisk.pl>
References: <20050525134933.5c22234a.akpm@osdl.org>
	<1117093392l.17165l.0l@werewolf.able.es>
	<20050526005841.08a8aae0.akpm@osdl.org>
	<200505261554.54807.rjw@sisk.pl>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Rafael J. Wysocki" <rjw@sisk.pl> wrote:
>
> n Thursday, 26 of May 2005 09:58, Andrew Morton wrote:
>  > "J.A. Magallon" <jamagallon@able.es> wrote:
>  > >
>  > > 
>  > > On 05.26, Andrew Morton wrote:
>  > > > 
>  > > > (Added alsa-devel to cc)
>  > > > 
>  > > > Ed Tomlinson <tomlins@cam.org> wrote:
>  > > > > 
>  > > > > Got the following when I tried to use sound.  Anyone else see problems in alsa land?
>  > > > > 
>  > > 
>  > > Me too. As beep-media-player ends playing a mp3 track, oops !
>  > 
>  > hm, OK, you're also on x86_64.  What sound card and driver?
> 
>  I've got the following on a dual-Opteron box with Tyan Thunder K8W (snd_intel8x0):

OK, thanks.  I guess we can set this problem aside for now, as this bug
isn't present in 2.6.12-rc5 (correct?).

I assume the problem is due to one of the ASLA patches in rc5-mm1, but it's
possible that it lies elsewhere.  It would be great if someone could fire
up quilt and do a binary search...

To summarise, we have three people (one Opteron, one x86, one
unknown-x86_64) reporting this:


 May 25 21:17:38 grover kernel: [  131.322558] PGD 2ab13067 PUD 2ab1b067 PMD 2a3f1067 PTE 0
 May 25 21:17:38 grover kernel: [  131.351464] CPU 0
 May 25 21:17:38 grover kernel: [  131.358041] Modules linked in: radeon nfsd exportfs lockd sunrpc sg parport_pc lp parport ipv6 sd_
 mod evdev mousedev tsdev usbhid usb_storage snd_intel8x0 snd_ac97_codec snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd soundcore sn
 d_page_alloc ehci_hcd ohci_hcd eth1394 sata_nv libata forcedeth
  ohci1394 powernow_k8 freq_table processor cpufreq_userspace w83627hf eeprom i2c_sensor i2c_isa i2c_nforce2 i2c_core sr_mod sbp2 scs
 i_mod ieee1394 rtc unix
 May 25 21:17:38 grover kernel: [  131.487598] Pid: 5481, comm: artsd Not tainted 2.6.12-rc5-mm1
 May 25 21:17:38 grover kernel: [  131.506496] RIP: 0010:[__nosave_end+129759479/2131247104] <ffffffff8813b8f7>{:snd_pcm:snd_pcm_mmap
 _data_close+7}
 May 25 21:17:38 grover kernel: [  131.535142] RSP: 0018:ffff81002ab9dee0  EFLAGS: 00010286
 May 25 21:17:38 grover kernel: [  131.553183] RAX: 00002aaaadb59000 RBX: ffff810029c64988 RCX: fffffffffffffff2
 May 25 21:17:38 grover kernel: [  131.576657] RDX: ffff810029c64988 RSI: ffff81002d672ce0 RDI: ffff81002b339f50
 May 25 21:17:38 grover kernel: [  131.600129] RBP: ffff81002b3051c0 R08: ffff810029c649a8 R09: ffff81002ab9dec8
 May 25 21:17:38 grover kernel: [  131.623602] R10: 0000000000000002 R11: 0000000000000206 R12: ffff81002b339f50
 May 25 21:17:38 grover kernel: [  131.647075] R13: ffff81002b339f50 R14: ffff81002e7f2a08 R15: 00002aaaadb67000
 May 25 21:17:38 grover kernel: [  131.670548] FS:  00002aaaad6d8f50(0000) GS:ffffffff80550840(0000) knlGS:0000000000000000
 May 25 21:17:38 grover kernel: [  131.697165] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 May 25 21:17:38 grover kernel: [  131.716064] CR2: 00002aaaadb59098 CR3: 000000002aafd000 CR4: 00000000000006e0
 May 25 21:17:38 grover kernel: [  131.739537] Process artsd (pid: 5481, threadinfo ffff81002ab9c000, task ffff81002ada97f0)
 May 25 21:17:38 grover kernel: [  131.766439] Stack: ffffffff8016942d 0000000000000000 0000000000000000 ffff81002e7f2a00
 May 25 21:17:38 grover kernel: [  131.792174]        ffffffff8016a936 ffff81002d672df0 ffff81002d672e08 ffff81002d672df0
 May 25 21:17:38 grover kernel: [  131.818481]        ffff81002e7f2a00 0000000000560600
 May 25 21:17:38 grover kernel: [  131.835065] Call Trace:<ffffffff8016942d>{remove_vm_struct+125} <ffffffff8016a936>{do_munmap+550}
 May 25 21:17:38 grover kernel: [  131.864282]        <ffffffff8016b0fd>{sys_munmap+77} <ffffffff8010ead6>{system_call+126}
 May 25 21:17:38 grover kernel: [  131.890928]
 May 25 21:17:38 grover kernel: [  131.898387]
 May 25 21:17:38 grover kernel: [  131.898388] Code: 48 8b 80 98 00 00 00 ff 88 08 01 00 00 c3 66 66 66 90 66 66
