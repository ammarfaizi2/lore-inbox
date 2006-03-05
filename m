Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750728AbWCEUSn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750728AbWCEUSn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Mar 2006 15:18:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750733AbWCEUSn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Mar 2006 15:18:43 -0500
Received: from h-66-166-126-70.lsanca54.covad.net ([66.166.126.70]:23557 "EHLO
	myri.com") by vger.kernel.org with ESMTP id S1750728AbWCEUSm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Mar 2006 15:18:42 -0500
Message-ID: <440B4799.7030609@ens-lyon.org>
Date: Sun, 05 Mar 2006 15:18:33 -0500
From: Brice Goglin <Brice.Goglin@ens-lyon.org>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Aritz Bastida <aritzbastida@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: MMAP: How a driver can get called on mprotect()
References: <7d40d7190603051012p16ed826cx@mail.gmail.com>	 <20060305182240.GH19232@lug-owl.de> <7d40d7190603051040h17da06caw@mail.gmail.com>
In-Reply-To: <7d40d7190603051040h17da06caw@mail.gmail.com>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Aritz Bastida wrote:

>Nonetheless the question is the same: a char device with mmap
>implemented can get called any time a new vma is created or destroyed
>(a process creating a new mmap):  vma_open() and vma_close().
>
>But if a user process changes the mmap protections calling mprotect()?
>How can the driver know about that? Is there any way to do that?
>  
>

You probably want to remove VM_MAYWRITE from vma->vm_flags in the mmap
vm_op of your char device.
For instance, see how the DRM device mmap protection is set when you're
not admin and the device is read-only:
    http://sosdg.org/~coywolf/lxr/source/drivers/char/drm/drm_vm.c#L570

Brice

