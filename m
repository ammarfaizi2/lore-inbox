Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932416AbWAKRzw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932416AbWAKRzw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 12:55:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932413AbWAKRzw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 12:55:52 -0500
Received: from bender.bawue.de ([193.7.176.20]:64385 "EHLO bender.bawue.de")
	by vger.kernel.org with ESMTP id S932415AbWAKRzv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 12:55:51 -0500
Date: Wed, 11 Jan 2006 18:52:40 +0100
From: Joerg Sommrey <jo@sommrey.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] amd76x_pm: C2 powersaving for AMD K7
Message-ID: <20060111175240.GA29857@sommrey.de>
Mail-Followup-To: Joerg Sommrey <jo@sommrey.de>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20060110194622.GA14645@sommrey.de> <20060111032057.7569be8a.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060111032057.7569be8a.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 11, 2006 at 03:20:57AM -0800, Andrew Morton wrote:
> Joerg Sommrey <jo@sommrey.de> wrote:
> >
> >  +static void
> >  +config_amd768_C2(int enable)
> >  +{
> >  +	unsigned char regbyte;
> >  +
> >  +	/* Set C2 options in DevB:3x4F, page 100 in AMD-768 doc */
> >  +	pci_read_config_byte(pdev_sb, 0x4F, &regbyte);
> >  +	if(enable)
> >  +		regbyte |= C2EN;
> >  +	else
> >  +		regbyte ^= C2EN;
> 
>  &= ?
This piece of code was not written by me.  I agree
	regbyte &= ^C2EN;
is more common.  However, calling config_amd768_C2(0) *would* work, if
config_amd768_C2(1) had been called before.  But config_amd768_C2(0)
never gets called...

Seems like I need to fix this too.

-jo

-- 
-rw-r--r--  1 jo users 63 2006-01-10 20:55 /home/jo/.signature
