Return-Path: <linux-kernel-owner+w=401wt.eu-S965087AbWLMTS0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965087AbWLMTS0 (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 14:18:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965092AbWLMTS0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 14:18:26 -0500
Received: from mail1.key-systems.net ([81.3.43.211]:40752 "HELO
	mail1.key-systems.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S965087AbWLMTSZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 14:18:25 -0500
Message-ID: <458051FD.1060900@scientia.net>
Date: Wed, 13 Dec 2006 20:18:21 +0100
From: Christoph Anton Mitterer <calestyo@scientia.net>
User-Agent: Icedove 1.5.0.8 (X11/20061129)
MIME-Version: 1.0
To: Karsten Weiss <K.Weiss@science-computing.de>
CC: linux-kernel@vger.kernel.org, Erik Andersen <andersen@codepoet.org>,
       Chris Wedgwood <cw@f00f.org>, Andi Kleen <ak@suse.de>
Subject: Re: data corruption with nvidia chipsets and IDE/SATA drives // memory
 hole mapping related bug?!
References: <Pine.LNX.4.64.0612021202000.2981@addx.localnet> <Pine.LNX.4.61.0612111001240.23470@palpatine.science-computing.de>
In-Reply-To: <Pine.LNX.4.61.0612111001240.23470@palpatine.science-computing.de>
Content-Type: multipart/mixed;
 boundary="------------010807020208010404020806"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010807020208010404020806
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Karsten Weiss wrote:
> Last week we did some more testing with the following result:
>
> We could not reproduce the data corruption anymore if we boot the machines 
> with the kernel parameter "iommu=soft" i.e. if we use software bounce 
> buffering instead of the hw-iommu. (As mentioned before, booting with 
> mem=2g works fine, too, because this disables the iommu altogether.)
>   
I can confirm this,...
booting with mem=2G => works fine,...

(all of the following tests were made with memory hole mapping=hardware
in the BIOS,.. so I could access my full ram):
booting with iommu=soft => works fine
booting with iommu=noagp => DOESN'T solve the error
booting with iommu=off => the system doesn't even boot and panics

When I set IOMMU to disabled in the BIOS the error is not solved-
I tried to set bigger space for the IOMMU in the BIOS (256MB instead of
64MB),.. but it does not solve the problem.

Any ideas why iommu=disabled in the bios does not solve the issue?

> I.e. on these systems the data corruption only happens if the hw-iommu 
> (PCI-GART) of the Opteron CPUs is in use.
>   
1) And does this now mean that there's an error in the hardware (chipset
or CPU/memcontroller)?


> Christoph, Erik, Chris: I would appreciate if you would test and hopefully 
> confirm this workaround, too.
>   
Yes I can absolutely confirm this...
Do my additional tests help you?



Do you have any ideas why the issue doesn't occur (even with memhole
mapping=hardware in the bios and no iommu=soft at kernel command line)
when dma is disabled for the disks (or a slower dma mode is used)?


Chris.

--------------010807020208010404020806
Content-Type: text/x-vcard; charset=utf-8;
 name="calestyo.vcf"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="calestyo.vcf"

YmVnaW46dmNhcmQNCmZuOk1pdHRlcmVyLCBDaHJpc3RvcGggQW50b24NCm46TWl0dGVyZXI7
Q2hyaXN0b3BoIEFudG9uDQplbWFpbDtpbnRlcm5ldDpjYWxlc3R5b0BzY2llbnRpYS5uZXQN
CngtbW96aWxsYS1odG1sOlRSVUUNCnZlcnNpb246Mi4xDQplbmQ6dmNhcmQNCg0K
--------------010807020208010404020806--
