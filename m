Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261364AbULETS6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261364AbULETS6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Dec 2004 14:18:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261365AbULETS6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Dec 2004 14:18:58 -0500
Received: from wproxy.gmail.com ([64.233.184.198]:55588 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261364AbULETS4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Dec 2004 14:18:56 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=Ec5ekNMc2476/kVSUcN1oEPB9AjN5wtDAHxe84mypzlkR0cVQp+hP27AipbLKgDRsU9lIom9XcdKb4b7FYYkOCkMx8okr+k+qPcR94hbl5y9BGX15WDAA+KAk1FEWDvmKxMpo95V5VwuGBPnGQyQiSR36e54jrHwVF0c2G4qFws=
Message-ID: <3b2b320041205111821527278@mail.gmail.com>
Date: Sun, 5 Dec 2004 14:18:45 -0500
From: Linh Dang <dang.linh@gmail.com>
Reply-To: Linh Dang <dang.linh@gmail.com>
To: Linh Dang <dang.linh@gmail.com>, Paul Mackerras <paulus@samba.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][PPC32[NEWBIE] enhancement to virt_to_bus/bus_to_virt (try 2)
In-Reply-To: <20041205101110.GC3448@gate.ebshome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <3b2b32004120206497a471367@mail.gmail.com>
	 <3b2b320041202082812ee4709@mail.gmail.com>
	 <16815.31634.698591.747661@cargo.ozlabs.ibm.com>
	 <3b2b32004120306463b016029@mail.gmail.com>
	 <20041205101110.GC3448@gate.ebshome.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 5 Dec 2004 02:11:10 -0800, Eugene Surovegin <ebs@ebshome.net> wrote:
[...]
> 
> Unfortunately your patch doesn't achieve your goals. vmalloc space on
> PPC32 will be between KERNEL_BASE and ioremap_bot anyway, so
> additional check is mostly useless anyway (it will only call iopa()
> for ioremaps done early during the boot).

Duh! how about using total_lowmem? i.e. use the current way for memory
between KERNEL_BASE and (KERNEL_BASE+total_lowmem),
and iopa for other addresses?

> 
> Also, even assuming you got the range right and called iopa() for
> vmalloced space, tell me how are you gonna deal with non-physically
> continuous vmalloced buffers in your DMA library?

>From a single virtual buffer, the DMA library will build a chained list of
physically contiguous buffers (it  can be one or more physical buffers).
All the DMA engines I'm familiar with (mpc8260, mpc8580, marvell, etc.)
accept a list of physical buffers.

The decoding algorithm (from a single virtual buffer to a chained list of
physical buffers) is dead simple.

Thanx for the reply
-- 
Linh Dang
