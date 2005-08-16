Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932440AbVHPUn5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932440AbVHPUn5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 16:43:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932441AbVHPUn5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 16:43:57 -0400
Received: from smtp.osdl.org ([65.172.181.4]:31440 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932440AbVHPUn4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 16:43:56 -0400
Date: Tue, 16 Aug 2005 13:44:18 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: Nicholas Fechner <fechner@ponton-consulting.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Module bridge not loading in 2.6.13-rc6
Message-ID: <20050816134418.5d7b8791@dxpl.pdx.osdl.net>
In-Reply-To: <43019C3D.4060705@ponton-consulting.de>
References: <43019C3D.4060705@ponton-consulting.de>
X-Mailer: Sylpheed-Claws 1.9.11 (GTK+ 2.6.7; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Aug 2005 09:56:45 +0200
Nicholas Fechner <fechner@ponton-consulting.de> wrote:

> Please CC to fechner@ponton-consulting.de, since I am not subscribed to
> linux-kernel. Thanks.
> 
> Hi,
> I tried the current -rc6 Release on one of our test machines. It is a
> mirror of our gateway, hence the iptable modules. It also runs OpenVPN
> using a bridge configuration. After the kernel build and reboot I tried
> to "modprobe bridge", resulting in:
> 
> FATAL: Error inserting bridge
> (/lib/modules/2.6.13-rc6/kernel/net/bridge/bridge.ko): Unknown symbol in
> module, or unknown parameter (see dmesg)
> 
>
> bridge: disagrees about version of symbol dev_set_mtu
> bridge: Unknown symbol dev_set_mtu
> bridge: disagrees about version of symbol dev_queue_xmit
> bridge: Unknown symbol dev_queue_xmit
> bridge: Unknown symbol br_handle_frame_hook

You rebuilt the kernel (or bridge module), but did not install the updated
modules.  The module versioning code checks that any module loaded was
built from the same source as the kernel itself. In your case the bridge
module does not correspond to the running kernel.  If you are doing
your own kernel builds, you need to do:
	make modules_install
	make install
