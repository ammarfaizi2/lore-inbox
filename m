Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262008AbVAYQ2T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262008AbVAYQ2T (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 11:28:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262007AbVAYQ2T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 11:28:19 -0500
Received: from mail0.lsil.com ([147.145.40.20]:38907 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S262004AbVAYQ1w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 11:27:52 -0500
Message-ID: <0E3FA95632D6D047BA649F95DAB60E57033BCCC6@exa-atlanta>
From: "Mukker, Atul" <Atulm@lsil.com>
To: "'James Bottomley'" <James.Bottomley@SteelEye.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: RE: How to add/drop SCSI drives from within the driver?
Date: Tue, 25 Jan 2005 11:27:36 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> > After the new logical drives are created with "- - -" written to the
> > scsi_host scan attribute, there is a highly noticeable delay before
> device
> > names (e.g., sda) appears in the /dev directory. If the management
> > application tried to access the device immediately after creating new,
> the
> > access fails. Putting a 1 second delay helped, but of course this is not
> a
> > deterministic solution.
> >
> > What are the other possibilities?
> 
> Well, how about hotplug.  The device addition actually triggers a hot
> plug event already (there's no need to add anything, it's done by the
> mid-layer), so if you just listen for that, you'll know when the scan
> has detected a device.


After writing the "- - -" to the scan attribute, the management applications
assume the udev has created the relevant entries in the /dev directly and
try to use the devices _immediately_ and fail to see the devices

Is there a hotplug event which would tell the management applications that
the device nodes have actually been created now and ready to be used?

I tried this simple script to re-create the failure. Assume there is one
scsi disk, which is the installation disk. Now load the megaraid driver,
with a few logical drive already created.

# insmod megaraid_mm.ko; insmod megaraid_mbox.ko; ls -l /dev/sd*
<driver loads>
<not all scsi devices are available>

<try again after a brief delay>
# ls -l /dev/sd*	# all devices show up now

Thanks
-Atul
