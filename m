Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262375AbVFJBih@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262375AbVFJBih (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Jun 2005 21:38:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262410AbVFJBih
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Jun 2005 21:38:37 -0400
Received: from web61016.mail.yahoo.com ([209.73.179.10]:25469 "HELO
	web61016.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262375AbVFJBhs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Jun 2005 21:37:48 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=W3ZXAdwAWB/ZYy/6TcjrCTVfMq7dUg0n0bD8WTG9HsSpx894J4OY92awNcb/SpfXoFc8QkJ/9HLe6dQQL3Edr5BslJYLZWOloIoyffXuSFPSN0chPFg1xt4bOFR2Pt+2+JAarqoHB6kEh+FO495dtordcH6R8dBIc2HmZ4Dfc+k=  ;
Message-ID: <20050610013747.90486.qmail@web61016.mail.yahoo.com>
Date: Thu, 9 Jun 2005 18:37:47 -0700 (PDT)
From: trusted linux <tcimpl2005@yahoo.com>
Subject: Re: TPM on IBM thinkcenter S51
To: Kylene Jo Hall <kjhall@us.ibm.com>,
       Torsten Landschoff <tla@comsys.informatik.uni-kiel.de>
Cc: trusted linux <tcimpl2005@yahoo.com>, linux-kernel@vger.kernel.org
In-Reply-To: <1117815792.5407.19.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kylene and Torsten,

thanks for the help. sorry for the late response - my
machine crashed (for other reasons) and I had to
rebuild it. 

0. I am using 2.6.12-rc5 default driver. 

1. systool -c misc|grep tpm shows nothing. the driver
is not there.

2. here is ll /dev/tpm output: (major 10, minor 224). 

crw-r--r--  1 root root 10, 224 Jun  9 20:11 /dev/tpm

3. when I modprobe tpm and tpm_nsc (or insmod), no
output is printed to /var/log/messages except my own
test message. 

4. /sbin/lspci output:
00:00.0 Host bridge: Intel Corp. 915G/P/GV Processor
to I/O Controller  (rev 04)
00:02.0 VGA compatible controller: Intel Corp. 82915G
Express Chipset Family Graphics Controller (rev 04)
00:1d.0 USB Controller: Intel Corp.
82801FB/FBM/FR/FW/FRW (ICH6 Family ) USB UHCI #1 (rev
03)
00:1d.1 USB Controller: Intel Corp.
82801FB/FBM/FR/FW/FRW (ICH6 Family ) USB UHCI #2 (rev
03)
00:1d.2 USB Controller: Intel Corp.
82801FB/FBM/FR/FW/FRW (ICH6 Family ) USB UHCI #3 (rev
03)
00:1d.3 USB Controller: Intel Corp.
82801FB/FBM/FR/FW/FRW (ICH6 Family ) USB UHCI #4 (rev
03)
00:1d.7 USB Controller: Intel Corp.
82801FB/FBM/FR/FW/FRW (ICH6 Family ) USB2 EHCI
Controller (rev 03)
00:1e.0 PCI bridge: Intel Corp. 82801 PCI Bridge (rev
d3)
00:1e.2 Multimedia audio controller: Intel Corp.
82801FB/FBM/FR/FW/FRW  (ICH6 Family) AC'97 Audio
Controller (rev 03)
00:1f.0 ISA bridge: Intel Corp. 82801FB/FR
(ICH6/ICH6R) LPC Interface Bridge (rev 03)
00:1f.2 IDE interface: Intel Corp. 82801FB/FW
(ICH6/ICH6W) SATA Contro ller (rev 03)
00:1f.3 SMBus: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6
Family) SMBus C ontroller (rev 03)
0a:0b.0 Ethernet controller: Broadcom Corporation
NetXtreme BCM5705_2 Gigabit Ethernet (rev 03)

5. I tried the Kylene's 1st patch. I first got an
error 
patching file as the following:

linux-2.6.12-rc5/drivers/char/tpm/tpm_nsc.c
patch: **** malformed patch at line 13: };

then I modified the patch:
--- linux-2.6.12-rc5/drivers/char/tpm/tpm_nsc_orig.c  
 2005-06-09 21:07:49.000000000 -0400
+++ linux-2.6.12-rc5/drivers/char/tpm/tpm_nsc.c
2005-06-09 21:18:30.000000000 -0400
@@ -340,6 +340,9 @@
        {PCI_DEVICE(PCI_VENDOR_ID_INTEL,
PCI_DEVICE_ID_INTEL_82801DB_12)},
        {PCI_DEVICE(PCI_VENDOR_ID_INTEL,
PCI_DEVICE_ID_INTEL_82801EB_0)},
        {PCI_DEVICE(PCI_VENDOR_ID_AMD,
PCI_DEVICE_ID_AMD_8111_LPC)},
+       {PCI_DEVICE(PCI_VENDOR_ID_INTEL,
PCI_DEVICE_ID_INTEL_ICH6_0)},
+       {PCI_DEVICE(PCI_VENDOR_ID_INTEL,
PCI_DEVICE_ID_INTEL_ICH6_1)},
+       {PCI_DEVICE(PCI_VENDOR_ID_INTEL,
PCI_DEVICE_ID_INTEL_ICH7_0)},
        {0,}
 };

