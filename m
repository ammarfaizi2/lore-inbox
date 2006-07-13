Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751348AbWGMFVU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751348AbWGMFVU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 01:21:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751384AbWGMFVU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 01:21:20 -0400
Received: from xenotime.net ([66.160.160.81]:49879 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751348AbWGMFVT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 01:21:19 -0400
Date: Wed, 12 Jul 2006 22:24:07 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Greg KH <greg@kroah.com>
Cc: 76306.1226@compuserve.com, fork0@t-online.de, linux-kernel@vger.kernel.org,
       mchehab@infradead.org, akpm@osdl.org, shemminger@osdl.org,
       video4linux-list@redhat.com, v4l-dvb-maintainer@linuxtv.org
Subject: Re: oops in bttv
Message-Id: <20060712222407.d737129c.rdunlap@xenotime.net>
In-Reply-To: <20060713050541.GA31257@kroah.com>
References: <200607130047_MC3-1-C4D3-43D6@compuserve.com>
	<20060713050541.GA31257@kroah.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Jul 2006 22:05:41 -0700 Greg KH wrote:

> On Thu, Jul 13, 2006 at 12:43:49AM -0400, Chuck Ebbert wrote:
> > In-Reply-To: <20060711204940.GA11497@steel.home>
> > 
> > On Tue, 11 Jul 2006 22:49:40 +0200, Alex Riesen wrote:
> > 
> > > What I did was to call settings of the flashplayer and press on the
> > > webcam symbol there. The system didn't crash, just this oops:
> > > 
> > > BUG: unable to handle kernel NULL pointer dereference at virtual address 00000065
> > >  printing eip:
> > > c01875b0
> > > *pde = 00000000
> > > Oops: 0000 [#1]
> > > PREEMPT SMP 
> > > Modules linked in: tuner tvaudio msp3400 bttv video_buf firmware_class ir_common
> > >  compat_ioctl32 btcx_risc tveeprom videodev v4l2_common nfs vfat fat nfsd export
> > > fs lockd sunrpc snd_pcm_oss snd_mixer_oss snd_seq_oss snd_seq_midi_event snd_seq
> > >  snd_seq_device reiserfs rtc microcode radeon drm intel_agp agpgart snd_intel8x0
> > >  snd_ac97_codec snd_ac97_bus snd_pcm snd_timer snd soundcore snd_page_alloc sd_m
> > > od usb_storage libusual usbhid uhci_hcd usbcore e100
> > > CPU:    0
> > > EIP:    0060:[<c01875b0>]    Not tainted VLI
> > > EFLAGS: 00010292   (2.6.18-rc1 #80) 
> > > EIP is at sysfs_add_file+0x10/0x76
> > > eax: 00000001   ebx: f9bd6d14   ecx: 00000004   edx: f9bd6d14
> > > esi: f9bde920   edi: 00000001   ebp: dc489eac   esp: dc489e94
> > > ds: 007b   es: 007b   ss: 0068
> > > Process modprobe (pid: 11377, ti=dc489000 task=f21ff6b0 task.ti=dc489000)
> > > Stack: f9bde920 f9bde920 00000004 f9bde920 f9bde920 00000000 dc489eb4 c018763c 
> > >        dc489ebc c0220cc3 dc489ec8 f9bc3073 c19b4800 dc489ee4 f9bc35de 00000000 
> > >        20bd7818 f9bd7880 f9bd7880 ffffffed dc489ef0 c01c3c1b c19b4800 dc489f04 
> > > Call Trace:
> > >  [<c018763c>] sysfs_create_file+0x26/0x28
> > >  [<c0220cc3>] class_device_create_file+0x14/0x1a
> > >  [<f9bc3073>] bttv_register_video+0x8c/0x147 [bttv]
> > >  [<f9bc35de>] bttv_probe+0x4ab/0x593 [bttv]
> > >  [<c01c3c1b>] pci_call_probe+0xd/0x10
> > >  [<c01c3c4f>] __pci_device_probe+0x31/0x43
> > >  [<c01c3c82>] pci_device_probe+0x21/0x34
> > >  [<c0220429>] driver_probe_device+0x47/0x94
> > >  [<c0220542>] __driver_attach+0x5e/0x89
> > >  [<c021fada>] bus_for_each_dev+0x38/0x5d
> > >  [<c0220581>] driver_attach+0x14/0x16
> > >  [<c021ff2c>] bus_add_driver+0x5f/0x98
> > >  [<c02209a8>] driver_register+0x75/0x7a
> > >  [<c01c3e3e>] __pci_register_driver+0x4f/0x5d
> > >  [<f9bc3b3b>] bttv_init_module+0x9f/0xa1 [bttv]
> > >  [<c01325f7>] sys_init_module+0x95/0x1c5
> > >  [<c010291b>] syscall_call+0x7/0xb
> > >  [<b7ea781e>] 0xb7ea781e
> > > Code: 01 00 00 00 6a 00 e8 f9 cf f8 ff 89 d8 e8 2f 40 fe ff 5b 8d 65 f4 5b 5e 5f 5d c3 55 89 e5 57 89 c7 56 53 89 d3 83 ec 0c 89 4d f0 <8b> 40 64 89 45 ec 8b 47 1c 05 84 00 00 00 0f b7 72 08 c7 45 e8 
> > > EIP: [<c01875b0>] sysfs_add_file+0x10/0x76 SS:ESP 0068:dc489e94
> > > 
> > 
> > 
> > int sysfs_add_file(struct dentry * dir, const struct attribute * attr, int type)
> > {
> > OOPS==> struct sysfs_dirent * parent_sd = dir->d_fsdata;
> >         umode_t mode = (attr->mode & S_IALLUGO) | S_IFREG;
> > 
> > dir == 1, which is a strange value for a pointer to have (you can see it in eax.)
> > 
> > 
> > called from:
> > 
> > int sysfs_create_file(struct kobject * kobj, const struct attribute * attr)
> > {
> >         BUG_ON(!kobj || !kobj->dentry || !attr);
> > 
> >         return sysfs_add_file(kobj->dentry, attr, SYSFS_KOBJ_ATTR);
> > 
> > }
> > 
> > so kobj->dentry == 1 here.
> > 
> > 
> > called from:
> > 
> > int class_device_create_file(struct class_device * class_dev,
> >                              const struct class_device_attribute * attr)
> > {
> >         int error = -EINVAL;
> >         if (class_dev)
> >                 error = sysfs_create_file(&class_dev->kobj, &attr->attr);
> >         return error;
> > }
> > 
> > so the kobj is in a class_dev.
> > 
> > 
> > called from:
> > 
> > static int __devinit bttv_register_video(struct bttv *btv)
> > {
> >         if (no_overlay <= 0) {
> >                 bttv_video_template.type |= VID_TYPE_OVERLAY;
> >         } else {
> >                 printk("bttv: Overlay support disabled.\n");
> >         }
> > 
> >         /* video */
> >         btv->video_dev = vdev_init(btv, &bttv_video_template, "video");
> >         if (NULL == btv->video_dev)
> >                 goto err;
> >         if (video_register_device(btv->video_dev,VFL_TYPE_GRABBER,video_nr)<0)
> >                 goto err;
> >         printk(KERN_INFO "bttv%d: registered device video%d\n",
> >                btv->c.nr,btv->video_dev->minor & 0x1f);
> >  ===>   video_device_create_file(btv->video_dev, &class_device_attr_card);
> > 
> > video_device_create_file() is a wrapper for class_device_create_file():
> > 
> > video_device_create_file(struct video_device *vfd,
> >                          struct class_device_attribute *attr)
> > {
> >         class_device_create_file(&vfd->class_dev, attr);
> > }
> > 
> > 
> > The class_dev is created like this, in video_register_device():
> > 
> >         memset(&vfd->class_dev, 0x00, sizeof(vfd->class_dev));
> >         if (vfd->dev)
> >                 vfd->class_dev.dev = vfd->dev;
> >         vfd->class_dev.class       = &video_class;
> >         vfd->class_dev.devt        = MKDEV(VIDEO_MAJOR, vfd->minor);
> >         sprintf(vfd->class_dev.class_id, "%s%d", name_base, i - base);
> >         class_device_register(&vfd->class_dev);
> >         class_device_create_file(&vfd->class_dev,
> >                                 &class_device_attr_name);
> > 
> > so it looks like class_device_register() is putting the 1 into the dentry?
> > Culprit looks to be class_device_add() in that case.
> 
> Perhaps we should check the return value of class_device_register() to
> verify that nothing bad happened there?  A dentry of 1 is very odd.

Yes.  We are in the process of adding such checks.
Join the fun.

Although I'm not sure that a return value of 1 would be caught
as an error.

> If you enable debugging for the driver core and for kobjects (they both
> are config options), is there anything interesting in the log right
> before this happens?
> 
> > I tried tracing through that and... gave up.
> 
> Heh, yeah, it's not exactly a "simple" path...

---
~Randy
