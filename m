Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265492AbUFCEGw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265492AbUFCEGw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 00:06:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265493AbUFCEGw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 00:06:52 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:58069 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265492AbUFCEGu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 00:06:50 -0400
Message-ID: <40BEA3CB.60908@pobox.com>
Date: Thu, 03 Jun 2004 00:06:35 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jouni Malinen <jkmaline@cc.hut.fi>
CC: "Luis R. Rodriguez" <mcgrof@studorgs.rutgers.edu>,
       Netdev <netdev@oss.sgi.com>, hostap@shmoo.com,
       prism54-devel@prism54.org, Jean Tourrilhes <jt@bougret.hpl.hp.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Prism54 WPA Support - wpa_supplicant - Linux general wpa support
References: <20040602071449.GJ10723@ruslug.rutgers.edu> <20040602132313.GB7341@jm.kir.nu>
In-Reply-To: <20040602132313.GB7341@jm.kir.nu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jouni Malinen wrote:
> The first thing I would like to see is an addition to  Linux wireless
> extensions for WPA/WPA2 so that we can get rid of the private ioctls in
> the drivers. Even though these can often be similar, it would be nice to
> just write one driver interface code in wpa_supplicant and have it
> working with all Linu drivers.. I hope to find some time to write a
> proposal for this.


One of the things that is nice about wireless-2.6 is that is affords the 
opportunity to totally rethink the wireless extensions.

Although a lot of people would howl, since HostAP is essentially new 
code from the mainline kernel perspective, a new userland API (and new 
or updated tools) could come along with it.

I have mentioned in the past (no offense Jean!) that I do not like the 
overly-generic wireless handler structure.  It is less type-safe than is 
generally preferred in Linux, IMO.

A low-level wireless driver should not implement ioctls, it should 
implement callbacks in some sort of 'struct wireless_operations' as is 
done in other kernel subsystems.

ioctl details should be hidden from low-level drivers as much as 
possible, through type-safe interfaces.  Strive to make both the 
wireless driver API and the wireless userland API easy to change and 
evolve over time.

	Jeff


