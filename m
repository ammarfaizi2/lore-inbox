Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261359AbVGLLuI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261359AbVGLLuI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 07:50:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261366AbVGLLsN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 07:48:13 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:4260 "EHLO
	out2.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S261359AbVGLLqe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 07:46:34 -0400
X-Sasl-enc: hvz62E2OPz0LfHMwfqKDsGMF7BkJm25z/msr+SrIJJvK 1121168790
Message-ID: <021801c586d7$5ebf4090$7c00a8c0@ROBMHP>
From: "Rob Mueller" <robm@fastmail.fm>
To: "Lars Roland" <lroland@gmail.com>
Cc: <linux-kernel@vger.kernel.org>, "Bron Gondwana" <brong@fastmail.fm>,
       "Jeremy Howard" <jhoward@fastmail.fm>
References: <01dd01c586c3$cdd525d0$7c00a8c0@ROBMHP> <4ad99e05050712024319bc7ada@mail.gmail.com>
Subject: Re: 2.6.12.2 dies after 24 hours
Date: Tue, 12 Jul 2005 21:46:30 +1000
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2527
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2527
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > We recently tried upgrading one of the machines to the latest kernel
> > (2.6.12.2) and it's died after about 24 hours. It seemed to end up in 
> > some
> > weird state where we could ssh into it, and some commands worked (eg 
> > uptime)
> > but process list related commands (ps) would just freeze up into an
> > unkillable state and we'd have to close the seesion and ssh in again.
>
> I experienced the exact same thing on a IBM 335 - in my case I had
> messed up with the ACPI setup. Could you paste the output from
> /proc/interupts also is your kernel running with IRQ balancing ?.

Here's the /proc/interrupts dump:

           CPU0       CPU1       CPU2       CPU3
  0:   11524000          0          0          0    IO-APIC-edge  timer
  1:          8          0          0          0    IO-APIC-edge  i8042
  5:          0          0          0          0   IO-APIC-level  acpi
 14:         13          0          0          0    IO-APIC-edge  ide0
 16:          2          0          0          0   IO-APIC-level  ibmasm0
 20:    2978604          0    2338027          0   IO-APIC-level  eth0
 22:    1321957          0          0          0   IO-APIC-level  ips
 24:     581291          0          0          0   IO-APIC-level  pci-umem
 29:     257154          0          0          0   IO-APIC-level  eth1
NMI:          0          0          0          0
LOC:   11524185   11524201   11524194   11524121
ERR:          0
MIS:          0

I'm not sure about IRQ balancing sorry. How do I tell? The entire boot 
process output is here:

http://robm.fastmail.fm/kernel/t7/bootdmesg.txt

And the config is here:

http://robm.fastmail.fm/kernel/t7/config.txt

Does that help?

Our boot doesn't pass any special parameters, just choosing the deadline 
elevator...

image=/boot/bzImage-2.6.12.2
  label=linux-2.6.12.2
  append="elevator=deadline"
  read-only
  root=/dev/sda2

Thanks for your help!

Rob

