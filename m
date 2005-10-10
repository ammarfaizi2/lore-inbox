Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751282AbVJJXRB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751282AbVJJXRB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Oct 2005 19:17:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751328AbVJJXRB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Oct 2005 19:17:01 -0400
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:50913 "EHLO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1750919AbVJJXRA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Oct 2005 19:17:00 -0400
Date: Tue, 11 Oct 2005 01:16:59 +0200 (CEST)
From: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
To: Glauber de Oliveira Costa <glommer@br.ibm.com>
Cc: Anton Altaparmakov <aia21@cam.ac.uk>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, ext2-devel@lists.sourceforge.net,
       hirofumi@mail.parknet.co.jp, linux-ntfs-dev@lists.sourceforge.net,
       aia21@cantab.net, hch@infradead.org, viro@zeniv.linux.org.uk,
       akpm@osdl.org
Subject: Re: [PATCH] Use of getblk differs between locations
In-Reply-To: <20051010231242.GC11427@br.ibm.com>
Message-ID: <Pine.LNX.4.62.0510110112310.27454@artax.karlin.mff.cuni.cz>
References: <20051010204517.GA30867@br.ibm.com>
 <Pine.LNX.4.64.0510102217200.6247@hermes-1.csi.cam.ac.uk>
 <20051010214605.GA11427@br.ibm.com> <Pine.LNX.4.62.0510102347220.19021@artax.karlin.mff.cuni.cz>
 <Pine.LNX.4.64.0510102319100.6247@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.62.0510110035110.19021@artax.karlin.mff.cuni.cz>
 <20051010231242.GC11427@br.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 10 Oct 2005, Glauber de Oliveira Costa wrote:

>
>> What should a filesystem driver do if it can't suddenly read or write any
>> blocks on media?
>
> Maybe stopping gracefully, warn about what happened, and let the system
> keep going. You may be right about your main filesystem, but in the case
> I'm running, for example, my system in an ext3 filesystem, and have a
> vfat from a usb key. Should my system really hang because I'm not able
> to read/write to the device?

getblk won't fail because of I/O error --- it can fail only because of 
memory management bugs. I think it's right to stop the system in that case 
--- it's better than silently corrupting data on any device.

Mikulas
