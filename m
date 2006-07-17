Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750701AbWGQJOk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750701AbWGQJOk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 05:14:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750712AbWGQJOk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 05:14:40 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:12437 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1750701AbWGQJOj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 05:14:39 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Brandon Philips <brandon@ifup.org>
Subject: Re: suspend/hibernate to work on thinkpad x60s?
Date: Mon, 17 Jul 2006 11:14:25 +0200
User-Agent: KMail/1.9.3
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, George Nychis <gnychis@cmu.edu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <44B5CE77.9010103@cmu.edu> <20060716222846.GA5741@plankton.ifup.org> <20060716225111.GA5661@plankton.ifup.org>
In-Reply-To: <20060716225111.GA5661@plankton.ifup.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607171114.26160.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 17 July 2006 00:51, Brandon Philips wrote:
> On 17:28 Sun 16 Jul 2006, Brandon Philips wrote:
> > On 08:31 Thu 13 Jul 2006, Jeremy Fitzhardinge wrote:
> > > George Nychis wrote:
> > > >I am not seeing any problems at all, though I am not seeing anything
> > > >happen :)
> > > >
> > > >If I Fn+suspend... nothing happens ... if i Fn+hibernate ... nothing 
> > > >happens
> > > >
> > > >What patches did you use?
> > > Sounds like your first step is to set up acpi.  What distro are you 
> > > using?  What happens if you do "echo -n mem > /sys/power/state"?
> > > 
> > > The patches you need are to make the ahci disk interface resume 
> > > properly.  There's a series of 6 patches from Forrest Zhao which he 
> > > posted to the linux-ide list, and they apply cleanly to 2.6.18-rc1-mm1.
> > 
> > I have tried Zhao's patches[1] against 2.6.18-rc1-mm{1,2} and 2.6.18-rc1
> > and the suspend always stops at:
> > 
> > "Switching to UP mode"
> > 
> > At that point it hangs; giving a Ctrl+Alt+Del reboots the machine
> > cleanly.
> > 
> > I want to see AHCI suspend working.  So, I am happy to try other patches
> > or debugging steps.
> 
> I just tried booting 2.6.18-rc1-mm1 again and got the following
> stacktrace which suggests a problem with the ondemand governor.   
> 
> After switching to the performance govenor I was able to suspend on
> 2.6.18-rc1 and 2.6.18-rc1-mm1.
> 
> 	Brandon
> 
> Freezing cpus ...
> CPU 1 is now offline
> SMP alternatives: switching to UP code
> divide error: 0000 [#1]
> 8K_STACKS SMP 
> last sysfs file: /power/state
> Modules linked in: binfmt_misc rfcomm l2cap bluetooth ipv6 nvram uinput button ac battery joydev ibm_acpi hdaps cpufreq_userspace speedstep_centrino freq_table sbp2 cpufreq_ondemand tsdev intelfb i2c_algo_bit snd_hda_intel i2c_i801 psmouse nsc_ircc snd_hda_codec pcspkr intel_agp agpgart eth1394 evdev i2c_core serio_raw irda snd_pcm snd_timer snd soundcore yenta_socket rsrc_nonstatic pcmcia_core snd_page_alloc crc_ccitt ata_piix piix sd_mod generic ide_core uhci_hcd ohci1394 ieee1394 ehci_hcd usbcore e1000 ahci libata scsi_mod thermal processor fan
> CPU:    0
> EIP:    0060:[<f8a0d20d>]    Not tainted VLI
> EFLAGS: 00210246   (2.6.18-rc1-mm1 #2) 
> EIP is at do_dbs_timer+0xcb/0x14e [cpufreq_ondemand]
> eax: 00000000   ebx: 00000000   ecx: 00000001   edx: 00000000
> esi: c1dda380   edi: 00000002   ebp: c1dda380   esp: f7d5ff4c
> ds: 007b   es: 007b   ss: 0068
> Process kondemand/0 (pid: 5266, ti=f7d5e000 task=dff48b90 task.ti=f7d5e000)
> Stack: 00000000 c1bfaba0 00000000 00000000 c1c02bb4 c1c02bb8 f7f69d80 00200286 
>        c012c04c 00000000 f8a0d142 00000000 f7f69d94 f7f69d80 f7f69d8c 00000000 
>        c012c9a2 00000001 00000000 c1c01280 00010000 00000000 00000000 dff48b90 
> Call Trace:
>  [<c012c04c>] run_workqueue+0x80/0xbc
>  [<f8a0d142>] do_dbs_timer+0x0/0x14e [cpufreq_ondemand]
>  [<c012c9a2>] worker_thread+0xf3/0x125
>  [<c0117c57>] default_wake_function+0x0/0x15
>  [<c012c8af>] worker_thread+0x0/0x125
>  [<c012ef9c>] kthread+0xc3/0xef
>  [<c012eed9>] kthread+0x0/0xef
>  [<c0101005>] kernel_thread_helper+0x5/0xb
> Code: 00 39 44 24 0c 0f 46 44 24 0c 89 44 24 0c 56 57 e8 2f 79 7c c7 5b 89 c7 5d 83 ff 01 76 a3 8b 44 24 08 31 d2 2b 44 24 0c 6b c0 64 <f7> 74 24 08 89 c1 a1 a8 e6 a0 f8 39 c1 76 0d 8b 46 1c 39 46 20 
> EIP: [<f8a0d20d>] do_dbs_timer+0xcb/0x14e [cpufreq_ondemand] SS:ESP 0068:f7d5ff4c

Could you please create a bugzilla entry for the ondemand governor problem
and put this trace in there?

Thanks,
Rafael
