Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262357AbUKKS0X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262357AbUKKS0X (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 13:26:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262339AbUKKSYF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 13:24:05 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:41681 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S262301AbUKKSW5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 13:22:57 -0500
Date: Thu, 11 Nov 2004 10:22:29 -0800
From: Greg KH <greg@kroah.com>
To: Gabriel Paubert <paubert@iram.es>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Recent I2C "dead code removal" breaks pmac sound.
Message-ID: <20041111182228.GA23236@kroah.com>
References: <20041111180902.GA8697@iram.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041111180902.GA8697@iram.es>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 11, 2004 at 07:09:02PM +0100, Gabriel Paubert wrote:
> 	Hi,
> 	
> a recent patch to drivers/i2c/i2c-core.c removed a bunch of
> functions because they were unused; i2c_smbus_write_block_data
> was in the lot. I happen to have a different definition of dead
> code since grepping for it reveals (in sound/ppc/pmac.h):
> 
> #define snd_pmac_keywest_write(i2c,cmd,len,data) i2c_smbus_write_block_data((i2c)->client, cmd, len, data)
> 
> I only get a link time error since the removed functions are still
> declared in include/linux/i2c.h, and that is certainly wrong.
> 
> For now I have successfully compiled with the following patch
> which ressuscitates the function I need. In a recent pull, the 
> offending cset is 1.2114.2.8 from November 5th by arjan.
> 
> This patch is _not_ final, but I don't know what sould be done:
> excluding the cset, or applying the following and making
> the include file match the existing functions, or something
> completely different?

Put the function back, and change the pmac.h file to delete the #define,
and replace the snd_pmac_keywest_write function with a real call to
i2c_smbus_write_block_data so things like this don't happen again.

Care to write a patch to do this?

thanks,

greg k-h
