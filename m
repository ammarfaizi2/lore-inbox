Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285417AbSBECcy>; Mon, 4 Feb 2002 21:32:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286895AbSBECcq>; Mon, 4 Feb 2002 21:32:46 -0500
Received: from tantale.fifi.org ([216.27.190.146]:65415 "EHLO tantale.fifi.org")
	by vger.kernel.org with ESMTP id <S285417AbSBECcg>;
	Mon, 4 Feb 2002 21:32:36 -0500
To: Alexander Sandler <ASandler@store-age.com>
Cc: "'sathish jayapalan'" <sathish_jayapalan@yahoo.com>,
        linux-kernel@vger.kernel.org
Subject: Re: How to crash a system and take a dump?
In-Reply-To: <BDE817654148D51189AC00306E063AAE054623@exchange.store-age.com>
From: Philippe Troin <phil@fifi.org>
Date: 04 Feb 2002 18:32:21 -0800
In-Reply-To: <BDE817654148D51189AC00306E063AAE054623@exchange.store-age.com>
Message-ID: <87zo2oacay.fsf@ceramic.fifi.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Sandler <ASandler@store-age.com> writes:

> > Hi,
> > I have a doubt. I know that linux kernel doesn't crash
> > so easily. Is there any way to panic the system? Can I
> > go to the source area and insert/modify a variable in
> > kernel code so that the kernel references a null
> > pointer and crashes while running the kernel compiled
> > with this variable. My aim is to learn crash dump
> > analysis with 'Lcrash tool". Please help me out with
> > this.
> 
> Go to interrupt handler (for instance in fs/buffer.c end_buffer_io_async() )
> and cause segmentation fault.
> System will try to kill process that caused segmentation fault and since
> it's in interrupt context will panic.

Simplier: insmod this module:

#include <linux/module.h>

int init_module()
{
   panic("Forcing panic");
}

int cleanup_module()
{
}

Phil.
