Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262329AbVEMKcr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262329AbVEMKcr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 06:32:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262331AbVEMKcr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 06:32:47 -0400
Received: from smtpout.azz.ru ([81.176.69.27]:28829 "HELO smtpout.azz.ru")
	by vger.kernel.org with SMTP id S262329AbVEMKci (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 06:32:38 -0400
Message-ID: <428482A1.5090107@vlnb.net>
Date: Fri, 13 May 2005 14:34:09 +0400
From: Vladislav Bolkhovitin <vst@vlnb.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: ru, en-us, en
MIME-Version: 1.0
To: Bryan Henderson <hbryan@us.ibm.com>
CC: David Hollis <dhollis@davehollis.com>, dmitry_yus@yahoo.com,
       FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>,
       Guennadi Liakhovetski <g.liakhovetski@gmx.de>,
       iscsitarget-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org, Sander <sander@humilis.net>,
       Maciej Soltysiak <solt2@dns.toxicfilms.tv>
Subject: Re: SCSI/ISCSI, hardware/software
References: <OFB07C63BD.91DCFD73-ON88256FFF.0065D9AA-88256FFF.006C4709@us.ibm.com>
In-Reply-To: <OFB07C63BD.91DCFD73-ON88256FFF.0065D9AA-88256FFF.006C4709@us.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
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

This is exactly what I wanted to say. Thanks for clarification

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

Such iSCSI card from a user point of view as well as for system running 
on a computer with it is just another SCSI card, not matter which 
transport it uses and how much software it runs onboard, so for they it 
doesn't differ from FC or parallel SCSI one, which I think you would not 
call a software unit. As usually, you only need appropriate driver for 
_SCSI_ subsystem.

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
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-scsi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 

