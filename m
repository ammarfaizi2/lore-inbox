Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262617AbTCRX5u>; Tue, 18 Mar 2003 18:57:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262649AbTCRX5u>; Tue, 18 Mar 2003 18:57:50 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:20744 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S262617AbTCRX5t>;
	Tue, 18 Mar 2003 18:57:49 -0500
Date: Tue, 18 Mar 2003 15:56:42 -0800
From: Greg KH <greg@kroah.com>
To: Andries.Brouwer@cwi.nl
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dev_t [2/3]
Message-ID: <20030318235642.GF10089@kroah.com>
References: <UTC200303182202.h2IM2Lx00966.aeb@smtp.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <UTC200303182202.h2IM2Lx00966.aeb@smtp.cwi.nl>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 18, 2003 at 11:02:21PM +0100, Andries.Brouwer@cwi.nl wrote:
> In order not to have to change all drivers, I did
> 
> +int register_chrdev(unsigned int major, const char *name,
> +                   struct file_operations *fops)
> +{
> +       return register_chrdev_region(major, 0, 256, name, fops);
> +}
> 
> so that the old register_chrdev registers a single major
> and 256 minors. Later this can be changed (but see my letter
> to Al last week).

This is nice, thanks.  We don't have to touch the char drivers now.

Ah, I wish we could change that function to be:
int register_chrdev_region(major, num_minors, name, fops)
if it wasn't for the tty drivers wanting to start their minor at 64.

Hm, wait, why can't we just do it that way and not change the tty core
to use the register_chrdev_region() call?  It should still all work
properly, right?  The tty core would ask for 256 minors, and split them
off the same way it currently does.

thanks,

greg k-h
