Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267558AbUJTMr7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267558AbUJTMr7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 08:47:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270044AbUJTMqc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 08:46:32 -0400
Received: from smtp2.netcabo.pt ([212.113.174.29]:7039 "EHLO smtp.netcabo.pt")
	by vger.kernel.org with ESMTP id S267558AbUJTMmL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 08:42:11 -0400
Message-ID: <5494.195.245.190.94.1098276051.squirrel@195.245.190.94>
In-Reply-To: <20041020114312.GA5418@elte.hu>
References: <20041015102633.GA20132@elte.hu> <20041016153344.GA16766@elte.hu>
    <20041018145008.GA25707@elte.hu> <20041019124605.GA28896@elte.hu>
    <20041019180059.GA23113@elte.hu> <20041020094508.GA29080@elte.hu>
    <20041020100424.GA32396@elte.hu>
    <11742.195.245.190.93.1098268363.squirrel@195.245.190.93>
    <20041020104005.GA1813@elte.hu>
    <15773.195.245.190.94.1098271919.squirrel@195.245.190.94>
    <20041020114312.GA5418@elte.hu>
Date: Wed, 20 Oct 2004 13:40:51 +0100 (WEST)
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
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
X-OriginalArrivalTime: 20 Oct 2004 12:42:04.0622 (UTC) FILETIME=[33FA5EE0:01C4B6A2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
>
>> >> RTNL: assertion failed at net/ipv4/devinet.c (1049)
>> >
>> > yeah - this too was an oversight i fixed in the latest upload.
>>
>> I don't think so. I still see plenty of those here.
>>
>> Is there an even more recent U8? I think you should consider add some
>> dot numbering to each of the uploads... ;)
>
> indeed this most likely means there's a newer update :-| Please
> double-check that the one you have is:
>
>  $ md5sum realtime-preempt-2.6.9-rc4-mm1-U8
>  b59ae00ca0f45f545519348113af5c4f  realtime-preempt-2.6.9-rc4-mm1-U8
>

That was it. Thanks.

Now's some bad news:

I getting the dump below, this time while plugging a flash memory stick,
but right after that the system starts to behave preety bad and
increasingly unresponsive. An hard-boot is almost the end of the (short)
story :(

(e.g. running jackd also hoses the complete system in no reproducible
amount of time--sometimes short, other times long, like a random
time-bomb).


ohci_hcd 0000:00:0f.0: wakeup
usb 2-1: new full speed USB device using address 2
Initializing USB Mass Storage driver...
scsi0 : SCSI emulation for USB Mass Storage devices
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
usb-storage: device found at 2
usb-storage: waiting for device to settle before scanning
------------[ cut here ]------------
kernel BUG at lib/rwsem-generic.c:598!
invalid operand: 0000 [#1]
PREEMPT
Modules linked in: usb_storage vfat fat udf isofs nls_base realtime
commoncap snd_seq_oss snd_seq_midi_event snd_seq snd_pcm_oss snd_mixer_oss
snd_usb_usx2y snd_usb_lib snd_rawmidi snd_seq_device snd_hwdep snd_ali5451
snd_ac97_codec snd_pcm snd_timer snd_page_alloc snd soundcore prism2_cs
p80211 ds yenta_socket pcmcia_core natsemi crc32 loop subfs evdev ohci_hcd
usbcore thermal processor fan button battery ac
CPU:    0
EIP:    0060:[<c01b7e30>]    Not tainted VLI
EFLAGS: 00010206   (2.6.9-rc4-mm1-RT-U8.3)
EIP is at up_write+0x1d4/0x202
eax: d2b2a000   ebx: 00000292   ecx: d2afe980   edx: d2ad4f40
esi: d7b83b24   edi: dcb21000   ebp: d2b2bd6c   esp: d2b2bd4c
ds: 007b   es: 007b   ss: 0068   preempt: 00000001
Process usb-stor (pid: 6699, threadinfo=d2b2a000 task=d2ad48b0)
Stack: d2ad48b0 d2b2bd78 c02bea7f 00000001 d2ad48b0 00000292 d2afe980
dcb21000
       d2b2bd84 e01ca139 d2afe980 d2b2bd84 00000292 dcb21138 d2b2bdac
c022ed18
       d2afe980 c022ef1c c0231679 00000000 d2afe9d4 d2afe980 d2aa3800
dcb21000
Call Trace:
 [<c0104eb0>] show_stack+0x80/0x96 (28)
 [<c010504b>] show_registers+0x165/0x1de (56)
 [<c010525d>] die+0xf6/0x191 (64)
 [<c0105797>] do_invalid_op+0x10b/0x10d (188)
 [<c0104b0d>] error_code+0x2d/0x38 (100)
 [<e01ca139>] queuecommand+0x70/0x7c [usb_storage] (24)
 [<c022ed18>] scsi_dispatch_cmd+0x168/0x218 (40)
 [<c02342ed>] scsi_request_fn+0x1ee/0x42b (52)
 [<c0205612>] blk_insert_request+0xcd/0xfb (44)
 [<c0232f4f>] scsi_insert_special_req+0x3b/0x3f (28)
 [<c0233181>] scsi_wait_req+0x61/0x94 (60)
 [<c023529c>] scsi_probe_lun+0x8e/0x240 (68)
 [<c023588f>] scsi_probe_and_add_lun+0xb0/0x1be (48)
 [<c0236015>] scsi_scan_target+0xa4/0x123 (60)
 [<c0236121>] scsi_scan_channel+0x8d/0xa4 (48)
 [<c02361b1>] scsi_scan_host_selected+0x79/0xd4 (44)
 [<c023623d>] scsi_scan_host+0x31/0x33 (28)
 [<e01cccbd>] usb_stor_scan_thread+0x144/0x155 [usb_storage] (96)
 [<c0102305>] kernel_thread_helper+0x5/0xb (760037396)
preempt count: 00000002
. 2-level deep critical section nesting:
.. entry 1: die+0x3a/0x191 / (do_invalid_op+0x10b/0x10d)
.. entry 2: print_traces+0x16/0x4a / (show_stack+0x80/0x96)

Code: e8 af f9 ff ff 89 f8 e8 f1 af f5 ff e9 35 ff ff ff 0f 0b a5 00 e3 e8
2c c0 e9 da fe ff ff 0f 0b a4 00 e3 e8 2c c0 e9 c4 fe ff ff <0f> 0b 56 02
6f 75 2d c0 e9 3c fe ff ff e8 7f 5b 10 00 e9 22 ff

Bye.
-- 
rncbc aka Rui Nuno Capela
rncbc@rncbc.org


