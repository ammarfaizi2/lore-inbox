Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271141AbTG1WHG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 18:07:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271146AbTG1WHF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 18:07:05 -0400
Received: from CPE-65-29-19-166.mn.rr.com ([65.29.19.166]:42882 "EHLO
	www.enodev.com") by vger.kernel.org with ESMTP id S271141AbTG1WHB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 18:07:01 -0400
Subject: Re: 2.6.0-test2-mm1: Can't mount root
From: Shawn <core@enodev.com>
To: Andrew Morton <akpm@osdl.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <20030728144704.49c433bc.akpm@osdl.org>
References: <1059428584.6146.9.camel@localhost>
	 <20030728144704.49c433bc.akpm@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1059430015.6146.15.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 28 Jul 2003 17:06:55 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you, I didn't look very closely at the patch (really at all). 

The one thing making me think I had it right with "2105" was that the
kernel did seem to grok it as (33,5).

On Mon, 2003-07-28 at 16:47, Andrew Morton wrote:
> Shawn <core@enodev.com> wrote:
> >
> > I'm using ide=reverse, and my root is on hde5. 2.6.0-test1-mm2 finds my
> > root fs fine using the init/do_mounts.c patch posted recently.
> > 
> > 2.6.0-test2-mm1 (in which said patch seems to have been included),
> > however, fails on all of the following root= options:
> >       * 2105
> >       * /dev/ide/host2/bus0/target0/lun0/part5
> >       * /dev/hde5
> > 
> > I don't know what to try next. Can someone enlighten me as to what has
> > been happening lately?
> 
> Beats me.  Tried "/dev/hde/5" and "21:05"?
> 
> Can you see what this says?
> 
>  25-akpm/init/do_mounts.c |    1 +
>  1 files changed, 1 insertion(+)
> 
> diff -puN init/do_mounts.c~a init/do_mounts.c
> --- 25/init/do_mounts.c~a	Mon Jul 28 14:44:37 2003
> +++ 25-akpm/init/do_mounts.c	Mon Jul 28 14:44:53 2003
> @@ -74,6 +74,7 @@ static dev_t __init try_name(char *name,
>  	/*
>  	 * The format of dev is now %u:%u -- see print_dev_t()
>  	 */
> +	printk("scanning `%s'\n", buf);
>  	if (sscanf(buf, "%u:%u", &maj, &min) == 2)
>  		res = MKDEV(maj, min);
>  	else
> 
> _
> 
> Also take a close look at the dmesg output, make sure that all the devices
> and partitions are appearing in the expected places.
> 
> 
