Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751639AbWG0PHk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751639AbWG0PHk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 11:07:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750787AbWG0PHk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 11:07:40 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:63154 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751639AbWG0PHj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 11:07:39 -0400
Date: Thu, 27 Jul 2006 16:07:37 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Eugene Teo <eteo@redhat.com>
Subject: Re: Require mmap handler for a.out executables
Message-ID: <20060727150737.GA29521@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Linus Torvalds <torvalds@osdl.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>, Eugene Teo <eteo@redhat.com>
References: <1153909881.746.39.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1153909881.746.39.camel@localhost>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> diff --git a/fs/binfmt_aout.c b/fs/binfmt_aout.c
> index f312103..5638acf 100644
> --- a/fs/binfmt_aout.c
> +++ b/fs/binfmt_aout.c
> @@ -278,6 +278,9 @@ static int load_aout_binary(struct linux
>  		return -ENOEXEC;
>  	}
>  
> +	if (!bprm->file->f_op || !bprm->file->f_op->mmap)
> +		return -ENOEXEC;
> +

These checks need a big comment explanining why they are there, else people
will remove them again by accident.

