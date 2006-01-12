Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161397AbWALW6q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161397AbWALW6q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 17:58:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161398AbWALW6q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 17:58:46 -0500
Received: from zproxy.gmail.com ([64.233.162.200]:54309 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161397AbWALW6p convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 17:58:45 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=dr4ETbWegE+K1RJ2StaIqlBeSVuC6Mf6txKD2XcVEPqoy/xnA+bqHFbsg6We2xb7Pyox4JbOkhVZozBpYrzjYUGcDGsRJ8j8J89feUr9en1VikKcNE6JglbqNMJZDNUAqEh1kOePYsPqOMc2q0GMZfNUwp7Ecf5D/W68Y3bCmc0=
Message-ID: <5a4c581d0601121458p1c23aa2cg29472c74576c6c2d@mail.gmail.com>
Date: Thu, 12 Jan 2006 23:58:42 +0100
From: Alessandro Suardi <alessandro.suardi@gmail.com>
To: Dave Airlie <airlied@gmail.com>
Subject: Re: [2.6.15-git6,-git7] hard lockup on FC4 exiting X (Intel I915)
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <5a4c581d0601121233s3b2b2c2dnfcd177ebd7829151@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <5a4c581d0601111647i62f8c625q51a420ba9a9175e5@mail.gmail.com>
	 <21d7e9970601112345p9306310ud935735f3b44e565@mail.gmail.com>
	 <5a4c581d0601121233s3b2b2c2dnfcd177ebd7829151@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/12/06, Alessandro Suardi <alessandro.suardi@gmail.com> wrote:
> On 1/12/06, Dave Airlie <airlied@gmail.com> wrote:
> > >  startx, fire up a gnome-terminal, exit it, Desktop->Logout...
> > >  at this point the mouse arrow stills and the box locks up,
> > >  keyboard dead, no response to pings.
> > >
> >
> > Normally I'd accept blame for this, but I've not merged up yet, so at
> > a guess the mutex patches probably did something... if not the some
> > PCI ones perhaps..
> >
> > I don't suppose you can get a serial console hooked up (probably no
> > real serial on that machine) or a netconsole..
>
> All right, here comes the netconsole output from -git7.
>
> Another thing first though, which I hadn't noticed earlier.
> As soon as I logged on the VT, I got these messages from
>  /usr/bin/ainit which indeed first appeared in 2.6.15-git6:
>
> Jan 12 21:18:10 192.168.1.2 login(pam_unix)[3703]: session opened for
> user asuardi by (uid=0)
> Jan 12 21:18:10 192.168.1.2 ainit: Memory: Failed to release semaphore
> Jan 12 21:18:10 192.168.1.2 ainit: Error: No such file or directory
> Jan 12 21:18:10 192.168.1.2 ainit: Memory: Failed to release SHM segment
> Jan 12 21:18:10 192.168.1.2 ainit: Error: No such file or directory
> Jan 12 21:18:10 192.168.1.2 ainit: Memory: Failed to release SHM segment
> Jan 12 21:18:10 192.168.1.2 ainit: Error: No such file or directory
> Jan 12 21:18:10 192.168.1.2 ainit: Memory: Failed to release semaphore
> Jan 12 21:18:10 192.168.1.2 ainit: Error: No such file or directory
> Jan 12 21:18:10 192.168.1.2 ainit: Memory: Failed to release SHM segment
> Jan 12 21:18:11 192.168.1.2 ainit: Error: No such file or directory
> Jan 12 21:18:11 192.168.1.2 ainit: Memory: Failed to release SHM segment
> Jan 12 21:18:11 192.168.1.2 ainit: Error: No such file or directory
> Jan 12 21:18:11 192.168.1.2  -- asuardi[3703]: LOGIN ON tty2 BY asuardi
>
> And then startx, Desktop->Logout, and boom. It's ugly but
>  I'll just cut'n'paste so I don't botch useful info...
>
>
> Jan 12 21:19:54 192.168.1.2 kernel: [drm] Initialized drm 1.0.0 20040925
> Jan 12 21:19:54 192.168.1.2 kernel: ACPI: PCI Interrupt
> 0000:00:02.0[A] -> Link [LNKA] -> GSI 11 (level, low) -> IRQ 11
> Jan 12 21:19:54 192.168.1.2 mtrr: base(0xc0020000) is not aligned on a
> size(0x300000) boundary
> Jan 12 21:19:54 192.168.1.2 kernel: [drm] Initialized i915 1.1.0
> 20040405 on minor 0:
> Jan 12 21:19:54 192.168.1.2 kernel: mtrr: base(0xc0020000) is not
> aligned on a size(0x300000) boundary
> Jan 12 21:19:58 192.168.1.2 gconfd (asuardi-3902): starting (version
> 2.10.0), pid 3902 user 'asuardi'
> Jan 12 21:19:58 192.168.1.2 gconfd (asuardi-3902): Resolved address
> "xml:readonly:/etc/gconf/gconf.xml.mandatory" to a read-only
> configuration source at position 0
> Jan 12 21:19:58 192.168.1.2 gconfd (asuardi-3902): Resolved address
> "xml:readwrite:/home/asuardi/.gconf" to a writable configuration
> source at position 1
> Jan 12 21:19:58 192.168.1.2 gconfd (asuardi-3902): Resolved address
> "xml:readonly:/etc/gconf/gconf.xml.defaults" to a read-only
> configuration source at position 2
> Jan 12 21:20:02 incident crond(pam_unix)[5977]: session opened for
> user root by (uid=0)
> Jan 12 21:20:02 incident crond(pam_unix)[5977]: session closed for user root
> Jan 12 21:20:04 192.168.1.2 gconfd (asuardi-3902): Resolved address
> "xml:readwrite:/home/asuardi/.gconf" to a writable configuration
> source at position 0
> Jan 12 21:20:21 192.168.1.2 Unable to handle kernel NULL pointer dereference
> Jan 12 21:20:21 192.168.1.2  at virtual address 000000ac
> Jan 12 21:20:21 192.168.1.2  printing eip:
> Jan 12 21:20:21 192.168.1.2 f8b589a9
> Jan 12 21:20:21 192.168.1.2 *pde = 7959c067
> Jan 12 21:20:21 192.168.1.2 Oops: 0000 [#1]
> Jan 12 21:20:21 192.168.1.2 Modules linked in:
> Jan 12 21:20:21 192.168.1.2  i915
> Jan 12 21:20:21 192.168.1.2  drm
> Jan 12 21:20:21 192.168.1.2  netconsole
> Jan 12 21:20:21 192.168.1.2  ipv6
> Jan 12 21:20:21 192.168.1.2  parport_pc
> Jan 12 21:20:21 192.168.1.2  lp
> Jan 12 21:20:21 192.168.1.2  parport
> Jan 12 21:20:21 192.168.1.2  autofs4
> Jan 12 21:20:21 192.168.1.2  sunrpc
> Jan 12 21:20:21 192.168.1.2  pcmcia
> Jan 12 21:20:21 192.168.1.2  video
> Jan 12 21:20:21 192.168.1.2  button
> Jan 12 21:20:21 192.168.1.2  battery
> Jan 12 21:20:21 192.168.1.2  ac
> Jan 12 21:20:21 192.168.1.2  yenta_socket
> Jan 12 21:20:21 192.168.1.2  rsrc_nonstatic
> Jan 12 21:20:21 192.168.1.2  pcmcia_core
> Jan 12 21:20:21 192.168.1.2  uhci_hcd
> Jan 12 21:20:21 192.168.1.2  ehci_hcd
> Jan 12 21:20:21 192.168.1.2  snd_intel8x0m
> Jan 12 21:20:21 192.168.1.2  i2c_i801
> Jan 12 21:20:21 192.168.1.2  i2c_core
> Jan 12 21:20:21 192.168.1.2  snd_intel8x0
> Jan 12 21:20:21 192.168.1.2  snd_ac97_codec
> Jan 12 21:20:21 192.168.1.2  snd_ac97_bus
> Jan 12 21:20:21 192.168.1.2  snd_seq_dummy
> Jan 12 21:20:21 192.168.1.2  snd_seq_oss
> Jan 12 21:20:21 192.168.1.2  snd_seq_midi_event
> Jan 12 21:20:21 192.168.1.2  snd_seq
> Jan 12 21:20:21 192.168.1.2  snd_seq_device
> Jan 12 21:20:21 192.168.1.2  snd_pcm_oss
> Jan 12 21:20:21 192.168.1.2  snd_mixer_oss
> Jan 12 21:20:21 192.168.1.2  snd_pcm
> Jan 12 21:20:21 192.168.1.2  snd_timer
> Jan 12 21:20:21 192.168.1.2  snd
> Jan 12 21:20:21 192.168.1.2  soundcore
> Jan 12 21:20:21 192.168.1.2  snd_page_alloc
> Jan 12 21:20:21 192.168.1.2  ipw2200
> Jan 12 21:20:21 192.168.1.2  ieee80211
> Jan 12 21:20:21 192.168.1.2  ieee80211_crypt
> Jan 12 21:20:21 192.168.1.2
> Jan 12 21:20:21 192.168.1.2 CPU:    0
> Jan 12 21:20:21 192.168.1.2 EIP:    0060:[<f8b589a9>]    Not tainted VLI
> Jan 12 21:20:21 192.168.1.2 EFLAGS: 00010206   (2.6.15-git7)
> Jan 12 21:20:21 192.168.1.2 EIP is at ip6_xmit+0x1e0/0x303 [ipv6]
> Jan 12 21:20:21 192.168.1.2 eax: f0efbc80   ebx: f0dda250   ecx:
> 00000040   edx: 00000000
> Jan 12 21:20:21 192.168.1.2 esi: c038eeec   edi: f0dda278   ebp:
> 00000000   esp: c038ee98
> Jan 12 21:20:21 192.168.1.2 ds: 007b   es: 007b   ss: 0068
> Jan 12 21:20:21 192.168.1.2 Process gnome-panel (pid: 3952,
> threadinfo=c038e000 task=f1288580)
> Jan 12 21:20:21 192.168.1.2
> Jan 12 21:20:21 192.168.1.2 Stack:
> Jan 12 21:20:21 192.168.1.2
> Jan 12 21:20:21 192.168.1.2 00000000
> Jan 12 21:20:21 192.168.1.2 f591fb80
> Jan 12 21:20:21 192.168.1.2 00000014
> Jan 12 21:20:21 192.168.1.2 f0efbc80
> Jan 12 21:20:21 192.168.1.2 c038eedc
> Jan 12 21:20:21 192.168.1.2 06efbca8
> Jan 12 21:20:21 192.168.1.2 f0efbca8
> Jan 12 21:20:21 192.168.1.2 c038eeec
> Jan 12 21:20:21 192.168.1.2
> Jan 12 21:20:21 192.168.1.2
> Jan 12 21:20:21 192.168.1.2 f0efbc80
> Jan 12 21:20:21 192.168.1.2 00000000
> Jan 12 21:20:21 192.168.1.2 f8b70e01
> Jan 12 21:20:21 192.168.1.2 00000000
> Jan 12 21:20:21 192.168.1.2 00000000
> Jan 12 21:20:21 192.168.1.2 f0f1df1c
> Jan 12 21:20:21 192.168.1.2 f0efbc80
> Jan 12 21:20:21 192.168.1.2 00000002
> Jan 12 21:20:21 192.168.1.2
> Jan 12 21:20:21 192.168.1.2
> Jan 12 21:20:21 192.168.1.2 00000000
> Jan 12 21:20:21 192.168.1.2 last message repeated 3 times
> Jan 12 21:20:21 192.168.1.2 01000000
> Jan 12 21:20:21 192.168.1.2 00000000
> Jan 12 21:20:21 192.168.1.2 last message repeated 2 times
> Jan 12 21:20:21 192.168.1.2
> Jan 12 21:20:21 192.168.1.2 Call Trace:
> Jan 12 21:20:22 192.168.1.2  [<f8b70e01>]
> Jan 12 21:20:22 192.168.1.2  tcp_v6_send_reset+0x1e7/0x22c [ipv6]
> Jan 12 21:20:22 192.168.1.2
> Jan 12 21:20:22 192.168.1.2  [<f8b724c2>]
> Jan 12 21:20:22 192.168.1.2  tcp_v6_rcv+0x695/0x6c9 [ipv6]
> Jan 12 21:20:22 192.168.1.2
> Jan 12 21:20:22 192.168.1.2  [<c02975ba>]
> Jan 12 21:20:22 192.168.1.2  tcp_v4_rcv+0x307/0x722
> Jan 12 21:20:22 192.168.1.2
> Jan 12 21:20:22 192.168.1.2  [<c010ae17>]
> Jan 12 21:20:22 192.168.1.2  get_offset_pmtmr+0x10/0x4d
> Jan 12 21:20:22 192.168.1.2
> Jan 12 21:20:22 192.168.1.2  [<f8b5aa39>]
> Jan 12 21:20:22 192.168.1.2  ip6_input+0x1a1/0x24e [ipv6]
> Jan 12 21:20:22 192.168.1.2
> Jan 12 21:20:22 192.168.1.2  [<f8b5a84e>]
> Jan 12 21:20:22 192.168.1.2  ipv6_rcv+0x1ad/0x1f7 [ipv6]
> Jan 12 21:20:22 192.168.1.2
> Jan 12 21:20:22 192.168.1.2  [<c026fab7>]
> Jan 12 21:20:22 192.168.1.2  netif_receive_skb+0x164/0x192
> Jan 12 21:20:22 192.168.1.2
> Jan 12 21:20:22 192.168.1.2  [<c026fb50>]
> Jan 12 21:20:22 192.168.1.2  process_backlog+0x6b/0xd0
> Jan 12 21:20:22 192.168.1.2
> Jan 12 21:20:22 192.168.1.2  [<c026fc1f>]
> Jan 12 21:20:22 192.168.1.2  net_rx_action+0x6a/0xff
> Jan 12 21:20:22 192.168.1.2
> Jan 12 21:20:22 192.168.1.2  [<c0114d5d>]
> Jan 12 21:20:22 192.168.1.2  __do_softirq+0x35/0x7d
> Jan 12 21:20:22 192.168.1.2
> Jan 12 21:20:22 192.168.1.2  [<c0103b0b>]
> Jan 12 21:20:22 192.168.1.2  do_softirq+0x38/0x3f
> Jan 12 21:20:22 192.168.1.2
> Jan 12 21:20:22 192.168.1.2  =======================
> Jan 12 21:20:22 192.168.1.2  [<c0114df6>]
> Jan 12 21:20:22 192.168.1.2  local_bh_enable+0x51/0x5c
> Jan 12 21:20:22 192.168.1.2
> Jan 12 21:20:22 192.168.1.2  [<c026f753>]
> Jan 12 21:20:22 192.168.1.2  dev_queue_xmit+0x1d3/0x1d9
> Jan 12 21:20:22 192.168.1.2
> Jan 12 21:20:22 192.168.1.2  [<c0273c6b>]
> Jan 12 21:20:22 192.168.1.2  neigh_resolve_output+0xe4/0x128
> Jan 12 21:20:22 192.168.1.2
> Jan 12 21:20:22 192.168.1.2  [<f8b58691>]
> Jan 12 21:20:22 192.168.1.2  ip6_output2+0x1f4/0x232 [ipv6]
> Jan 12 21:20:22 192.168.1.2
> Jan 12 21:20:22 192.168.1.2  [<f8b58a35>]
> Jan 12 21:20:22 192.168.1.2  ip6_xmit+0x26c/0x303 [ipv6]
> Jan 12 21:20:22 192.168.1.2
> Jan 12 21:20:22 192.168.1.2  [<f8b75aa3>]
> Jan 12 21:20:22 192.168.1.2  inet6_csk_xmit+0x227/0x238 [ipv6]
> Jan 12 21:20:22 192.168.1.2
> Jan 12 21:20:22 192.168.1.2  [<f8b70bd6>]
> Jan 12 21:20:22 192.168.1.2  tcp_v6_send_check+0x7b/0xbf [ipv6]
> Jan 12 21:20:22 192.168.1.2
> Jan 12 21:20:22 192.168.1.2  [<c02928c7>]
> Jan 12 21:20:22 192.168.1.2  tcp_transmit_skb+0x3b4/0x3d6
> Jan 12 21:20:22 192.168.1.2
> Jan 12 21:20:22 192.168.1.2  [<c0294891>]
> Jan 12 21:20:22 192.168.1.2  tcp_connect+0x132/0x18f
> Jan 12 21:20:22 192.168.1.2
> Jan 12 21:20:22 192.168.1.2  [<f8b70396>]
> Jan 12 21:20:22 192.168.1.2  tcp_v6_connect+0x45f/0x571 [ipv6]
> Jan 12 21:20:22 192.168.1.2
> Jan 12 21:20:22 192.168.1.2  [<c018ca96>]
> Jan 12 21:20:22 192.168.1.2  avc_has_perm_noaudit+0x29/0xbc
> Jan 12 21:20:22 192.168.1.2
> Jan 12 21:20:22 192.168.1.2  [<c02a08ff>]
> Jan 12 21:20:22 192.168.1.2  inet_stream_connect+0x7a/0x148
> Jan 12 21:20:22 192.168.1.2
> Jan 12 21:20:22 192.168.1.2  [<c0268845>]
> Jan 12 21:20:22 192.168.1.2  sys_connect+0x76/0x98
> Jan 12 21:20:22 192.168.1.2
> Jan 12 21:20:22 192.168.1.2  [<c026a74b>]
> Jan 12 21:20:22 192.168.1.2  lock_sock+0x17/0x3f
> Jan 12 21:20:22 192.168.1.2
> Jan 12 21:20:22 192.168.1.2  [<c02698ff>]
> Jan 12 21:20:22 192.168.1.2  sock_setsockopt+0x458/0x462
> Jan 12 21:20:22 192.168.1.2
> Jan 12 21:20:22 192.168.1.2  [<c026915f>]
> Jan 12 21:20:22 192.168.1.2  sys_socketcall+0x90/0x1a2
> Jan 12 21:20:22 192.168.1.2
> Jan 12 21:20:22 192.168.1.2  [<c0102409>]
> Jan 12 21:20:22 192.168.1.2  syscall_call+0x7/0xb
> Jan 12 21:20:22 192.168.1.2
> Jan 12 21:20:22 192.168.1.2 Code:
> Jan 12 21:20:22 192.168.1.2 b6
> Jan 12 21:20:22 192.168.1.2 c2
> Jan 12 21:20:22 192.168.1.2 c1
> Jan 12 21:20:22 192.168.1.2 e0
> Jan 12 21:20:22 192.168.1.2 08
> Jan 12 21:20:22 192.168.1.2 c1
> Jan 12 21:20:22 192.168.1.2 ea
> Jan 12 21:20:22 192.168.1.2 08
> Jan 12 21:20:22 192.168.1.2 09
> Jan 12 21:20:22 192.168.1.2 d0
> Jan 12 21:20:22 192.168.1.2 66
> Jan 12 21:20:22 192.168.1.2 89
> Jan 12 21:20:22 192.168.1.2 43
> Jan 12 21:20:22 192.168.1.2 04
> Jan 12 21:20:22 192.168.1.2 8a
> Jan 12 21:20:22 192.168.1.2 44
> Jan 12 21:20:22 192.168.1.2 24
> Jan 12 21:20:22 192.168.1.2 17
> Jan 12 21:20:22 192.168.1.2 88
> Jan 12 21:20:22 192.168.1.2 4b
> Jan 12 21:20:22 192.168.1.2 07
> Jan 12 21:20:22 192.168.1.2 88
> Jan 12 21:20:22 192.168.1.2 43
> Jan 12 21:20:22 192.168.1.2 06
> Jan 12 21:20:22 192.168.1.2 a5
> Jan 12 21:20:22 192.168.1.2 last message repeated 3 times
> Jan 12 21:20:22 192.168.1.2 8b
> Jan 12 21:20:22 192.168.1.2 74
> Jan 12 21:20:22 192.168.1.2 24
> Jan 12 21:20:22 192.168.1.2 10
> Jan 12 21:20:22 192.168.1.2 8d
> Jan 12 21:20:22 192.168.1.2 7b
> Jan 12 21:20:22 192.168.1.2 18
> Jan 12 21:20:23 192.168.1.2 a5
> Jan 12 21:20:23 192.168.1.2 last message repeated 3 times
> Jan 12 21:20:23 192.168.1.2 8b
> Jan 12 21:20:23 192.168.1.2 44
> Jan 12 21:20:23 192.168.1.2 24
> Jan 12 21:20:23 192.168.1.2 0c
> Jan 12 21:20:23 192.168.1.2 b>
> Jan 12 21:20:23 192.168.1.2 95
> Jan 12 21:20:22 192.168.1.2 a5
> Jan 12 21:20:22 192.168.1.2 last message repeated 3 times
> Jan 12 21:20:22 192.168.1.2 8b
> Jan 12 21:20:22 192.168.1.2 74
> Jan 12 21:20:22 192.168.1.2 24
> Jan 12 21:20:22 192.168.1.2 10
> Jan 12 21:20:22 192.168.1.2 8d
> Jan 12 21:20:22 192.168.1.2 7b
> Jan 12 21:20:22 192.168.1.2 18
> Jan 12 21:20:23 192.168.1.2 a5
> Jan 12 21:20:23 192.168.1.2 last message repeated 3 times
> Jan 12 21:20:23 192.168.1.2 8b
> Jan 12 21:20:23 192.168.1.2 44
> Jan 12 21:20:23 192.168.1.2 24
> Jan 12 21:20:23 192.168.1.2 0c
> Jan 12 21:20:23 192.168.1.2 b>
> Jan 12 21:20:23 192.168.1.2 95
> Jan 12 21:20:23 192.168.1.2 ac
> Jan 12 21:20:23 192.168.1.2 00
> Jan 12 21:20:23 192.168.1.2 last message repeated 2 times
> Jan 12 21:20:23 192.168.1.2 89
> Jan 12 21:20:23 192.168.1.2 50
> Jan 12 21:20:23 192.168.1.2 70
> Jan 12 21:20:23 192.168.1.2 8b
> Jan 12 21:20:23 192.168.1.2 44
> Jan 12 21:20:23 192.168.1.2 24
> Jan 12 21:20:23 192.168.1.2 04
> Jan 12 21:20:23 192.168.1.2 8b
> Jan 12 21:20:23 192.168.1.2 58
> Jan 12 21:20:23 192.168.1.2 2c
> Jan 12 21:20:23 192.168.1.2 8b
> Jan 12 21:20:23 192.168.1.2 44
> Jan 12 21:20:23 192.168.1.2 24
> Jan 12 21:20:23 192.168.1.2 0c
> Jan 12 21:20:23 192.168.1.2 39
> Jan 12 21:20:23 192.168.1.2
> Jan 12 21:20:23 192.168.1.2
> Jan 12 21:20:23 192.168.1.2 Kernel panic - not syncing: Fatal
> exception in interrupt
> Jan 12 21:20:23 192.168.1.2
>
>
> Oh, and despite the apparently dead keyboard, Alt-SysRQ
>  still produces output. This is SysRQ-P:
>
> Jan 12 21:31:25 192.168.1.2 SysRq :
> Jan 12 21:31:25 192.168.1.2 Show Regs
> Jan 12 21:31:25 192.168.1.2
> Jan 12 21:31:25 192.168.1.2 Pid: 3952, comm:          gnome-panel
> Jan 12 21:31:25 192.168.1.2 EIP: 0060:[<c010adff>] CPU: 0
> Jan 12 21:31:25 192.168.1.2 EIP is at delay_pmtmr+0xb/0x13
> Jan 12 21:31:25 192.168.1.2  EFLAGS: 00000287    Not tainted  (2.6.15-git7)
> Jan 12 21:31:25 192.168.1.2 EAX: 700094a9 EBX: 000c1b82 ECX: 70002b15
> EDX: 000000e6
> Jan 12 21:31:25 192.168.1.2 ESI: 00000206 EDI: 00000000 EBP: c02ca49e
> Jan 12 21:31:25 192.168.1.2  DS: 007b ES: 007b
> Jan 12 21:31:25 192.168.1.2 CR0: 8005003b CR2: 000000ac CR3: 31319000
> CR4: 000006d0
> Jan 12 21:31:25 192.168.1.2  [<c01aaab9>]
> Jan 12 21:31:25 192.168.1.2  __delay+0x9/0xa
> Jan 12 21:31:25 192.168.1.2
> Jan 12 21:31:25 192.168.1.2  [<c0111043>]
> Jan 12 21:31:25 192.168.1.2  panic+0xbf/0xc2
> Jan 12 21:31:25 192.168.1.2
> Jan 12 21:31:25 192.168.1.2  [<c0102bf5>]
> Jan 12 21:31:25 192.168.1.2  die+0x11d/0x127
> Jan 12 21:31:25 192.168.1.2
> Jan 12 21:31:25 192.168.1.2  [<c010cf7c>]
> Jan 12 21:31:25 192.168.1.2  do_page_fault+0x0/0x4b1
> Jan 12 21:31:25 192.168.1.2
> Jan 12 21:31:25 192.168.1.2  [<c010d2f1>]
> Jan 12 21:31:25 192.168.1.2  do_page_fault+0x375/0x4b1
> Jan 12 21:31:25 192.168.1.2
> Jan 12 21:31:25 192.168.1.2  [<f8b589a9>]
> Jan 12 21:31:25 192.168.1.2  ip6_xmit+0x1e0/0x303 [ipv6]
> Jan 12 21:31:25 192.168.1.2
> Jan 12 21:31:25 192.168.1.2  [<c010cf7c>]
> Jan 12 21:31:25 192.168.1.2  do_page_fault+0x0/0x4b1
> Jan 12 21:31:25 192.168.1.2
> Jan 12 21:31:25 192.168.1.2  [<c0102633>]
> Jan 12 21:31:25 192.168.1.2  error_code+0x4f/0x54
> Jan 12 21:31:25 192.168.1.2
> Jan 12 21:31:25 192.168.1.2  [<f8b6007b>]
> Jan 12 21:31:25 192.168.1.2  ipip6_tunnel_ioctl+0x6c/0x269 [ipv6]
> Jan 12 21:31:25 192.168.1.2
> Jan 12 21:31:25 192.168.1.2  [<f8b589a9>]
> Jan 12 21:31:25 192.168.1.2  ip6_xmit+0x1e0/0x303 [ipv6]
> Jan 12 21:31:25 192.168.1.2
> Jan 12 21:31:25 192.168.1.2  [<f8b70e01>]
> Jan 12 21:31:25 192.168.1.2  tcp_v6_send_reset+0x1e7/0x22c [ipv6]
> Jan 12 21:31:25 192.168.1.2
> Jan 12 21:31:25 192.168.1.2  [<f8b724c2>]
> Jan 12 21:31:25 192.168.1.2  tcp_v6_rcv+0x695/0x6c9 [ipv6]
> Jan 12 21:31:25 192.168.1.2
> Jan 12 21:31:25 192.168.1.2  [<c02975ba>]
> Jan 12 21:31:25 192.168.1.2  tcp_v4_rcv+0x307/0x722
> Jan 12 21:31:25 192.168.1.2
> Jan 12 21:31:25 192.168.1.2  [<c010ae17>]
> Jan 12 21:31:25 192.168.1.2  get_offset_pmtmr+0x10/0x4d
> Jan 12 21:31:25 192.168.1.2
> Jan 12 21:31:25 192.168.1.2  [<f8b5aa39>]
> Jan 12 21:31:25 192.168.1.2  ip6_input+0x1a1/0x24e [ipv6]
> Jan 12 21:31:25 192.168.1.2
> Jan 12 21:31:25 192.168.1.2  [<f8b5a84e>]
> Jan 12 21:31:25 192.168.1.2  ipv6_rcv+0x1ad/0x1f7 [ipv6]
> Jan 12 21:31:25 192.168.1.2
> Jan 12 21:31:25 192.168.1.2  [<c026fab7>]
> Jan 12 21:31:25 192.168.1.2  netif_receive_skb+0x164/0x192
> Jan 12 21:31:25 192.168.1.2
> Jan 12 21:31:25 192.168.1.2  [<c026fb50>]
> Jan 12 21:31:25 192.168.1.2  process_backlog+0x6b/0xd0
> Jan 12 21:31:25 192.168.1.2
> Jan 12 21:31:25 192.168.1.2  [<c026fc1f>]
> Jan 12 21:31:25 192.168.1.2  net_rx_action+0x6a/0xff
> Jan 12 21:31:25 192.168.1.2
> Jan 12 21:31:25 192.168.1.2  [<c0114d5d>]
> Jan 12 21:31:25 192.168.1.2  __do_softirq+0x35/0x7d
> Jan 12 21:31:25 192.168.1.2
> Jan 12 21:31:25 192.168.1.2  [<c0103b0b>]
> Jan 12 21:31:25 192.168.1.2  do_softirq+0x38/0x3f
> Jan 12 21:31:25 192.168.1.2
> Jan 12 21:31:25 192.168.1.2  =======================
> Jan 12 21:31:25 192.168.1.2  [<c0114df6>]
> Jan 12 21:31:25 192.168.1.2  local_bh_enable+0x51/0x5c
> Jan 12 21:31:25 192.168.1.2
> Jan 12 21:31:25 192.168.1.2  [<c026f753>]
> Jan 12 21:31:25 192.168.1.2  dev_queue_xmit+0x1d3/0x1d9
> Jan 12 21:31:25 192.168.1.2
> Jan 12 21:31:25 192.168.1.2  [<c0273c6b>]
> Jan 12 21:31:25 192.168.1.2  neigh_resolve_output+0xe4/0x128
> Jan 12 21:31:25 192.168.1.2
> Jan 12 21:31:25 192.168.1.2  [<f8b58691>]
> Jan 12 21:31:25 192.168.1.2  ip6_output2+0x1f4/0x232 [ipv6]
> Jan 12 21:31:25 192.168.1.2
> Jan 12 21:31:25 192.168.1.2  [<f8b58a35>]
> Jan 12 21:31:25 192.168.1.2  ip6_xmit+0x26c/0x303 [ipv6]
> Jan 12 21:31:25 192.168.1.2
> Jan 12 21:31:25 192.168.1.2  [<f8b75aa3>]
> Jan 12 21:31:25 192.168.1.2  inet6_csk_xmit+0x227/0x238 [ipv6]
> Jan 12 21:31:26 192.168.1.2
> Jan 12 21:31:26 192.168.1.2  [<f8b70bd6>]
> Jan 12 21:31:26 192.168.1.2  tcp_v6_send_check+0x7b/0xbf [ipv6]
> Jan 12 21:31:26 192.168.1.2
> Jan 12 21:31:26 192.168.1.2  [<c02928c7>]
> Jan 12 21:31:26 192.168.1.2  tcp_transmit_skb+0x3b4/0x3d6
> Jan 12 21:31:26 192.168.1.2
> Jan 12 21:31:26 192.168.1.2  [<c0294891>]
> Jan 12 21:31:26 192.168.1.2  tcp_connect+0x132/0x18f
> Jan 12 21:31:26 192.168.1.2
> Jan 12 21:31:26 192.168.1.2  [<f8b70396>]
> Jan 12 21:31:26 192.168.1.2  tcp_v6_connect+0x45f/0x571 [ipv6]
> Jan 12 21:31:26 192.168.1.2
> Jan 12 21:31:26 192.168.1.2  [<c018ca96>]
> Jan 12 21:31:26 192.168.1.2  avc_has_perm_noaudit+0x29/0xbc
> Jan 12 21:31:26 192.168.1.2
> Jan 12 21:31:26 192.168.1.2  [<c02a08ff>]
> Jan 12 21:31:26 192.168.1.2  inet_stream_connect+0x7a/0x148
> Jan 12 21:31:26 192.168.1.2
> Jan 12 21:31:26 192.168.1.2  [<c0268845>]
> Jan 12 21:31:26 192.168.1.2  sys_connect+0x76/0x98
> Jan 12 21:31:26 192.168.1.2
> Jan 12 21:31:26 192.168.1.2  [<c026a74b>]
> Jan 12 21:31:26 192.168.1.2  lock_sock+0x17/0x3f
> Jan 12 21:31:26 192.168.1.2
> Jan 12 21:31:26 192.168.1.2  [<c02698ff>]
> Jan 12 21:31:26 192.168.1.2  sock_setsockopt+0x458/0x462
> Jan 12 21:31:26 192.168.1.2
> Jan 12 21:31:26 192.168.1.2  [<c026915f>]
> Jan 12 21:31:26 192.168.1.2  sys_socketcall+0x90/0x1a2
> Jan 12 21:31:26 192.168.1.2
> Jan 12 21:31:26 192.168.1.2  [<c0102409>]
> Jan 12 21:31:26 192.168.1.2  syscall_call+0x7/0xb
> Jan 12 21:31:26 192.168.1.2
>
>
> Any other stuff I can do - just ask. As of now, I'm stuck
>  with -git5 due to this showstopper...
>
> Thanks !  Ciao,

The problem appears to be gone in 2.6.15-git8. No more
 syslog messages from ainit, logout from Gnome doesn't
 lock the box up anymore.

Thanks,

--alessandro

 "Somehow all you ever need is, never really quite enough, you know"

   (Bruce Springsteen - "Reno")
