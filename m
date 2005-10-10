Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751237AbVJJVCU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751237AbVJJVCU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Oct 2005 17:02:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751238AbVJJVCT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Oct 2005 17:02:19 -0400
Received: from mail.kroah.org ([69.55.234.183]:23691 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751237AbVJJVCS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Oct 2005 17:02:18 -0400
Date: Mon, 10 Oct 2005 14:01:08 -0700
From: Greg KH <greg@kroah.com>
To: David Teigland <teigland@redhat.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 11/16] GFS: mount and tuning options
Message-ID: <20051010210108.GA13457@kroah.com>
References: <20051010171052.GL22483@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051010171052.GL22483@redhat.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 10, 2005 at 12:10:52PM -0500, David Teigland wrote:
> +static ssize_t statfs_show(struct gfs2_sbd *sdp, char *buf)
> +{
> +	struct gfs2_statfs_change sc;
> +	int rv;
> +
> +	if (gfs2_tune_get(sdp, gt_statfs_slow))
> +		rv = gfs2_statfs_slow(sdp, &sc);
> +	else
> +		rv = gfs2_statfs_i(sdp, &sc);
> +
> +	if (rv)
> +		goto out;
> +
> +	rv += sprintf(buf + rv, "bsize %u\n", sdp->sd_sb.sb_bsize);
> +	rv += sprintf(buf + rv, "total %lld\n", sc.sc_total);
> +	rv += sprintf(buf + rv, "free %lld\n", sc.sc_free);
> +	rv += sprintf(buf + rv, "dinodes %lld\n", sc.sc_dinodes);

No, 1 value per sysfs file please.

> +/* FIXME: this should go under fs_subsys, /sys/fs/ */

Then put it there, there is a patch floating around that creates
/sys/fs/ but I haven't applied it as I need a user for it before I do.
Feel free to add that patch to your patch series.

thanks,

greg k-h
