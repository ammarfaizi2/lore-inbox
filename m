Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262122AbSJNSH5>; Mon, 14 Oct 2002 14:07:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262123AbSJNSH5>; Mon, 14 Oct 2002 14:07:57 -0400
Received: from inet-mail1.oracle.com ([148.87.2.201]:48116 "EHLO
	inet-mail1.oracle.com") by vger.kernel.org with ESMTP
	id <S262122AbSJNSHy>; Mon, 14 Oct 2002 14:07:54 -0400
Date: Mon, 14 Oct 2002 11:13:38 -0700
From: Joel Becker <Joel.Becker@oracle.com>
To: Jens Axboe <axboe@suse.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       "Stephen C. Tweedie" <sct@redhat.com>
Subject: Re: [PATCH] superbh, fractured blocks, and grouped io
Message-ID: <20021014181338.GF22117@nic1-pc.us.oracle.com>
References: <20021014135100.GD28283@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021014135100.GD28283@suse.de>
User-Agent: Mutt/1.4i
X-Burt-Line: Trees are cool.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 14, 2002 at 03:51:00PM +0200, Jens Axboe wrote:

	Just a couple niggles, really.  Looking good.

>  	/*
> -	 * First step, 'identity mapping' - RAID or LVM might
> -	 * further remap this.
> +	 * detach each bh and resubmit, or completely and if its a grouped bh
>  	 */

	The last line of the comment means "completely fail if its
grouped", right?

> +#define MAX_SUPERBH 65535	/* must fit info ->b_size right now */

	Why not sizeof(b_size) in case we ever care?

> +extern int submit_bh_linked(int, struct buffer_head *);
> +extern int submit_bh_grouped(int, struct buffer_head *);

	Why aren't these EXPORT_SYMBOL(), given that a third party
driver may wish to use them (eg, a filesystem doing its own O_DIRECT
work)?

Joel

-- 

"We'd better get back, `cause it'll be dark soon,
 and they mostly come at night.  Mostly."

Joel Becker
Senior Member of Technical Staff
Oracle Corporation
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
