Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266221AbUAQXmj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jan 2004 18:42:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266227AbUAQXmj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jan 2004 18:42:39 -0500
Received: from b0504.opsion.fr ([62.39.122.72]:11017 "HELO b0504.idoo.com")
	by vger.kernel.org with SMTP id S266221AbUAQXmc convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jan 2004 18:42:32 -0500
Subject: Re : Alsa create high problems...
From: Eddahbi Karim <non.tu.ne.me.connais.pas.spavrai@ifrance.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Message-Id: <1074382859.29525.20.camel@gamux>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sun, 18 Jan 2004 00:41:00 +0100
Content-Transfer-Encoding: 8BIT
if-filter0: N
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm posting the answer to a mail that I received because it will maybe
help a developper to fix the problem.

Le sam 10/01/2004 à 11:31, Jaroslav Kysela a écrit :
> On Sat, 10 Jan 2004, Eddahbi Karim wrote:
> 
> > Hiya,
> > 
> > I've pretty bad problems with the ALSA driver and that drives me mad.
> > The driver seems to, sometimes, broke.
> > 
> > I'm using the kernel 2.6.1-mm1.
> > This bug doesn't happen on my 2.6.0 with hasn't PREEMPT enabled.
> > 
> > For example, in XMMS, if a program requires a lot of CPU in 1 second,
> > the song will stop and freeze in a loop (The song will repeat the last
> > second like a while(1)).
> 
> It's with via82xx or emu10k1 driver? Can you send me contents of 
> /proc/asound/card0/pcm0p/sub0/* files when the crash occurs?


Ok here it is :

access: MMAP_INTERLEAVED
format: S16_LE
subformat: STD
channels: 1
rate: 22050 (22050/1)
period_size: 1225
buffer_size: 11025
tick_time: 1000
card: 0
device: 0
subdevice: 0
stream: PLAYBACK
id: VIA 82C686A/B rev50
name: VIA 82C686A/B rev50
subname: subdevice #0
class: 0
subclass: 0
subdevices_count: 1
subdevices_avail: 0
64
state: RUNNING
trigger_time: 1073850885.877994000
tstamp      : 1073850900.726626000
delay       : 10083
avail       : 942
avail_max   : 1433
-----
hw_ptr      : 10077
appl_ptr    : 20160
tstamp_mode: NONE
period_step: 1
sleep_min: 0
avail_min: 1225
xfer_align: 1225
start_threshold: 1
stop_threshold: 11025
silence_threshold: 0
silence_size: 0
boundary: 1445068800

By the way, If I run cat /proc/asound/card0/pcm0p/sub0/* two or three
times, it unlock XMMS and continue to play

With madplay, it just unlock 1 second.

But I've found something interesting with madplay.
When the music lockup these two values are different :

avail       : 0
avail_max   : 9301

And If continue until avail_max reaches 0, madplay will play another
second of the music.

I've run madplay on a terminal and "script" on another one.

The log created by script is attached to the mail.
In the log, each time that avail and avail_max are equal after I typed
cat, madplay will play a second of the music.
If the value are different, madplay won't continue.

By the way, some informations :

It doesn't appear after a high load create by the system. The system
seems to lag after a certain amount of time.

I just power on my computer, let the screensaver plays and I saw some
lags after 30 minutes. So I launched XMMS, try to play and change to
another music and the bug appears.

The screensaver is rss-glx :
*  x11-misc/rss-glx
      Latest version available: 0.7.4-r1
      Latest version installed: 0.7.4-r1
      Size of downloaded files: 4,771 kB
      Homepage:    http://rss-glx.sourceforge.net/
      Description: Really Slick Screensavers using OpenGL for
XScreenSaver

My graphic card is a Geforce FX 5200, I'm using nvidia binary drivers.
Dmesg displays that about nvidia drivers :

Debug: sleeping function called from invalid context at mm/slab.c:1868
in_atomic():1, irqs_disabled():0
Call Trace:
 [<c011d63b>] __might_sleep+0xab/0xd0
 [<c01424e9>] __kmalloc+0x89/0x90
 [<e1f39bfc>] os_alloc_mem+0x7c/0x90 [nvidia]
 [<e1dcea20>] _nv001308rm+0x10/0x28 [nvidia]
 [<e1ee71bd>] _nv001518rm+0x7c9/0xb34 [nvidia]
 [<e1e75150>] _nv002463rm+0x78/0x194 [nvidia]
 [<e1dc4595>] _nv001338rm+0x1d/0x24 [nvidia]
 [<e1dbc868>] _nv000858rm+0x300/0xe14 [nvidia]
 [<c02add15>] ppp_start_xmit+0x105/0x290
 [<c0378e28>] qdisc_restart+0x18/0x140
 [<c0369e7c>] dev_queue_xmit+0x21c/0x2b0
 [<e1db8b1d>] _nv002962rm+0x2c5/0x3b8 [nvidia]
 [<e1dd34d9>] _nv000899rm+0x4c9/0xf70 [nvidia]
 [<e1dd34ec>] _nv000899rm+0x4dc/0xf70 [nvidia]
 [<c0394e45>] dst_output+0x15/0x30
 [<c0394e30>] dst_output+0x0/0x30
 [<c039316e>] ip_queue_xmit+0x49e/0x5b0
 [<c0394e30>] dst_output+0x0/0x30
 [<c0378e28>] qdisc_restart+0x18/0x140
 [<c0369e7c>] dev_queue_xmit+0x21c/0x2b0
 [<c0394f7f>] ip_finish_output2+0x11f/0x1e0
 [<c03a9b9a>] tcp_v4_send_check+0x4a/0xf0
 [<c03a3644>] tcp_transmit_skb+0x3c4/0x5e0
 [<c0392aa4>] ip_finish_output+0x234/0x240
 [<c03a62a2>] tcp_send_ack+0x82/0xd0
 [<e1e9a40b>] _nv001556rm+0x5b/0x6c [nvidia]
 [<e1e9a40b>] _nv001556rm+0x5b/0x6c [nvidia]
 [<e1e9ab0d>] _nv003622rm+0x15/0x1c [nvidia]
 [<e1ee3180>] _nv001826rm+0xb0/0xbc [nvidia]
 [<e1e9a40b>] _nv001556rm+0x5b/0x6c [nvidia]
 [<e1e9ab0d>] _nv003622rm+0x15/0x1c [nvidia]
 [<e1ee3180>] _nv001826rm+0xb0/0xbc [nvidia]
 [<e1e9a40b>] _nv001556rm+0x5b/0x6c [nvidia]
 [<e1e9ab0d>] _nv003622rm+0x15/0x1c [nvidia]
 [<e1e7d37d>] _nv003795rm+0xad9/0xaec [nvidia]
 [<e1e9a2cb>] _nv001532rm+0x1f/0x28 [nvidia]
 [<e1de6ec8>] _nv004240rm+0x180/0x18c [nvidia]
 [<e1e9a27c>] _nv001534rm+0x20/0x28 [nvidia]
 [<e1dcfd72>] _nv001223rm+0x12/0x18 [nvidia]
 [<e1de7277>] _nv004046rm+0x3a3/0x3b0 [nvidia]
 [<e1dcfd72>] _nv001223rm+0x12/0x18 [nvidia]
 [<e1ee8d02>] _nv001476rm+0x452/0x45c [nvidia]
 [<c011b0ea>] wake_up_state+0x1a/0x20
 [<c012a3bf>] send_group_sig_info+0x2f/0x50
 [<c01691ab>] send_sigio_to_task+0x10b/0x130
 [<c011ae40>] recalc_task_prio+0x90/0x1a0
 [<c0109a35>] __switch_to+0x145/0x1c0
 [<c011ae40>] recalc_task_prio+0x90/0x1a0
 [<c0109a35>] __switch_to+0x145/0x1c0
 [<c011bd6b>] schedule+0x35b/0x5c0
 [<c021744c>] avc_has_perm+0x6c/0x79
 [<c0112086>] convert_fxsr_from_user+0x96/0x150
 [<c02183af>] inode_has_perm+0x5f/0x90
 [<c021a8b1>] selinux_file_ioctl+0x121/0x420
 [<e1dd2be1>] rm_ioctl+0x19/0x20 [nvidia]
 [<e1f3759c>] nv_kern_ioctl+0x7c/0x490 [nvidia]
 [<c01698c5>] sys_ioctl+0x115/0x2b0
 [<c041b843>] syscall_call+0x7/0xb

Here is the md5sum of the log :
db8069da9e6a8c239db8a7b74706926a  typescript.gz

Thanks for the help,
I'm going down to my 2.6 which has the PREEMPT option activated :).

UPDATE :
It still happens on 2.6.1-mm4
while true; do cat /proc/asound/card0/pcm0p/sub0/*; done freeze if I play with XMMS.

That's a weird and annoying problem which doesn't appears on my 2.6.0.

Here is the link for typescript.gz because I don't think that I can attach a file on the LKML :
http://thetemplar.free.fr/typescript.gz

-- 
--
Eddahbi Karim

Phone :
(33) (0)6 61 30 57 77

France

_____________________________________________________________________
Envie de discuter en "live" avec vos amis ? Télécharger MSN Messenger
http://www.ifrance.com/_reloc/m la 1ère messagerie instantanée de France

