Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261524AbVDJREt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261524AbVDJREt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Apr 2005 13:04:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261523AbVDJREt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Apr 2005 13:04:49 -0400
Received: from main.gmane.org ([80.91.229.2]:56491 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S261525AbVDJRDg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Apr 2005 13:03:36 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Erik Meitner <lkml@kwax.hn.org>
Subject: Re: [patch] inotify for 2.6.11
Date: Sun, 10 Apr 2005 11:16:33 -0500
Message-ID: <d3bjbr$anq$1@sea.gmane.org>
References: <1109961444.10313.13.camel@betsy.boston.ximian.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: mdsnwi13-vlan446-68.dsl.tds.net
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.3) Gecko/20040918 Thunderbird/0.8 Mnenhy/0.6.0.104
X-Accept-Language: en-us, en
In-Reply-To: <1109961444.10313.13.camel@betsy.boston.ximian.com>
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Love wrote:
> Below is inotify, diffed against 2.6.11.
> 
> I greatly reworked much of the data structures and their interactions,
> to lay the groundwork for sanitizing the locking.  I then, I hope,
> sanitized the locking.  It looks right, I am happy.  Comments welcome.
> I surely could of missed something.  Maybe even something big.
> 
> But, regardless, this release is a huge jump from the previous, fixing
> all known issues and greatly improving the locking.
> 

Inotify 0.22 severly destabilized my 2.6.11 system when it was in use.
The system would get into a state where it was unable to spawn new
processes, the desktop would hang, and the only way to shut down would
be to do a hard reset. This only happened when inotify was in use after
gamin started up.  I was only able to get the following out of the
logs(not every time though):

c017b901
Modules linked in: radeon deflate zlib_deflate twofish serpent aes_i586
blowfish sha256 sha1 crypto_null af_key parport_pc lp parport 8250_pci
8250 serial_core usbhid ohci_hcd ohci1394 ieee1394 yenta_socket
rsrc_nonstatic
suspend_text
CPU:    0
EIP:    0060:[inotify_ignore+49/224]    Not tainted VLI
EFLAGS: 00010246   (2.6.11.6-nx9005)
EIP is at inotify_ignore+0x31/0xe0
eax: 00000000   ebx: e88544e0   ecx: 00000000   edx: 00000000
esi: 00000000   edi: e88544e0   ebp: e8760000   esp: e8761f20
ds: 007b   es: 007b   ss: 0068
Process gam_server (pid: 6640, threadinfo=e8760000 task=ed19e060)
Stack: e88544e8 000000f6 e88544e0 fffffff2 fffffff7 c017bace e88544e0
000000f6
       00000004 000000f6 00000292 00000000 08098e54 80045102 fffffff7
c01685a8
       e5d584c0 80045102 08098e54 c0456118 00000000 e5d584c0 c0168785
e5d584c0
Call Trace:
 [inotify_ioctl+286/288] inotify_ioctl+0x11e/0x120
 [do_ioctl+104/128] do_ioctl+0x68/0x80
 [vfs_ioctl+101/464] vfs_ioctl+0x65/0x1d0
 [sys_ioctl+69/144] sys_ioctl+0x45/0x90
 [syscall_call+7/11] syscall_call+0x7/0xb
Code: 10 89 5c 24 08 89 74 24 0c 8b 7c 24 18 ff 4f 28 0f 88 95 03 00 00
8b 44 24 1c 89 44 24 04 8d 47 08 89 04 24 e8 11 89 0b 00 89 c6 <ff> 40
10 ff 47 28 0f 8e 81 03 00 00 85 f6 b8 ea ff ff ff 74 6e

Thanks.

