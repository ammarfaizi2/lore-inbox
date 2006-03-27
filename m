Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751091AbWC0Qsm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751091AbWC0Qsm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 11:48:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751105AbWC0Qsl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 11:48:41 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:1510 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751091AbWC0Qsl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 11:48:41 -0500
Subject: Re: Detecting I/O error and Halting System
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: zine el abidine Hamid <zine46@yahoo.fr>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060327145501.34766.qmail@web30606.mail.mud.yahoo.com>
References: <20060327145501.34766.qmail@web30606.mail.mud.yahoo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Date: Mon, 27 Mar 2006 17:55:56 +0100
Message-Id: <1143478556.4970.37.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2006-03-27 at 16:55 +0200, zine el abidine Hamid wrote:
> hda: status timeout: status=0xd0 { Busy }      adapter
> disque annonce un status busy du DMA

If I'm reading the translation right then your hard disk decided
it was busy and then never came back

> Feb 12 04:46:23 porte_de_clignancourt_nds_b kernel:
> ide0: reset: success             

So the IDE layer tried to reset it

> Feb 12 10:22:38 porte_de_clignancourt_nds_b kernel:
> hda: timeout waiting for DMA

Which didnt help

> Feb 12 10:24:47 porte_de_clignancourt_nds_b kernel:
> ide0: reset: success

Still trying
      
> Feb 12 10:24:47 porte_de_clignancourt_nds_b kernel:
> hda: irq timeout: status=0xd0 { Busy }                
> 
> Feb 12 10:24:47 porte_de_clignancourt_nds_b kernel:
> hda: DMA disabled       

We gave up on DMA to see if PIO would help
>                               
>    
> Feb 12 10:24:47 porte_de_clignancourt_nds_b kernel:
> ide0: reset timed-out, status=0x80
> Feb 12 10:24:47 porte_de_clignancourt_nds_b kernel:
> hda: status timeout: status=0x80 { Busy }        
> nouvel échec de reset
> Feb 12 10:24:47 porte_de_clignancourt_nds_b kernel:
> hda: drive not ready for command
> Feb 12 10:24:47 porte_de_clignancourt_nds_b kernel:
> ide0: reset: success                  

And reset.. 


> Feb 12 13:45:38 porte_de_clignancourt_nds_b kernel:
> hda: status timeout: status=0x80 { Busy }
> Feb 12 13:45:38 porte_de_clignancourt_nds_b kernel:
> hda: drive not ready for command
> Feb 12 13:45:38 porte_de_clignancourt_nds_b kernel:
> ide0: reset timed-out, status=0x80
> Feb 12 13:45:38 porte_de_clignancourt_nds_b kernel:
> end_request: I/O error, dev 03:02 (hda), sector 102263
> Feb 12 13:45:38 porte_de_clignancourt_nds_b syslogd:
> /var/log/maillog: Input/output error
> Feb 12 13:45:38 porte_de_clignancourt_nds_b kernel:
> end_request: I/O error, dev 03:02 (hda), sector 110720
> Feb 12 13:45:38 porte_de_clignancourt_nds_b kernel:
> end_request: I/O error, dev 03:02 (hda), sector 110728 

Eventually we give up.


First thing to check would be the disk and the temperature, then the
cabling. In particular make sure the *long* part of the cable is between
the drive and the controller.