And patching works but tpm still doesn't work - tpm0
directory is not created under /sys/class. 

6. I checked tpmdd but the lastest version is for
2.6.11. I guess 2.6.12 should supercede it. 

any idea?

thanks,

Gang 


--- Kylene Jo Hall <kjhall@us.ibm.com> wrote:

> Ok,
> 
> I think this patch will fix the driver to find your
> TPM.  It is just
> adding some additional LPC buses to look for so it
> won't make things any
> worse if it doesn't fix the problem.  Please let me
> know if it works.
> If it finds the device it should print a version
> message in syslog.
> Also there should be a tpm0 directory in
> /sys/classs/misc.  Once you
> have that you can try to cat
> /sys/class/misc/tpm0/device/pcrs.  If that
> returns an error please try the next patch I send
> you and let me know
> the results.
> 
> Thanks,
> Kylie
> 
> Signed-off-by: Kylene Hall <kjhall@us.ibm.com>
> --- linux-2.6.12-rc5/drivers/char/tpm/tpm_nsc.c.orig
> 2005-06-03 11:14:07.000000000 -0500
> +++ linux-2.6.12-rc5/drivers/char/tpm/tpm_nsc.c
> 2005-06-03 11:14:53.000000000 -0500
> @@ -340,6 +340,9 @@ static struct pci_device_id
> tpm_pci_tbl[
>  	{PCI_DEVICE(PCI_VENDOR_ID_INTEL,
> PCI_DEVICE_ID_INTEL_82801DB_12)},
>  	{PCI_DEVICE(PCI_VENDOR_ID_INTEL,
> PCI_DEVICE_ID_INTEL_82801EB_0)},
>  	{PCI_DEVICE(PCI_VENDOR_ID_AMD,
> PCI_DEVICE_ID_AMD_8111_LPC)},
> +	{PCI_DEVICE(PCI_VENDOR_ID_INTEL,
> PCI_DEVICE_ID_INTEL_ICH6_0)},
> +	{PCI_DEVICE(PCI_VENDOR_ID_INTEL,
> PCI_DEVICE_ID_INTEL_ICH6_1)},
> +	{PCI_DEVICE(PCI_VENDOR_ID_INTEL,
> PCI_DEVICE_ID_INTEL_ICH7_0)},
>  	{0,}
>  };
>  
> 
> 
> On Fri, 2005-06-03 at 10:02 -0500, Kylene Jo Hall
> wrote:
> > Hi Torsten,
> > 
> > I maintain the driver and am interested in
> figuring out what this
> > problem is.  Can you please tell me what the
> device major/minor are
> > on /dev/tpm.  Any output produced by the driver in
> /var/log/messages.
> > Also the output of /sbin/lspci.  Also I am
> assuming you are using the
> > version in the default 2.6.12-rc5.  There are many
> changes are in the -
> > mm2 patch so I will pull down the default tree and
> make sure the version
> > there is working.
> > 
> > Thanks,
> > Kylie
> > 
> > On Fri, 2005-06-03 at 11:23 +0200, Torsten
> Landschoff wrote:
> > > On Thu, 2005-06-02 at 15:00 -0700, trusted linux
> wrote:
> > > > thanks, here is my strace related to tpm:
> > > > 
> > > > open("/dev/tpm", O_RDWR)                = -1
> ENODEV
> > > > (No such device)
> > > > write(2, "Can\'t open TPM Driver\n", 22Can't
> open TPM
> > > > Driver
> > > > ) = 22
> > > 
> > > Okay, so the driver is in fact not working. It
> could be that /dev/tpm
> > > has the wrong device number assigned. If the
> driver is really installed
> > > can be checked by
> > > 
> > > 	systool -c misc|grep tpm
> > > 
> > > I bet it does not show anything. OTOH if the
> module loads successfully
> > > it really should be there. No idea what's going
> wrong then. 
> > > 
> > > Which version of the driver are you using?
> > > 
> > > Greetings
> > > 
> > > 	Torsten
> > > 
> > > -
> > > To unsubscribe from this list: send the line
> "unsubscribe linux-kernel" in
> > > the body of a message to
> majordomo@vger.kernel.org
> > > More majordomo info at 
> http://vger.kernel.org/majordomo-info.html
> > > Please read the FAQ at  http://www.tux.org/lkml/
> > > 
> > > 
> > 
> > -
> > To unsubscribe from this list: send the line
> "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at 
> http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> > 
> > 
> 
> 



		
__________________________________ 
Discover Yahoo! 
Have fun online with music videos, cool games, IM and more. Check it out! 
http://discover.yahoo.com/online.html
