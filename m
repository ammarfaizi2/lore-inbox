Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965092AbVHPEJh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965092AbVHPEJh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 00:09:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932601AbVHPEJh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 00:09:37 -0400
Received: from adsl-67-65-14-122.dsl.austtx.swbell.net ([67.65.14.122]:36798
	"EHLO laptop.michaels-house.net") by vger.kernel.org with ESMTP
	id S932600AbVHPEJg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 00:09:36 -0400
Subject: Re: [RFC][PATCH 2.6.13-rc6] add Dell Systems Management Base
	Driver (dcdbas) with sysfs support
From: Michael E Brown <Michael_E_Brown@dell.com>
To: Valdis.Kletnieks@vt.edu, linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Mon, 15 Aug 2005 23:09:28 -0500
Message-Id: <1124165368.10755.136.camel@soltek.michaels-house.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>On Mon, 15 Aug 2005 18:38:49 CDT, Doug Warzecha said:
>
>> > If this is supposed to be used with the RBU code to trigger a BIOS  
>> > update, ...
>> 
>> This driver is not needed by the RBU code.
>
> Documentation/dell_rbu.txt says:
>
>> The rbu driver needs to have an application which will inform the BIOS to
>> enable the update in the next system reboot.
>
> Can the dcdbas code be used to implement that application?

No, dcdbas has nothing to do with this. I'll have to submit a patch
against the docs. The program you need to use already exists and is
open source. You can use libsmbios to do this.
http://linux.dell.com/libsmbios/main.

The binary you want to use is "activateCmosToken", under bins/output/
(after compilation). The command line syntax is like this:
	activateCmosToken 0x005C

If you want to cancel a BIOS update that has already been activated
(per above), use: 	
	activateCmosToken 0x005D

Basically, follow the docs in the RBU docs as far as cat-ing the bios
update image to the rbu sysfs files, then use the activateCmosToken
program to tell BIOS to do the update on reboot. 

-- 
Michael




