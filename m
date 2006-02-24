Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750866AbWBXHms@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750866AbWBXHms (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 02:42:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750869AbWBXHms
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 02:42:48 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:64139 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1750863AbWBXHmr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 02:42:47 -0500
Date: Fri, 24 Feb 2006 08:42:35 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Martin Schlemmer <azarah@nosferatu.za.org>
cc: "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>
Subject: Re: Problems with read() on /proc/devices with x86_64 system
In-Reply-To: <1140643550.26079.30.camel@lycan.lan>
Message-ID: <Pine.LNX.4.61.0602240841030.16363@yvahk01.tjqt.qr>
References: <1140635265.26079.16.camel@lycan.lan> 
 <Pine.LNX.4.61.0602221520080.11376@chaos.analogic.com> <1140643550.26079.30.camel@lycan.lan>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> If your code ever worked, it's probably because of some
>> fortuitous buffering in the 'C' runtime library.
>
>Not my code .. I just did a minimal hack to get it to build with klibc
>(klibc do not support fscanf(), so used fread() and sscanf() ..).
>
Ah, you can't do fread(ptr, 4096, 1, fp), because it would probably never 
return 1 if the file was smaller than 4096. Bad luck with stdio, I'd say. 
Back to read(2).

>>  Most
>> of the 'read' code in drivers that have a /proc interface
>> is not designed for 1-character-at-a-time I/O. It's expected
>> that it will be accessed like `cat` or `more` or other
>> such tools access it, -- one read with 4096-byte buffer --
>> 
>> read(3, "MemTotal:       773860 kB\nMemFre"..., 4096) = 670
>> write(1, "MemTotal:       773860 kB\nMemFre"..., 670) = 670

Jan Engelhardt
-- 
