Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267330AbUGNJCE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267330AbUGNJCE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 05:02:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267333AbUGNJCE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 05:02:04 -0400
Received: from mailhost.tue.nl ([131.155.2.7]:3846 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S267331AbUGNJCB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 05:02:01 -0400
Date: Wed, 14 Jul 2004 11:01:59 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] kill drive_info
Message-ID: <20040714090159.GA3821@pclin040.win.tue.nl>
References: <20040714000810.GA7308@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040714000810.GA7308@fs.tum.de>
User-Agent: Mutt/1.4.1i
X-Spam-DCC: : 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 14, 2004 at 02:08:10AM +0200, Adrian Bunk wrote:

> What about the patch below to kill drive_info?
> 
> Please double-check this patch, all I checked was a test of compilation
> on i386.

> -		unsigned char *BIOS = (unsigned char *) &drive_info;
> +		unsigned char *BIOS = &boot_params[0x80];

Ugly. There is already a define DRIVE_INFO for this right hand side:

  setup.h:#define PARAM (boot_params)
  setup.h:#define DRIVE_INFO (*(struct drive_info_struct *) (PARAM+0x80))


> - 	drive_info = DRIVE_INFO;

Hmm. setup.c copies this info from where it was left after booting
to some safe place. You seem to think that this saving is not required.
Is it not?

Andries
