Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317605AbSFINvj>; Sun, 9 Jun 2002 09:51:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317607AbSFINvi>; Sun, 9 Jun 2002 09:51:38 -0400
Received: from smtp1.xs4all.be ([195.144.64.135]:47080 "EHLO smtp1.xs4all.be")
	by vger.kernel.org with ESMTP id <S317605AbSFINvh>;
	Sun, 9 Jun 2002 09:51:37 -0400
Date: Sun, 9 Jun 2002 15:51:35 +0200
From: Filip Van Raemdonck <filipvr@xs4all.be>
To: linux-kernel@vger.kernel.org
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
        James Simmons <jsimmons@transvirtual.com>
Subject: [BUG] Riva 128ZX and rivafb
Message-ID: <20020609155135.A461@lucretia.debian.net>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Jeff Garzik <jgarzik@mandrakesoft.com>,
	James Simmons <jsimmons@transvirtual.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.20i
X-Marks-The-Spot: xxxxxxxxxx
X-GPG-Fingerprint: 1024D/8E950E00 CAC1 0932 B6B9 8768 40DB  C6AA 1239 F709 8E95 0E00
X-Machine-info: Linux lucretia 2.4.19-pre7-rmap13 i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I tried using rivafb with a Riva 128ZX card (8MB type) and ran into a kernel
hang. Trial and error with printk's revealed it is in
drivers/video/riva/riva_hw.c, inside the function LoadStateExt, at the
statement "LOAD_FIXED_STATE(nv3,PRAMIN);" where it oopses.

During a few dozen attempts, I've only been able to let klogd register the
oops once (usually the system doesn't even react to sysreq-S and sysreq-U
anymore), a transcript of which is below.
I also tried to capture it with "console=lp0", but for some reason it
doesn't print out the oops, only the "unable to handle kernel paging
request" and then stops. Hence the trial and error with printk. I've got a
huge pile of printed bootup messages now :-)
(and obviously writing down from the console isn't an option anymore,
either, once the framebuffer switch has blanked it :-< )

Kernel is 2.4.19-pre7-rmap13; it happens with `plain' -pre kernels as well.

BTW, is there actually a rivafb maintainer right now?

Jun  7 22:16:12 lucretia kernel: rivafb: RIVA MTRR set to ON
Jun  7 22:16:12 lucretia kernel: riva_init_disp: ENTER
Jun  7 22:16:12 lucretia kernel: riva_set_dispsw: ENTER
Jun  7 22:16:12 lucretia kernel: riva_set_dispsw: EXIT
Jun  7 22:16:12 lucretia kernel: riva_init_disp: EXIT, returning 0
Jun  7 22:16:12 lucretia kernel: rivafb_switch: ENTER
Jun  7 22:16:12 lucretia kernel: rivafb_switch: switch1: con = 0, cmap.len = 0
Jun  7 22:16:12 lucretia kernel: rivafb_set_var: ENTER
Jun  7 22:16:12 lucretia kernel: rivafb_set_var: Requested: 640x480x8
Jun  7 22:16:12 lucretia kernel: rivafb_set_var:   virtual: 640x480
Jun  7 22:16:12 lucretia kernel: rivafb_set_var:    offset: (0,0)
Jun  7 22:16:12 lucretia kernel: rivafb_set_var: grayscale: 0
Jun  7 22:16:12 lucretia kernel: rivafb_blank: ENTER
Jun  7 22:16:12 lucretia kernel: rivafb_blank: EXIT
Jun  7 22:16:12 lucretia kernel: Unable to handle kernel paging request at virtual address 00c01400
Jun  7 22:16:12 lucretia kernel:  printing eip:
Jun  7 22:16:12 lucretia kernel: c691f1ef
Jun  7 22:16:12 lucretia kernel: *pde = 00000000
Jun  7 22:16:12 lucretia kernel: Oops: 0002
Jun  7 22:16:12 lucretia kernel: CPU:    0
Jun  7 22:16:12 lucretia kernel: EIP:    0010:[scsi_mod:scsi_hosts_R63e23087+212719/97338278]    Not tainted
Jun  7 22:16:12 lucretia kernel: EFLAGS: 00010246
Jun  7 22:16:12 lucretia kernel: eax: 00010000   ebx: 00000000   ecx: 00000500   edx: 00c00000
Jun  7 22:16:12 lucretia kernel: esi: 00000000   edi: c0055198   ebp: c69225a4   esp: c0057c00
Jun  7 22:16:12 lucretia kernel: ds: 0018   es: 0018   ss: 0018
Jun  7 22:16:12 lucretia kernel: Process insmod (pid: 500, stackpage=c0057000)
Jun  7 22:16:12 lucretia kernel: Stack: c0055198 c00553a4 c0055000 c005533c c691b75c c0055198 c00553a4 c0055198 
Jun  7 22:16:12 lucretia kernel:        00000000 c0055198 c0057d4c c0055000 c0057c80 c691baba c0055000 c005533c 
Jun  7 22:16:12 lucretia kernel:        c03482e0 c0057d80 c0348380 c0055000 000001ea 00006257 000001ec 000001df 
Jun  7 22:16:12 lucretia kernel: Call Trace: [scsi_mod:scsi_hosts_R63e23087+197724/97353273] [scsi_mod:scsi_hosts_R63e23087+198586/97352411] [scsi_mod:scsi_hosts_R63e23087+201461/97349536] [scsi_mod:scsi_hosts_R63e23087+202755/97348242] [fbcon_switch+327/452] 
Jun  7 22:16:12 lucretia kernel:    [redraw_screen+224/328] [take_over_console+239/396] [register_framebuffer+249/292] [scsi_mod:scsi_hosts_R63e23087+204542/97346455] [scsi_mod:scsi_hosts_R63e23087+224256/97326741] [scsi_mod:scsi_hosts_R63e23087+225280/97325717] 
Jun  7 22:16:12 lucretia kernel:    [pci_announce_device+54/84] [scsi_mod:scsi_hosts_R63e23087+224256/97326741] [scsi_mod:scsi_hosts_R63e23087+225280/97325717] [pci_register_driver+72/96] [scsi_mod:scsi_hosts_R63e23087+225280/97325717] [scsi_mod:scsi_hosts_R63e23087+204999/97345998] 
Jun  7 22:16:12 lucretia kernel:    [scsi_mod:scsi_hosts_R63e23087+225280/97325717] [sys_init_module+1285/1448] [scsi_mod:scsi_hosts_R63e23087+195936/97355061] [system_call+51/56] 
Jun  7 22:16:12 lucretia kernel: 
Jun  7 22:16:12 lucretia kernel: Code: 89 04 8a 83 c6 08 43 83 fb 3c 76 e7 31 db bd 84 24 92 c6 31 


Regards,

Filip

-- 
"Sorry... my mind has a few bad sectors."
	-- Ari Pollak
