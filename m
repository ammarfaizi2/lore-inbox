Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262422AbUFBMj3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262422AbUFBMj3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 08:39:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262438AbUFBMj3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 08:39:29 -0400
Received: from chaos.analogic.com ([204.178.40.224]:45440 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262422AbUFBMj1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 08:39:27 -0400
Date: Wed, 2 Jun 2004 08:39:15 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: "Piszcz, Justin Michael" <justin.piszcz@mitretek.org>
cc: linux-kernel@vger.kernel.org, Al Piszcz <apiszcz@solarrain.com>
Subject: Re: How come dd if=/dev/zero of=/nfs/dev/null does not send packets
 over the network?
In-Reply-To: <5D3C2276FD64424297729EB733ED1F7606243695@email1.mitretek.org>
Message-ID: <Pine.LNX.4.53.0406020828060.2685@chaos>
References: <5D3C2276FD64424297729EB733ED1F7606243695@email1.mitretek.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Jun 2004, Piszcz, Justin Michael wrote:

> root@jpiszcz:~# mkdir /p500/dev
> root@jpiszcz:~# mount 192.168.0.253:/dev /p500/dev
> root@jpiszcz:~# echo blah > /p500/dev/null
> root@jpiszcz:~# ls -l /p500/dev/null
> crw-rw-rw-  1 root sys 1, 3 Jul 17  1994 /p500/dev/null
> root@jpiszcz:~# dd if=/dev/zero of=/p500/dev/null
>
> 6179737+0 records in
> 6179736+0 records out
>
> Instead it treats it as a local block device?
>
> Kernel 2.6.5.
>

First, /dev/null is a device file. Can you access a remote
device over nfs? ... like

		mount chaos:/dev/ttyS0  /mnt
		cat "foo" >/mnt

I think not. Yes it's the exact same thing; /dev/null is a
character device just like /dev/ttyS0, but a bit dumber.
The above used the network to make the essential equivalent
of a sym-link. The open of the device-file, the connection
of the major-minor numbers to the resulting file descriptor
occurred on your local system.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.26 on an i686 machine (5570.56 BogoMips).
            Note 96.31% of all statistics are fiction.


