Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751310AbWDDEXL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751310AbWDDEXL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 00:23:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751437AbWDDEXL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 00:23:11 -0400
Received: from nommos.sslcatacombnetworking.com ([67.18.224.114]:33043 "EHLO
	nommos.sslcatacombnetworking.com") by vger.kernel.org with ESMTP
	id S1751310AbWDDEXJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 00:23:09 -0400
In-Reply-To: <200604031948.38101.david-b@pacbell.net>
References: <Pine.LNX.4.44.0603241429220.19557-100000@gate.crashing.org> <200604031948.38101.david-b@pacbell.net>
Mime-Version: 1.0 (Apple Message framework v746.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <074E7D37-773D-4203-BB09-20040C5D5D5B@kernel.crashing.org>
Cc: linux-usb-devel@lists.sourceforge.net, Greg KH <gregkh@suse.de>,
       LKML mailing list <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7bit
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [linux-usb-devel] compile error when building multiple EHCI host controllers as modules
Date: Mon, 3 Apr 2006 23:23:29 -0500
To: David Brownell <david-b@pacbell.net>
X-Mailer: Apple Mail (2.746.3)
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


On Apr 3, 2006, at 9:48 PM, David Brownell wrote:

> On Friday 24 March 2006 12:32 pm, Kumar Gala wrote:
>>> The issue I have this is that it makes two (or more) things that  
>>> were
>>> independent now dependent.  What about just moving the module_init/
>>> exit() functions into files that are built separately.  For the  
>>> ehci-
>>> fsl case it was trivial, need to look at ehci-pci case.
>>
>> Ok, my idea required exporting things I didn't really want to  
>> export, so
>> what about something like this or where you thinking of some more
>> sophisticated?
>>
>> If this is good, I'll do the same for ohci.
>
> How about this one instead?  It requires fewer per-SOC hacks in  
> generic
> code when adding a new SOC.  And it also removes a platform device  
> naming
> goof for your mpc83xx support ... that's a case where you should  
> just let
> the platform device IDs distinguish things.

Let me test this patch out.  I'm ok with the changes for handling  
both PCI and platform driver.  However, I need to take a look at the  
renaming of the fsl driver.  The "dr" device supports device and OTG  
modes.  I'm concerned about how we distinguish that in the future.

(also, we need to fixup arch/powerpc/sysdev/fsl_soc.c)

- k


