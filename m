Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261255AbUCHV2e (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 16:28:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261269AbUCHV2e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 16:28:34 -0500
Received: from palrel13.hp.com ([156.153.255.238]:60107 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S261255AbUCHV2L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 16:28:11 -0500
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16460.58722.881615.608507@napali.hpl.hp.com>
Date: Mon, 8 Mar 2004 13:28:02 -0800
To: "Dachepalli, Sudhir" <sudhir.dachepalli@lsil.com>
Cc: "'Linux-Kernel (E-mail)'" <linux-kernel@vger.kernel.org>,
       linux-ia64@vger.kernel.org
Subject: Re: Help in setting up serial console on 64 bit machine
In-Reply-To: <53CF1076699CD711B7DD0002A51363F102C36031@exw-ks.ks.lsil.com>
References: <53CF1076699CD711B7DD0002A51363F102C36031@exw-ks.ks.lsil.com>
X-Mailer: VM 7.18 under Emacs 21.3.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sudhir,

First a general comment: for ia64-specific questions, it's generally
better to ask on linux-ia64@vger.kernel.org.

As for your particular issue: the serial console normally is ttyS0,
not ttyS1, so that might be the reason you're not seeing any output.

Also, 9600 baud is rather slow.  If the client-side can handle it,
115200 baud will be much nicer.

	--david

>>>>> On Mon, 8 Mar 2004 15:04:04 -0600 , "Dachepalli, Sudhir" <sudhir.dachepalli@lsil.com> said:

  Sudhir> Hello SerialConsole user,
 
  Sudhir>          I have a problem while setting up serial console to
  Sudhir> direct kernel printk messages to serial console. I dont see
  Sudhir> messages getting displayed.
 
  Sudhir> My setup --------- 1. IA 64 machine.  2. Redhat AS 3.0
  Sudhir> 3. Kernel 2.4.18-e.37smp 4. Server Hardware : HP rx5670
 
  Sudhir> Serial Console setup -------------------- 1. I have
  Sudhir> connected serial cable between two linux terminals.  2. open
  Sudhir> minicom on both servers.  3. changed the settings to
  Sudhir> 9600-8-n-1, no h/w flow control, no s/w flow control, stop
  Sudhir> bits =1.  4. I typed some charecters on server 1 and saw the
  Sudhir> charecters appear in server 2's minicom.  5. I typed some
  Sudhir> charecters on server 2 and saw the charecters appear in
  Sudhir> server 1's minicom.  6. I have changed the kernel command
  Sudhir> line for booting the kernel . PLEASE SEE BELOW FOR
  Sudhir> "elilo.conf".  7. label=serial ( elilo entry to boot the
  Sudhir> serial console setup. ) 8. I have also checked the options
  Sudhir> in "make menuconfig" and found everything correct for serial
  Sudhir> console setup.
 
  Sudhir> After selecting "label=serial" and botting the OS the
  Sudhir> following is the command line from proc.  [root@beast root]#
  Sudhir> cat /proc/cmdline
  Sudhir> BOOT_IMAGE=scsi0:EFI\redhat\vmlinuz-2.4.18-e.37smp
  Sudhir> root=LABEL=/ console=ttyS1,9600n8 console=tty0 ro
 
  Sudhir> The kernel cmdline seems to be correct but the messages are
  Sudhir> not directed on console.  I have setup serial consoles on 32
  Sudhir> bit machines earlier, but not on 64 bit.
 
  Sudhir> Please throw me some pointers to make it work.
 
 
  Sudhir> regards, sudhir dachepalli
 
 
 
  Sudhir> [root@beast root]# uname -a Linux beast 2.4.18-e.37smp #1
  Sudhir> SMP Tue Aug 5 16:07:26 EDT 2003 ia64 unknown
 
  Sudhir> [root@beast root]# cat /etc/*release* Red Hat Linux Advanced
  Sudhir> Server release 2.1AS (Derry) prompt timeout=50
  Sudhir> default=2.4.18-e.37smp
 
  Sudhir> image=vmlinuz-2.4.18-e.37 label=2.4.18-e.37
  Sudhir> initrd=initrd-2.4.18-e.37.img read-only
  Sudhir> append="root=LABEL=/"
 
  Sudhir> image=vmlinuz-2.4.18-e.37 label=scsi-128 initrd=scsi-128.img
  Sudhir> read-only root=/dev/sda4
 
  Sudhir> image=vmlinuz-2.4.18-e.37smp label=2.4.18-e.37smp
  Sudhir> initrd=initrd-2.4.18-e.37smp.img read-only
  Sudhir> append="root=LABEL=/"
 
  Sudhir> image=vmlinuz-2.4.18-e.37smp label=serial
  Sudhir> initrd=initrd-2.4.18-e.37smp.img read-only
  Sudhir> append="root=LABEL=/ console=ttyS1,9600n8 console=tty0"
 
  Sudhir> image=vmlinuz-2.4.18-e.37smp label=lyq initrd=lyq.img
  Sudhir> read-only append="root=LABEL=/"
 
  Sudhir> image=vmlinuz-2.4.18-e.37smp label=mpp initrd=mpp.img
  Sudhir> read-only root=/dev/sda4
 
  Sudhir> image=vmlinuz-2.4.18-e.12smp label=linux
  Sudhir> initrd=initrd-2.4.18-e.12smp.img read-only root=/dev/sda4
 
  Sudhir> image=vmlinuz-2.4.18-e.12 label=linux-up
  Sudhir> initrd=initrd-2.4.18-e.12.img read-only root=/dev/sda4
 
 
  Sudhir> - To unsubscribe from this list: send the line "unsubscribe
  Sudhir> linux-serial" in the body of a message to
  Sudhir> majordomo@vger.kernel.org More majordomo info at
  Sudhir> http://vger.kernel.org/majordomo-info.html - To unsubscribe
  Sudhir> from this list: send the line "unsubscribe linux-kernel" in
  Sudhir> the body of a message to majordomo@vger.kernel.org More
  Sudhir> majordomo info at http://vger.kernel.org/majordomo-info.html
  Sudhir> Please read the FAQ at http://www.tux.org/lkml/
