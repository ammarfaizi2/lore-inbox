Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261376AbVBROdn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261376AbVBROdn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Feb 2005 09:33:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261375AbVBROdm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Feb 2005 09:33:42 -0500
Received: from 212-100-178-232.adsl.easynet.be ([212.100.178.232]:12047 "EHLO
	daemon.octalis.com") by vger.kernel.org with ESMTP id S261374AbVBROdi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Feb 2005 09:33:38 -0500
Message-ID: <4215FCBB.6030906@octalis.com>
Date: Fri, 18 Feb 2005 15:33:31 +0100
From: Olivier Smeesters <smeesters@octalis.com>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041124)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: smeesters@octalis.com
Subject: compiling two modules from separate directories out of kernel tree
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear all,

I'm currently developping two kernel modules that I'm compiling outside 
of the kernel tree. One is a device driver and one is a pseudo-network 
device driver (encapsulating network packets).
The output of the encapsulator is supposed to go to the device driver. 
For this reason, the device driver exports a "send_packet" function 
which the encapsulator calls.

When loading the encapsulator module, the kernel reports a 'no version 
for "send_packet" found' and goes in tainted mode.
It seems that this is caused by the fact that the two modules are 
compiled in different directories (there is no CRC for the send_packet 
function in the encapsulator module, only for the kernel functions it 
calls).

One solution is to put all the modules in one directory. When this is 
done, a CRC is present in the encapsulator module as expected by the 
module loader and there is no warning anymore.
But as the two drivers are not definitely related (the device driver can 
be used without the encapsulator), I would like to keep them in separate 
directories.
This situation ressembles to the situation of the PLIP and the parport 
driver.

Is there a way to avoid the warning (and tainted mode) while still 
compiling them outside of the kernel tree and in separate directories ?

Thanks in advance,


Olivier Smeesters

