Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266885AbTGGJAa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jul 2003 05:00:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266887AbTGGJAa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jul 2003 05:00:30 -0400
Received: from [81.89.69.194] ([81.89.69.194]:54162 "EHLO tretyak.sun.mcst.ru")
	by vger.kernel.org with ESMTP id S266885AbTGGJAU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jul 2003 05:00:20 -0400
Message-ID: <3F093B60.1010001@mcst.ru>
Date: Mon, 07 Jul 2003 13:20:32 +0400
From: "Ilia A. Petrov" <masmas@mcst.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030312
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: David Brownell <david-b@pacbell.net>
CC: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] PROBLEM: when booting from USB-HDD device kernel
 2.4.21 is trying to mount root file system too early before usb device is
 found on the usb-bus
References: <3F056D0D.3050101@mcst.ru> <3F05A4C8.9060604@pacbell.net>
In-Reply-To: <3F05A4C8.9060604@pacbell.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Brownell wrote:
> Ilia A. Petrov wrote:
> 
>> When kernel is mounting root file system it is doing it too fast so 
>> usb-support have not ime to scan bus for mass-storage devices and 
>> connect them.
>> ...
>> or, imho better way, - when completing init of usb bus, first scans it 
>> and connect all devices and only after all devices were connected 
>> returns to main kernel code.
> 
> 
> That might not entirely solve the problem, since the relevant device
> could drop off the bus temporarily, but it seems like it'd be a step
> forward.  How would you make root hub ("bus") initialization do that?

i'm not familiar with linux usb implementation so may be it's wrong:
after sending global reset over the bus you can manually check (not 
trough the hub driver) root port connection status and call enumeration 
if needed.

another way- add an option to kernel for booting from usb mass-storage, 
where place an input-waiting code, because my current solution adds such 
delay for all boots (ide,scsi,usb)

