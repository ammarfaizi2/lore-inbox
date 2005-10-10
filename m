Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751249AbVJJVOj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751249AbVJJVOj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Oct 2005 17:14:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751247AbVJJVOj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Oct 2005 17:14:39 -0400
Received: from mx1.redhat.com ([66.187.233.31]:14982 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751246AbVJJVOi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Oct 2005 17:14:38 -0400
Date: Mon, 10 Oct 2005 16:14:29 -0500
From: David Teigland <teigland@redhat.com>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 11/16] GFS: mount and tuning options
Message-ID: <20051010211429.GA25691@redhat.com>
References: <20051010171052.GL22483@redhat.com> <20051010210108.GA13457@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051010210108.GA13457@kroah.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 10, 2005 at 02:01:08PM -0700, Greg KH wrote:
> On Mon, Oct 10, 2005 at 12:10:52PM -0500, David Teigland wrote:
> > +static ssize_t statfs_show(struct gfs2_sbd *sdp, char *buf)
> > +{
> > +	struct gfs2_statfs_change sc;
> > +	int rv;
> > +
> > +	if (gfs2_tune_get(sdp, gt_statfs_slow))
> > +		rv = gfs2_statfs_slow(sdp, &sc);
> > +	else
> > +		rv = gfs2_statfs_i(sdp, &sc);
> > +
> > +	if (rv)
> > +		goto out;
> > +
> > +	rv += sprintf(buf + rv, "bsize %u\n", sdp->sd_sb.sb_bsize);
> > +	rv += sprintf(buf + rv, "total %lld\n", sc.sc_total);
> > +	rv += sprintf(buf + rv, "free %lld\n", sc.sc_free);
> > +	rv += sprintf(buf + rv, "dinodes %lld\n", sc.sc_dinodes);
> 
> No, 1 value per sysfs file please.

I'm aware of that rule and have followed it everywhere else.  This is a
special case where the one statfs produces three results.

> > +/* FIXME: this should go under fs_subsys, /sys/fs/ */
> 
> Then put it there, there is a patch floating around that creates
> /sys/fs/ but I haven't applied it as I need a user for it before I do.
> Feel free to add that patch to your patch series.

OK, in the meantime, here it is:
  http://marc.theaimsgroup.com/?l=linux-fsdevel&m=112548673418028&w=2

Dave

