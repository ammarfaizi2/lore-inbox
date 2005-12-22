Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751132AbVLVPZi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751132AbVLVPZi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 10:25:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751107AbVLVPZi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 10:25:38 -0500
Received: from nommos.sslcatacombnetworking.com ([67.18.224.114]:28973 "EHLO
	nommos.sslcatacombnetworking.com") by vger.kernel.org with ESMTP
	id S1751132AbVLVPZh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 10:25:37 -0500
In-Reply-To: <DADA32856852FC458E0F96B664A6F55E011E232F@kom-mailsrv1.kontron-modular.com>
References: <DADA32856852FC458E0F96B664A6F55E011E232F@kom-mailsrv1.kontron-modular.com>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=ISO-8859-1; delsp=yes; format=flowed
Message-Id: <DC39FA32-0902-4F1B-A0A2-A93E1076DA98@kernel.crashing.org>
Cc: "Linux Kernel List" <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: AW: Submitting patches for Kontron-boards with Freescale processors
Date: Thu, 22 Dec 2005 09:25:49 -0600
To: Claus Gindhart <Claus.Gindhart@kontron.com>
X-Mailer: Apple Mail (2.746.2)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - nommos.sslcatacombnetworking.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - kernel.crashing.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Dec 21, 2005, at 4:56 AM, Claus Gindhart wrote:

> Kumar,
>
> Due to your E-Mail i have checked into the linuxppc mailing lists.  
> I am aware now of the restructuring process in the Kernel regarding  
> the flattened device tree for passing parameters from the  
> Bootloader to the Kernel.
>
> Actually all Kontron-PowerPC-Boards, (VME-, CompactPCI- and  
> E²Brain- boards) are equipped with the Kontron NetBootLoader. This  
> Ecos-based bootloader currently passes all parameters to the Kernel  
> via an E²PROM-Device. We have also some custom projects using U- 
> Boot, but our standard products all have the Kontron Bootloader.
>
> The question is now: Will it be a mandatory requirement, that the  
> Bootloader provides the flattened device list, or will it be  
> allowed in future to provide a platform-specific function, which  
> generates the flattened device tree (as we previously did within  
> the embed_config() function, where we built the struct bd_t) ?

It is expected that the boot loader provide a flat device tree to the  
kernel.  I'm not aware of anyone working on a wrapper to provide a  
flat device tree.  Do realize there are tools like DTC that will  
produce a device tree blob based on an input file.  This blob can  
than be handed to the kernel.

Take a look at:
http://ozlabs.org/git?p=dtc.git;a=summary

and
Documentation/booting-without-of.txt (in DTC) which talks about what  
arch/powerpc expects from the bootloader.

- kumar


> -----Ursprüngliche Nachricht-----
> Von: Kumar Gala [mailto:galak@kernel.crashing.org]
> Gesendet: Montag, 19. Dezember 2005 16:07
> An: Claus Gindhart
> Cc: Linux Kernel List
> Betreff: Re: Submitting patches for Kontron-boards with Freescale
> processors
>
>
>
> On Dec 19, 2005, at 2:07 AM, Claus Gindhart wrote:
>
>> Kumar,
>>
>> in our department we have Linux 2.6 kernel ports for Kontron
>> embedded computer boards with freescale processors 8245, 405, 8540,
>> 8541, 8347, 8270, ...
>>
>> We would like to start now to submit all these board supports to
>> the vanilla kernel.
>>
>> For the start we would select one of our common boards, e.g. the
>> one with 8540/8541 processor.
>>
>> My question is now:
>> Should we try to provide a patch with all HW-features of the board
>> supported, or would it be better to start with a minimalistic
>> patch, and then add support for additional devices onboard (e.g.
>> IDE, RTC, SuperIO, ...) time by time ?
>>
>> Or would it be better to provide the full feature set of this board
>> at one time ?
>
> First, I would recommend posting such queries to the linuxppc lists
> (linuxppc-dev@ozlabs.org, linuxppc-embedded@ozlabs.org).
>
> Second, I'm no longer at Freescale so please email me at this address.
>
> Ok, now to your question.  In general if a given board port touch
> files in arch/ppc/platforms/* than all of that code should be in one
> patch.  If you are touching anything in drivers/* you need to
> separate out those patches and send them to the respective driver
> maintainers.  If you want to provide a more detailed list of changes
> for 8540/8541 I can provide better directions on how to submit  
> patches.
>
> What boot loader are you using for your boards?  I ask because for
> the 85xx and 83xx subarchitectures I'm trying to limit new board
> ports in arch/ppc as we try to transition to arch/powerpc.  However,
> this requires that the firmware provide a flatten device tree to the
> kernel.
>
> Hopefully that gets you a sense and feel free to ask any other
> questions.
>
> - kumar
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux- 
> kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

