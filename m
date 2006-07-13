Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932440AbWGMK4Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932440AbWGMK4Y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 06:56:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932452AbWGMK4X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 06:56:23 -0400
Received: from mail97.messagelabs.com ([216.82.244.131]:19879 "HELO
	mail97.messagelabs.com") by vger.kernel.org with SMTP
	id S932325AbWGMK4H convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 06:56:07 -0400
X-VirusChecked: Checked
X-Env-Sender: bhannibal@ipolicynetworks.com
X-Msg-Ref: server-13.tower-97.messagelabs.com!1152788163!42284427!1
X-StarScan-Version: 5.5.10.7; banners=-,-,-
X-Originating-IP: [203.190.138.195]
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 8BIT
Subject: RE: Expertise required on building code for SMP
Date: Thu, 13 Jul 2006 16:26:06 +0530
Message-ID: <D269C7CBDF116A48982D4DC51F111BE30213AE79@nsezhpmail01.india.ipolicynet.com>
In-Reply-To: <1152776737.3024.16.camel@laptopd505.fenrus.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Expertise required on building code for SMP
Thread-Index: AcamavDVoMvBHZCyTdm0C7iIrLoa3w==
From: "Hannibal B" <bhannibal@ipolicynetworks.com>
To: "Arjan van de Ven" <arjan@infradead.org>, <bhuvan.kumarmital@wipro.com>
Cc: <linux-usb-devel@lists.sourceforge.net>,
       <kernelnewbies-request@nl.linux.org>, <kernel-mentors@selenic.com>,
       <os_drivers@osdl.org>, <linux-kernel@vger.kernel.org>
X-imss-version: 2.040
X-imss-result: Passed
X-imss-scanInfo: M:P L:E SM:0
X-imss-tmaseResult: TT:0 TS:0.0000 TC:00 TRN:0 TV:3.52.1006(14564.000)
X-imss-scores: Clean:99.90000 C:1 M:10 S:5 R:5
X-imss-settings: Baseline:2 C:1 M:1 S:1 R:1 (0.1500 0.1500)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   Bottom half of your driver code is the were you can take advantage of
the SMP feature.You can use either workqueue(which is a simpler
interface which will create number threads based on the cpu count ),but
if U want finer control you can use Kthread(which does'nt inherits
parents sigmask and VM) or kernel_thread, depending on your need.


-----Original Message-----
From: Arjan van de Ven [mailto:arjan@infradead.org] 
Sent: Thursday, July 13, 2006 1:16 PM
To: bhuvan.kumarmital@wipro.com
Cc: linux-usb-devel@lists.sourceforge.net;
kernelnewbies-request@nl.linux.org; kernel-mentors@selenic.com;
os_drivers@osdl.org; linux-kernel@vger.kernel.org
Subject: Re: Expertise required on building code for SMP

On Thu, 2006-07-13 at 13:12 +0530, bhuvan.kumarmital@wipro.com wrote:
> We've written a device driver in linux for a pcmcia card with usb and
> serial functionality. I need to test this driver on a dual core/SMP
> machine. We work on kernel 2.6.15.4. I have recompiled this kernel
> version on my dual core machine with the CONFIG_SMP flag set during
> menuconfig.
> 
> How do i ensure that my driver is making use of the SMP feature? Do
> build my driver code i have a makefile in which i use the
EXTRA_CFLAGS=
> -D__SMP__ -DCONFIG_SMP -DLINUX.

NO!

You should just use a normal KBuild makefile, and not ever add any extra
cflags....

(but you failed to provide a URL to even your Makefile but also to your
code so it's hard to give you a detailed recommendation)

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel"
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/


