Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964898AbWGTDVt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964898AbWGTDVt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jul 2006 23:21:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964899AbWGTDVt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jul 2006 23:21:49 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:53480 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964898AbWGTDVs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jul 2006 23:21:48 -0400
Subject: Re: [v4l-dvb-maintainer] Re: oops in bttv
From: Mauro Carvalho Chehab <mchehab@infradead.org>
To: Michael Krufky <mkrufky@linuxtv.org>
Cc: Nish Aravamudan <nish.aravamudan@gmail.com>,
       Alex Riesen <raa.lkml@gmail.com>, video4linux-list@redhat.com,
       Martin.vGagern@gmx.net, linux-kernel <linux-kernel@vger.kernel.org>,
       v4l-dvb-maintainer@linuxtv.org,
       Alex Riesen <fork0@users.sourceforge.net>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <44BE699A.5000106@linuxtv.org>
References: <20060711204940.GA11497@steel.home>
	 <1152962993.26522.18.camel@praia>
	 <81b0412b0607170634p298ab59p3c52b8c9c0cc7661@mail.gmail.com>
	 <29495f1d0607191009r736ed327y797e69ac4915e1e7@mail.gmail.com>
	 <44BE699A.5000106@linuxtv.org>
Content-Type: text/plain; charset=ISO-8859-1
Date: Thu, 20 Jul 2006 00:21:19 -0300
Message-Id: <1153365680.11903.5.camel@praia>
Mime-Version: 1.0
X-Mailer: Evolution 2.7.2.1-4mdv2007.0 
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Qua, 2006-07-19 às 13:19 -0400, Michael Krufky escreveu:
> Nish Aravamudan wrote:
> > On 7/17/06, Alex Riesen <raa.lkml@gmail.com> wrote:
> >> On 7/15/06, Mauro Carvalho Chehab <mchehab@infradead.org> wrote:
> >> > > What I did was to call settings of the flashplayer and press on the
> >> > > webcam symbol there. The system didn't crash, just this oops:
> >> > >
> >> > > BUG: unable to handle kernel NULL pointer dereference at virtual
> >> address 0000006
> >> > > 5
> >> > Hmm... Are you using it on what machine? It might be related to an
> >> > improper handling at compat32 module.
> >>
> >> 32bit. PIV, 2Gb, highmem on.
> > 
> > Is this the same bug as http://bugzilla.kernel.org/show_bug.cgi?id=6869?
> 
> It LOOKS the same to me...  I have tried to reproduce this OOPS
> unsuccessfully, but it seems to be happening for many other users.
> 
> I can't imagine why I am unable to reproduce it.
Also I couldn't reproduce it here. I'm testing with -rc2 + v4l/dvb git
patches available at my git tree
(http://www.kernel.org/git/?p=linux/kernel/git/mchehab/v4l-dvb.git;a=summary):

[  661.840349] bttv0: using tuner=4
[  661.849056] kobject tuner: registering. parent: <NULL>, set: module
[  661.849111] kobject_uevent
[  661.849125] fill_kobj_path: path = '/module/tuner'
[  661.849535] bus i2c: add driver tuner
[  661.849538] kobject tuner: registering. parent: <NULL>, set: drivers
[  661.849556] kobject_uevent
[  661.849567] fill_kobj_path: path = '/bus/i2c/drivers/tuner'
[  661.849603] i2c-core: driver [tuner] registered
[  661.849953] DEV: registering device: ID = 'dvb0'
[  661.849956] kobject dvb0: registering. parent: 0000:05:06.0, set:
devices
[  661.849976] PM: Adding info for bttv-sub:dvb0
[  661.849991] bus bttv-sub: add device dvb0
[  661.850002] kobject_uevent
[  661.850013] fill_kobj_path: path =
'/devices/pci0000:00/0000:00:09.0/0000:05:06.0/dvb0'
[  661.850043] bttv0: add subdevice "dvb0"
[  661.850048] bound device '0000:05:06.0' to driver 'bttv'


[  661.996816] bttv1: osprey eeprom: card=89 name=Osprey 210/220/230
serial=6166834
[  661.996819] bttv1: using tuner=-1
[  661.996822] bttv1: i2c: checking for TDA9887 @ 0x86... <7>i2c_adapter
i2c-1: master_xfer[0] R, addr=0x43, len=1
[  661.998953] not found
[  661.998966] CLASS: registering class device: ID = 'video0'
[  661.998969] kobject video0: registering. parent: video4linux, set:
class_obj
[  661.998997] kobject_uevent
[  661.999008] fill_kobj_path: path = '/class/video4linux/video0'
[  661.999011] class_uevent - name = video0
[  661.999014] fill_kobj_path: path =
'/devices/pci0000:00/0000:00:09.0/0000:05:08.0/0000:06:04.0'
[  661.999046] bttv1: registered device video0
[  661.999059] CLASS: registering class device: ID = 'vbi0'
[  661.999062] kobject vbi0: registering. parent: video4linux, set:
class_obj
[  661.999084] kobject_uevent
[  661.999095] fill_kobj_path: path = '/class/video4linux/vbi0'
[  661.999098] class_uevent - name = vbi0
[  661.999101] fill_kobj_path: path =
'/devices/pci0000:00/0000:00:09.0/0000:05:08.0/0000:06:04.0'
[  661.999130] bttv1: registered device vbi0
[  661.999156] bttv1: PLL: 28636363 => 35468950 . ok
[  662.015287] bound device '0000:06:04.0' to driver 'bttv'
[  662.015305] pci: Bound Device 0000:06:04.0 to Driver bttv

Both Twinhan and Osprey boards initialized well. No oops (although -rc2
had several troubles with event devices on x86_64: mouse, keyboard and
analog gameport didn't worked at the machine - I could access only via
network connection).

Cheers, 
Mauro.

