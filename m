Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261493AbVCaO7u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261493AbVCaO7u (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 09:59:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261490AbVCaO7u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 09:59:50 -0500
Received: from upco.es ([130.206.70.227]:32951 "EHLO mail1.upco.es")
	by vger.kernel.org with ESMTP id S261494AbVCaO7g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 09:59:36 -0500
Date: Thu, 31 Mar 2005 16:59:33 +0200
From: Romano Giannetti <romanol@upco.es>
To: "Yu, Luming" <luming.yu@intel.com>
Cc: acpi-devel@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>,
       "Brown, Len" <len.brown@intel.com>, linux-kernel@vger.kernel.org,
       "Li, Shaohua" <shaohua.li@intel.com>
Subject: Re: [ACPI] Re: [BKPATCH] ACPI for 2.6.12-rc1
Message-ID: <20050331145933.GB21883@pern.dea.icai.upco.es>
Mail-Followup-To: Romano Giannetti <romanol@upco.es>,
	"Yu, Luming" <luming.yu@intel.com>, acpi-devel@lists.sourceforge.net,
	Andrew Morton <akpm@osdl.org>, "Brown, Len" <len.brown@intel.com>,
	linux-kernel@vger.kernel.org, "Li, Shaohua" <shaohua.li@intel.com>
References: <1111127024.9332.157.camel@d845pe> <20050319215239.GA5105@rukbat.dea.icai.upco.es> <20050329081321.GA4133@pern.dea.icai.upco.es> <200503301409.00785.luming.yu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <200503301409.00785.luming.yu@intel.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 30, 2005 at 02:09:00PM +0800, Yu, Luming wrote:
> On Tuesday 29 March 2005 16:13, Romano Giannetti wrote:
> >  This is to report an issue with 2.6.11 and ACPI battery/ac. The resume is:
> >  acpi battery with preemptive kernel do not work, while the same kernel
> > with no preempt works ok. I have tried to collect all the possible info;
> > tell me if you need something more.
> >
> >  The details:
> >
> >  The working kernel is 2.6.11 with the patch from the acpi-devel list to
> > fix acpi keys (not working otherwise). See for a description
> >  http://bugme.osdl.org/show_bug.cgi?id=4124
> 
> If you can find AE_AML_BUFFER_LIMIT in your long, then, it should be 
> interpreter bug.  please see http://bugzilla.kernel.org/show_bug.cgi?id=4150
> Otherwise, maybe it is related to EC driver.

I am not sure if I understood. If I do 

(0)% grep AE_AML_BUFFER_LIMIT dmesg.txt 
(1)%

I have nothing like that in syslog, either, so it should be another thing. 
Hmmm... I have "scheduling in atomic" errors, when resuming with preemptive
kernel, so maybe it's related with
http://sourceforge.net/mailarchive/message.php?msg_id=11129317

The errors are: 

scheduling while atomic: really_suspend/0x00000001/4624
 [<c0396007>] schedule+0x467/0x520
 [<c0121035>] __mod_timer+0x1c5/0x1f0
 [<c0396acd>] schedule_timeout+0x5d/0xb0
 [<c0121ac0>] process_timeout+0x0/0x10
 [<c0121eaf>] msleep+0x2f/0x40
 [<c024b080>] pci_set_power_state+0x190/0x1d0
 [<c024b1c8>] pci_enable_device_bars+0x18/0x40
 [<c024b20f>] pci_enable_device+0x1f/0x40
 [<d0ccf64c>] snd_via82xx_resume+0x1c/0x170 [snd_via82xx]
 [<c024b199>] pci_restore_state+0x39/0x50
 [<d0cacc79>] snd_card_pci_resume+0x49/0x76 [snd]
 [<c024d36c>] pci_device_resume+0x2c/0x40
 [<c02c79a8>] dpm_resume+0xa8/0xb0
 [<c02c79c1>] device_resume+0x11/0x20
 [<c0135268>] finish+0x8/0x40
 [<c01353c5>] pm_suspend_disk+0x75/0xc0
 [<c0133786>] enter_state+0x86/0x90
 [<c013379f>] software_suspend+0xf/0x20
 [<c0289d9a>] acpi_system_write_sleep+0x6a/0x84
 [<c015835c>] vfs_write+0x14c/0x160
 [<c0158441>] sys_write+0x51/0x80
 [<c01032b9>] sysenter_past_esp+0x52/0x75

...and more, you can find them all in
http://www.dea.icai.upco.es/romano/linux/br/acpi-preempt.txt

Could this be related to the fact that in 2.6.12-rc1 software suspend
stopped to work? Maybe some bad interaction between acpi code and swsusp? 

Moreover, if you can, can you point me to some documentation on how to use
"debug_level" and "debug_layer" to help debugging? 

Thanks! 

        Romano 



-- 
Romano Giannetti             -  Univ. Pontificia Comillas (Madrid, Spain)
Electronic Engineer - phone +34 915 422 800 ext 2416  fax +34 915 596 569
