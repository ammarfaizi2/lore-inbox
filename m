Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751252AbVJJVVR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751252AbVJJVVR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Oct 2005 17:21:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751254AbVJJVVR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Oct 2005 17:21:17 -0400
Received: from mail.kroah.org ([69.55.234.183]:5779 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751251AbVJJVVQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Oct 2005 17:21:16 -0400
Date: Mon, 10 Oct 2005 14:19:18 -0700
From: Greg KH <greg@kroah.com>
To: David Teigland <teigland@redhat.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 11/16] GFS: mount and tuning options
Message-ID: <20051010211918.GA13920@kroah.com>
References: <20051010171052.GL22483@redhat.com> <20051010210108.GA13457@kroah.com> <20051010211429.GA25691@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051010211429.GA25691@redhat.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 10, 2005 at 04:14:29PM -0500, David Teigland wrote:
> On Mon, Oct 10, 2005 at 02:01:08PM -0700, Greg KH wrote:
> > On Mon, Oct 10, 2005 at 12:10:52PM -0500, David Teigland wrote:
> > > +static ssize_t statfs_show(struct gfs2_sbd *sdp, char *buf)
> > > +{
> > > +	struct gfs2_statfs_change sc;
> > > +	int rv;
> > > +
> > > +	if (gfs2_tune_get(sdp, gt_statfs_slow))
> > > +		rv = gfs2_statfs_slow(sdp, &sc);
> > > +	else
> > > +		rv = gfs2_statfs_i(sdp, &sc);
> > > +
> > > +	if (rv)
> > > +		goto out;
> > > +
> > > +	rv += sprintf(buf + rv, "bsize %u\n", sdp->sd_sb.sb_bsize);
> > > +	rv += sprintf(buf + rv, "total %lld\n", sc.sc_total);
> > > +	rv += sprintf(buf + rv, "free %lld\n", sc.sc_free);
> > > +	rv += sprintf(buf + rv, "dinodes %lld\n", sc.sc_dinodes);
> > 
> > No, 1 value per sysfs file please.
> 
> I'm aware of that rule and have followed it everywhere else.  This is a
> special case where the one statfs produces three results.

Then why not have 4 different files, for the result of the last "statfs"
command?

thanks,

greg k-h
