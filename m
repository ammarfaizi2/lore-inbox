Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262543AbTCIRCh>; Sun, 9 Mar 2003 12:02:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262544AbTCIRCh>; Sun, 9 Mar 2003 12:02:37 -0500
Received: from mailhost.tue.nl ([131.155.2.4]:9741 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id <S262543AbTCIRCg>;
	Sun, 9 Mar 2003 12:02:36 -0500
Date: Sun, 9 Mar 2003 18:13:14 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: Dave Jones <davej@codemonkey.org.uk>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Fwd: struct inode size reduction.
Message-ID: <20030309171314.GA3783@win.tue.nl>
References: <20030309135402.GB32107@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030309135402.GB32107@suse.de>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 09, 2003 at 12:54:03PM -0100, Dave Jones wrote:
> Third retry, perhaps it'll make it through to the list
> now that vger is sending mail again...

> I've been running with this patch, with no untoward consequences,
> seems to pass basic testing here, any objections before I push
> this Linuswards ? Al ? Christoph ?
> 
> --- bk-linus/include/linux/fs.h	2003-03-08 08:57:57.000000000 -0100
> +++ inode/include/linux/fs.h	2003-03-08 08:57:20.000000000 -0100
> @@ -382,12 +382,12 @@ struct inode {
>  	struct address_space	*i_mapping;
>  	struct address_space	i_data;
>  	struct dquot		*i_dquot[MAXQUOTAS];
> -	/* These three should probably be a union */
>  	struct list_head	i_devices;
> -	struct pipe_inode_info	*i_pipe;
> -	struct block_device	*i_bdev;
> -	struct char_device	*i_cdev;
> -
> +	union {
> +		struct pipe_inode_info	*i_pipe;
> +		struct block_device	*i_bdev;
> +		struct char_device	*i_cdev;
> +	} type;

Not really any objection, but this is half work where
more can be done. The comment is right: also i_devices
can go into the union.
(And i_cdev can be deleted altogether, but that is an
independent matter.)

Andries


