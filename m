Return-Path: <linux-kernel-owner+w=401wt.eu-S1751080AbWLLDw2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751080AbWLLDw2 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 22:52:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751081AbWLLDw2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 22:52:28 -0500
Received: from palinux.external.hp.com ([192.25.206.14]:59556 "EHLO
	mail.parisc-linux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751080AbWLLDw1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 22:52:27 -0500
Date: Mon, 11 Dec 2006 20:52:22 -0700
From: Matthew Wilcox <matthew@wil.cx>
To: Arnaldo Carvalho de Melo <acme@mandriva.com>
Cc: "James E.J. Bottomley" <James.Bottomley@SteelEye.com>,
       Andrew Morton <akpm@osdl.org>, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH][SCSI]: Save some bytes in struct scsi_target
Message-ID: <20061212035221.GF21070@parisc-linux.org>
References: <20061212031718.GC6218@mandriva.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061212031718.GC6218@mandriva.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2006 at 01:17:18AM -0200, Arnaldo Carvalho de Melo wrote:
> }; /* size: 368, cachelines: 12 */
> }; /* size: 364, cachelines: 12 */

Saving space is always good ;-)

> -	unsigned int		create:1; /* signal that it needs to be added */
> +	char			scsi_level;
> +	unsigned char		create:1; /* signal that it needs to be added */
>  	unsigned int		pdt_1f_for_no_lun;	/* PDT = 0x1f */
>  						/* means no lun present */
>  
> -	char			scsi_level;

However, pdt_1f_for_no_lun is really only one bit, saving another 4 bytes.

>  	struct execute_work	ew;
>  	enum scsi_target_state	state;

enums are a bit of a pain.  Even though scsi_target_state uses only two
values, it's represented as an int.  Unless you're on arm-eabi, when
it'll use less.  And even then, it won't use less than a byte, as it has
to be addressable.  I wonder if we can turn scsi_target_state into a
bit.  That'll save another 8 bytes total.
