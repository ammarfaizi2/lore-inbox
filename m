Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261176AbVGQMEJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261176AbVGQMEJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Jul 2005 08:04:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261251AbVGQMEJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Jul 2005 08:04:09 -0400
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34]:60251 "HELO
	smtp003.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S261176AbVGQMEH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Jul 2005 08:04:07 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.de;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Message-Id;
  b=MwT1gEueVGxOKqQN+jYGg2GGC9R1kxOZ247QDCLUfr0W8s+nt8c1Dcqh4CCl1UJEHPQYfY5EhQhGqCd6DKP2n0RiTu1HVUJ5pUtFeyCUHGbHdn/tBAnvvbrrcvN6N0jhunr4/7/Zxw2Z59oqDFNTvGc9DBD+dzJqlqnCUer5P4Q=  ;
From: Karsten Wiese <annabellesgarden@yahoo.de>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: Realtime Preemption, 2.6.12, Beginners Guide?
Date: Sun, 17 Jul 2005 14:07:20 +0200
User-Agent: KMail/1.8.1
Cc: "K.R. Foley" <kr@cybsft.com>, Chuck Harding <charding@llnl.gov>,
       William Weston <weston@sysex.net>,
       Linux Kernel Discussion List <linux-kernel@vger.kernel.org>,
       Gene Heskett <gene.heskett@verizon.net>
References: <200507061257.36738.s0348365@sms.ed.ac.uk> <200507141450.42837.annabellesgarden@yahoo.de> <20050716171537.GB16235@elte.hu>
In-Reply-To: <20050716171537.GB16235@elte.hu>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_4nk2C0XuXV+r2OK"
Message-Id: <200507171407.20373.annabellesgarden@yahoo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_4nk2C0XuXV+r2OK
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Am Samstag, 16. Juli 2005 19:15 schrieb Ingo Molnar:
> 
> * Karsten Wiese <annabellesgarden@yahoo.de> wrote:
> 
> > Have I corrected the other path of ioapic early initialization, which 
> > had lacked virtual-address setup before ioapic_data[ioapic] was to be 
> > filled in -51-28? Please test attached patch on top of -51-29 or 
> > later. Also on Systems that liked -51-28.
> 
> thanks - i've applied it to my tree and have released the -51-31 patch.  
> It looks good on my testboxes.
> 
Found another error:
the ioapic cache isn't fully initialized in -51-31's ioapic_cache_init().
Please apply attached patch on top of -51-31.

    Karsten

--Boundary-00=_4nk2C0XuXV+r2OK
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="io_apic-RT-51-31"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="io_apic-RT-51-31"

--- linux-2.6.12-RT-51-31/arch/i386/kernel/io_apic.c	2005-07-17 12:40:35.000000000 +0200
+++ linux-2.6.12-RT/arch/i386/kernel/io_apic.c	2005-07-17 13:33:06.000000000 +0200
@@ -158,7 +158,7 @@
 static void __init ioapic_cache_init(struct ioapic_data_struct *ioapic)
 {
 	int reg;
-	for (reg = 0; reg < (ioapic->nr_registers + 10); reg++)
+	for (reg = 0; reg < (0x10 + 2 * ioapic->nr_registers); reg++)
 		ioapic->cached_val[reg] = __raw_io_apic_read(ioapic, reg);
 }
 # endif

--Boundary-00=_4nk2C0XuXV+r2OK--

	

	
		
___________________________________________________________ 
Gesendet von Yahoo! Mail - Jetzt mit 1GB Speicher kostenlos - Hier anmelden: http://mail.yahoo.de
