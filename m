Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270534AbTGaRq7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 13:46:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270496AbTGaRq6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 13:46:58 -0400
Received: from hueytecuilhuitl.mtu.ru ([195.34.32.123]:56335 "EHLO
	hueymiccailhuitl.mtu.ru") by vger.kernel.org with ESMTP
	id S270478AbTGaRqy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 13:46:54 -0400
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: linux-kernel@vger.kernel.org
Subject: 2.6: races between modprobe and depmod in rc.sysinit
Date: Thu, 31 Jul 2003 21:45:01 +0400
User-Agent: KMail/1.5
Cc: "Chmouel Boudjnah" <chmouel@chmouel.com>, flepied@mandrakesoft.com,
       Rusty Russell <rusty@rustcorp.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307312145.01711.arvidjaar@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This started when I noticed that coldplugging of my USB flash did not work. I 
added call to /etc/hotplug/usb.rc in rc.sysinit but it still did not work 
because scsi.agent was not ready for 2.6. I fixed scsi.agent to work for 2.6 
- and it still did not work with nice message "sd_mod not found". I added 
strace to scsi.agent - and wow! it opens /lib/modules/`uname -r`/modules.dep 
and reads 0 bytes ... it adds /lib/modules/`uname -r`/modules.alias -and read 
0 bytes ...

the only reason I can imagine is that it hits depmod -A that runs in 
rc.sysinit and does

truncate /lib/modules/`uname -r`/modules.*
scan modules
write files

So, quesitons

- would anybody (Rusty?) object if I change depmod to do 
  build temp name
  move temp name into original

to avoid such races?

- Chmouel, Fred - is depmod on every boot really neccessary? When people 
install modules they are expected to run it actually ...

-andrey
