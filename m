Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261248AbTIPMec (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 08:34:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261794AbTIPMec
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 08:34:32 -0400
Received: from infres.enst.fr ([137.194.192.1]:57598 "EHLO infres.enst.fr")
	by vger.kernel.org with ESMTP id S261248AbTIPMe3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 08:34:29 -0400
Date: Tue, 16 Sep 2003 14:34:28 +0200 (CEST)
From: Ramon Casellas <casellas@infres.enst.fr>
X-X-Sender: casellas@gandalf.localdomain
To: Patrick Mochel <mochel@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Bug/Oops Power Management with linux-2.6.0-test5-mm2
In-Reply-To: <Pine.LNX.4.33.0309151006060.950-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.56.0309161431230.11872@gandalf.localdomain>
References: <Pine.LNX.4.33.0309151006060.950-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi!

> This is similar to a bug Pavel reported last week. Please try either 
> removing the usb modules before you suspend, or applying the patch here:
> 

Hi Patrick, 

Thanks for your email. I did what you suggested

a) removing usb modules / patching usb.c 
With the same .config this is the output of lsmod

Now modules are
-------------------------

Module                  Size  Used by
(snd sndcore related intel, ac, seq, pcm, mixer..etc)
nls_iso8859_1           3872  1 
nls_cp437               5504  1 
nls_utf8                1728  1 
ntfs                   84620  1 
nfs                   148720  0 
lockd                  59728  1 nfs
sunrpc                120424  2 nfs,lockd
radeon                116524  30 
yenta_socket           14688  0 
ds                     11108  4 
pcmcia_core            63616  2 yenta_socket,ds
nvram                   8008  0 
vfat                   12800  1 
e1000                  80324  0 
ide_scsi               12992  0 
loop                   13864  0 
proc_intf               3168  0 
intel_agp              15036  1 
agpgart                27016  2 intel_agp
msr                     2400  0 
microcode               5080  0 
cpuid                   2048  0 
ide_cd                 37508  0 

If I patch usb.c there's no need to remove usb modules, 
and I get the same result:

echo -n mem > /sys/power/state

PM: Preparing system for suspend
Stopping tasks: ========================================================================|
hda: start_power_step(step: 0)
hda: start_power_step(step: 1)
hda: complete_power_step(step: 1, stat: 50, err: 0)
hda: completing PM request, suspend
PM: Entering state.
Back to C!
zapping low mappings.
PM: Finishing up.
PCI: Setting latency timer of device 0000:00:1f.5 to 64
hda: Wakeup request inited, waiting for !BSY...
e1000: eth0 NIC Link is Up 100 Mbps Full Duplex
hda: start_power_step(step: 1000)
hda: completing PM request, resume
Restarting tasks... done
agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V2 device at 0000:00:00.0 into 4x mode
agpgart: Putting AGP V2 device at 0000:01:00.0 into 4x mode
MCE: The hardware reports a non fatal, correctable incident occurred on CPU 0.
Bank 1: e200000000000005
agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V2 device at 0000:00:00.0 into 4x mode
agpgart: Putting AGP V2 device at 0000:01:00.0 into 4x mode

The only problem now is that if I suspend, when resuming, neither the
mouse nor the NIC works, but it's getting much better.


with 
echo -n disk > /sys/power/state

Stopping tasks: ===================================================================
 stopping tasks failed (1 tasks remaining)
 Restarting tasks...<6> Strange, artsd not stopped
  done

IIRC, I only have to kill artsd before hibernating...




Anyway, thanks again,
Regards,
Ramon
