Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269928AbUJTKmF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269928AbUJTKmF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 06:42:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269870AbUJTKjY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 06:39:24 -0400
Received: from smtp2.netcabo.pt ([212.113.174.29]:6822 "EHLO smtp.netcabo.pt")
	by vger.kernel.org with ESMTP id S269475AbUJTKdw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 06:33:52 -0400
Message-ID: <11742.195.245.190.93.1098268363.squirrel@195.245.190.93>
In-Reply-To: <20041020100424.GA32396@elte.hu>
References: <20041013061518.GA1083@elte.hu> <20041014002433.GA19399@elte.hu>
    <20041014143131.GA20258@elte.hu> <20041014234202.GA26207@elte.hu>
    <20041015102633.GA20132@elte.hu> <20041016153344.GA16766@elte.hu>
    <20041018145008.GA25707@elte.hu> <20041019124605.GA28896@elte.hu>
    <20041019180059.GA23113@elte.hu> <20041020094508.GA29080@elte.hu>
    <20041020100424.GA32396@elte.hu>
Date: Wed, 20 Oct 2004 11:32:43 +0100 (WEST)
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-rc4-mm1-U8
From: "Rui Nuno Capela" <rncbc@rncbc.org>
To: "Ingo Molnar" <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, "Lee Revell" <rlrevell@joe-job.com>,
       mark_h_johnson@raytheon.com, "K.R. Foley" <kr@cybsft.com>,
       "Bill Huey" <bhuey@lnxw.com>, "Adam Heath" <doogie@debian.org>,
       "Florian Schmidt" <mista.tapas@gmx.net>,
       "Thomas Gleixner" <tglx@linutronix.de>,
       "Michal Schmidt" <xschmi00@stud.feec.vutbr.cz>,
       "Fernando Pablo Lopez-Lezcano" <nando@ccrma.stanford.edu>
User-Agent: SquirrelMail/1.4.3a
X-Mailer: SquirrelMail/1.4.3a
MIME-Version: 1.0
Content-Type: multipart/mixed;boundary="----=_20041020113243_40761"
X-Priority: 3 (Normal)
Importance: Normal
X-OriginalArrivalTime: 20 Oct 2004 10:33:46.0257 (UTC) FILETIME=[47651810:01C4B690]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_20041020113243_40761
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

Ingo Molnar wrote:
>
>> Changes since -U7:
>>
>
> - fix block-loopback assert reported by Mark H Johnson, Matthew L
>   Foster and Rui Nuno Capela. (usually triggers during 'make install'
>   of a kernel compile.)
>

Is this fix already on U8 ? I don't seem to get out of mkinitrd (which is
triggered by kernel make install).

OTOH, still on my laptop (P4/UP) I'm getting this very often:

RTNL: assertion failed at net/ipv4/devinet.c (1049)
 [<c0104ee4>] dump_stack+0x1e/0x20 (20)
 [<c02afa2b>] inet_dump_ifaddr+0x135/0x13a (52)
 [<c027a533>] rtnetlink_dump_all+0x92/0xaa (40)
 [<c028117f>] netlink_dump+0x6c/0x211 (56)
 [<c0280f97>] netlink_recvmsg+0x209/0x21b (92)
 [<c0268a40>] sock_recvmsg+0xcc/0xf0 (248)
 [<c026a4cc>] sys_recvmsg+0x110/0x1fb (284)
 [<c026a628>] sys_socketcall+0x71/0x234 (68)
 [<c01040a9>] sysenter_past_esp+0x52/0x71 (-8124)
preempt count: 00000001
. 1-level deep critical section nesting:
.. entry 1: print_traces+0x16/0x4a / (dump_stack+0x1e/0x20)


And I also found this once:

------------[ cut here ]------------
kernel BUG at lib/rwsem-generic.c:598!
invalid operand: 0000 [#1]
PREEMPT
Modules linked in: realtime commoncap snd_seq_oss snd_seq_midi_event
snd_seq snd_pcm_oss snd_mixer_oss snd_usb_usx2y snd_usb_lib snd_rawmidi
snd_seq_device snd_hwdep snd_ali5451 snd_ac97_codec snd_pcm snd_timer
snd_page_alloc snd soundcore prism2_cs p80211 ds yenta_socket pcmcia_core
natsemi crc32 loop subfs evdev ohci_hcd usbcore thermal processor fan
button battery ac
CPU:    0
EIP:    0060:[<c01b7e30>]    Not tainted VLI
EFLAGS: 00010202   (2.6.9-rc4-mm1-RT-U8.0)
EIP is at up_write+0x1d4/0x202
eax: d4edc000   ebx: e003f967   ecx: d4eb8d40   edx: dee04020
esi: de9b4214   edi: de9b443c   ebp: d4eddfcc   esp: d4eddfac
ds: 007b   es: 007b   ss: 0068   preempt: 00000001
Process loop0 (pid: 6672, threadinfo=d4edc000 task=d4eb8d40)
Stack: c0113b01 00000001 c0384d90 c0384d60 00000282 e003f967 de9b4000
de9b443c
       d4eddfec e003f9c8 d4eb8d40 ffffffec 00000000 e003f967 00000000
00000000
       00000000 c0102305 de9b4000 00000000 00000000
Call Trace:
 [<c0104eb0>] show_stack+0x80/0x96 (28)
 [<c010504b>] show_registers+0x165/0x1de (56)
 [<c010525d>] die+0xf6/0x191 (64)
 [<c0105797>] do_invalid_op+0x10b/0x10d (188)
 [<c0104b0d>] error_code+0x2d/0x38 (100)
 [<e003f9c8>] loop_thread+0x61/0x11b [loop] (32)
 [<c0102305>] kernel_thread_helper+0x5/0xb (722608148)
preempt count: 00000002
. 2-level deep critical section nesting:
.. entry 1: die+0x3a/0x191 / (do_invalid_op+0x10b/0x10d)
.. entry 2: print_traces+0x16/0x4a / (show_stack+0x80/0x96)

Code: e8 af f9 ff ff 89 f8 e8 f1 af f5 ff e9 35 ff ff ff 0f 0b a5 00 43 e4
2c c0 e9 da fe ff ff 0f 0b a4 00 43 e4 2c c0 e9 c4 fe ff ff <0f> 0b 56 02
cf 70 2d c0 e9 3c fe ff ff e8 d7 56 10 00 e9 22 ff


(config.gz is attached)

Bye now.
-- 
rncbc aka Rui Nuno Capela
rncbc@rncbc.org
------=_20041020113243_40761
Content-Type: application/x-gzip-compressed;
      name="config-2.6.9-rc4-mm1-RT-U8.0.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="config-2.6.9-rc4-mm1-RT-U8.0.gz"

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
------=_20041020113243_40761--


