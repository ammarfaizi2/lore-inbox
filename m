Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422842AbWJNUtK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422842AbWJNUtK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Oct 2006 16:49:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030409AbWJNUtK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Oct 2006 16:49:10 -0400
Received: from smtp.osdl.org ([65.172.181.4]:36782 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030407AbWJNUtG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Oct 2006 16:49:06 -0400
Date: Sat, 14 Oct 2006 13:48:55 -0700
From: Andrew Morton <akpm@osdl.org>
To: Matthew Wilcox <matthew@wil.cx>
Cc: Val Henson <val_henson@linux.intel.com>,
       Greg Kroah-Hartman <gregkh@suse.de>, netdev@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] [PCI] Check that MWI bit really did get set
Message-Id: <20061014134855.b66d7e65.akpm@osdl.org>
In-Reply-To: <20061014140249.GL11633@parisc-linux.org>
References: <1160161519800-git-send-email-matthew@wil.cx>
	<20061013214135.8fbc9f04.akpm@osdl.org>
	<20061014140249.GL11633@parisc-linux.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 14 Oct 2006 08:02:49 -0600
Matthew Wilcox <matthew@wil.cx> wrote:

> On Fri, Oct 13, 2006 at 09:41:35PM -0700, Andrew Morton wrote:
> > Bisection shows that this patch
> > (pci-check-that-mwi-bit-really-did-get-set.patch in Greg's PCI tree) breaks
> > suspend-to-disk on my Vaio.  It writes the suspend image and gets to the
> > point where it's supposed to power down, but doesn't.
> 
> How odd.  What driver is calling pci_set_mwi() on the suspend path?

ehci_pci_reinit().  I stuck a dump_stack() in there.  See
http://userweb.kernel.org/~akpm/s5000342.jpg

> What drivers do you have loaded on the Vaio?


sony:/home/akpm> lsmod
Module                  Size  Used by
ipw2200               163184  0 
sonypi                 21484  0 
autofs4                19908  1 
hidp                   16192  2 
l2cap                  21764  5 hidp
bluetooth              49060  2 hidp,l2cap
sunrpc                154172  1 
ip_conntrack_netbios_ns     3328  0 
ipt_REJECT              4736  1 
xt_state                2496  2 
ip_conntrack           51020  2 ip_conntrack_netbios_ns,xt_state
nfnetlink               7128  1 ip_conntrack
xt_tcpudp               3392  4 
iptable_filter          3264  1 
ip_tables              12616  1 iptable_filter
x_tables               15428  4 ipt_REJECT,xt_state,xt_tcpudp,ip_tables
video                  16836  0 
sony_acpi               7312  0 
sbs                    15968  0 
i2c_ec                  5504  1 sbs
button                  7184  0 
battery                10692  0 
asus_acpi              17564  0 
backlight               6464  2 sony_acpi,asus_acpi
ac                      5636  0 
nvram                   8072  0 
ohci1394               33264  0 
ehci_hcd               30088  0 
ieee1394              291896  1 ohci1394
uhci_hcd               22092  0 
sg                     33628  0 
joydev                  9920  0 
evbug                   3392  0 
snd_hda_intel          18968  0 
snd_hda_codec         161536  1 snd_hda_intel
snd_seq_dummy           4228  0 
snd_seq_oss            31744  0 
snd_seq_midi_event      7360  1 snd_seq_oss
snd_seq                48208  5 snd_seq_dummy,snd_seq_oss,snd_seq_midi_event
snd_seq_device          8524  3 snd_seq_dummy,snd_seq_oss,snd_seq
ieee80211              30920  1 ipw2200
snd_pcm_oss            41504  0 
snd_mixer_oss          16640  1 snd_pcm_oss
ieee80211_crypt         6016  1 ieee80211
snd_pcm                74632  3 snd_hda_intel,snd_hda_codec,snd_pcm_oss
snd_timer              21316  2 snd_seq,snd_pcm
snd                    50980  9 snd_hda_intel,snd_hda_codec,snd_seq_oss,snd_seq,snd_seq_device,snd_pcm_oss,snd_mixer_oss,snd_pcm,snd_timer
soundcore               7968  1 snd
snd_page_alloc         10376  2 snd_hda_intel,snd_pcm
piix                    9604  0 [permanent]
i2c_i801                7820  0 
pcspkr                  3136  0 
i2c_core               21840  2 i2c_ec,i2c_i801
generic                 5252  0 [permanent]
ext3                  127688  1 
jbd                    52712  1 ext3
ide_disk               16000  0 
ide_core              114780  3 piix,generic,ide_disk
