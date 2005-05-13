Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262238AbVEME4D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262238AbVEME4D (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 00:56:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262236AbVEME4D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 00:56:03 -0400
Received: from zorg.st.net.au ([203.16.233.9]:52619 "EHLO borg.st.net.au")
	by vger.kernel.org with ESMTP id S262234AbVEMEzr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 00:55:47 -0400
Message-ID: <42843326.3070000@torque.net>
Date: Fri, 13 May 2005 14:55:02 +1000
From: Douglas Gilbert <dougg@torque.net>
Reply-To: dougg@torque.net
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bryan Henderson <hbryan@us.ibm.com>
CC: Vladislav Bolkhovitin <vst@vlnb.net>,
       David Hollis <dhollis@davehollis.com>, dmitry_yus@yahoo.com,
       FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>,
       Guennadi Liakhovetski <g.liakhovetski@gmx.de>,
       iscsitarget-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org, Sander <sander@humilis.net>,
       Maciej Soltysiak <solt2@dns.toxicfilms.tv>
Subject: Re: SCSI/ISCSI, hardware/software
References: <OFB07C63BD.91DCFD73-ON88256FFF.0065D9AA-88256FFF.006C4709@us.ibm.com>
In-Reply-To: <OFB07C63BD.91DCFD73-ON88256FFF.0065D9AA-88256FFF.006C4709@us.ibm.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bryan Henderson wrote:
>>There is some confusion in the SCSI world between SCSI as a transport 
>>and SCSI as a commands set and software communication protocol, which 
>>works above the transport. So, you can implement SCSI transport at any 
>>software (eg iSCSI) or hardware (parallel SCSI, Fibre Channel, SATA, 
>>etc.) way, but if the SCSI message passing protocol is used overall 
>>system remains SCSI with all protocol obligations like task management. 
> 
> 
> The above doesn't really resolve the confusion, since it uses some 
> ambiguous terms and constructions.  I'm not sure what it's supposed to 
> say, but let me try to state in the terminology of the SCSI standards what 
> SCSI is:
> 
> SCSI is a family of separate specifications.  Some are specifications of 
> transports, and others are specifications of command sets (a layer above 
> the transports).  A SCSI device must implement a SCSI transport spec and a 
> SCSI command set spec -- and also contain a piece that actually does the 
> work (e.g. a disk drive), the details of which aren't specified by SCSI.
> 
> Examples of SCSI transport specification are (I'm paraphrasing the names) 
> parallel SCSI, Fibre Channel, and ISCSI.  Examples of command sets are the 
> disk device command set and the tape device command set.

Bryan,
This url might help to illustrate things:

http://t10.org/scsi-3.htm

Transports are below the yellow line, SCSI command sets
are above it.

Doug Gilbert

>>So, pure software SCSI solution is possible. BTW, there are pure 
>>hardware iSCSI implementations as well.
> 
> 
> I don't think it's even meaningful to talk about whether an implementation 
> is hardware or software.  The "pure hardware" implementations contain 
> megabytes of software, which was written in languages like C, contains 
> operating systems like Linux, and can be transmitted across a network and 
> updated easily.  The "pure software" implementation involve kilograms of 
> hardware in every SCSI command -- CPUs, power supplies, etc.
> 
> Not only that, but the "all hardware" ISCSI initiators people talk about, 
> which are PCI cards with Ethernet jacks, are not complete initiators.  The 
> computer you plug the card into, on which you run Linux and some 
> application programs, is the initiator.  The card is just the 
> ISCSI-specific core of it.
> 
> There's really two distinctions people mean to make when talking about 
> hardware vs software:
> 
> 1) Is it preassembled?  Can you lift it out of box whole, or do you have 
> to acquire some special software and some more generic parts separately 
> and manage their combination?
> 
> 2) Does it involve a general purpose computing system, particularly one 
> that you share with some other computing, or a faster special purpose 
> dedicated one?
> 
> In the context of a Linux SCSI discussion, I'd just talk about how much of 
> the implementation is in or above the Linux kernel, and how much is below. 
>  And then we can say that ISCSI-specific function (initiator or target) 
> can be implemented 1) entirely above the Linux kernel; 2) entirely inside 
> the Linux kernel; 3) entirely below the Linux kernel; or 4) a combination 
> of these.
