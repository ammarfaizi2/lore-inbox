Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264503AbUEDQRl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264503AbUEDQRl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 May 2004 12:17:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264513AbUEDQRl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 May 2004 12:17:41 -0400
Received: from gate.ebshome.net ([66.92.248.57]:42129 "EHLO gate.ebshome.net")
	by vger.kernel.org with ESMTP id S264503AbUEDQR2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 May 2004 12:17:28 -0400
Date: Tue, 4 May 2004 09:17:26 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: remy.gauguey@mindspeed.com
Cc: linux-crypto@nl.linux.org, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6 crypto API and HW accelerators
Message-ID: <20040504161726.GA25795@gate.ebshome.net>
References: <OF4ED7CD00.900586C8-ONC1256E8A.00491716-C1256E8A.004B08FD@nice.mindspeed.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF4ED7CD00.900586C8-ONC1256E8A.00491716-C1256E8A.004B08FD@nice.mindspeed.com>
X-ICQ-UIN: 1193073
X-Operating-System: Linux i686
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 04, 2004 at 03:39:35PM +0200, remy.gauguey@mindspeed.com wrote:
> I'm currently working on a ARM920T based network processor with arm-linux
> kernel 2.6.5.
> This device has a crypto hardware accelerator dedicated to IPsec.
> In ESP mode the device can do authentication (SHA-1, MD5) as well as
> encryption (AES, TDES in CBC or ECB mode) in one pass.
> Unfortunately current Linux 2.6 crypto API doesn't support this kind of
> hardware accelerator. Current crypto module relies on crypto algorithms
> which are called for a single operation and for each block.
> 
> Then, I would like to know if other people are working on the hardware
> crypto support in kernel 2.6.x.
> If so, what would be the plan ? crypto api improvement or new IPsec
> specific hardware support ?
> 

I wrote a driver recently for Hifn 7955 crypto processor for use in low-end PPC 
box (PPC 440, 500Mhz).

I added simple extension for current Crypto API, basically a pass-through path.

Patches can be found and http://kernel.ebshome.net (patches are of alpha 
quality, and were never tested on x86 :)

In short, my experience showed that without significant changes in current 
implementation, e.g. adding async crypto, adding hardware crypto is worth only 
for relatively slow CPUs, e.g. less than 1Ghz, and even with slow processor 
overhead can be so big, that short packets are better processed by software 
path.

As a side note, in addition to the limitation you noticed (sw crypto is called 
for one block), there are another one, currently Linux IPSec implementation 
always calls Crypto layer holding BH lock, so hw crypto driver have to busy wait 
even when called from process context. Maybe this can be easily changed.

Feel free to contact me privately if you need more information :)

Eugene

