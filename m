Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262582AbTCITZr>; Sun, 9 Mar 2003 14:25:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262580AbTCITZl>; Sun, 9 Mar 2003 14:25:41 -0500
Received: from deviant.impure.org.uk ([195.82.120.238]:16605 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id <S262579AbTCITZi>; Sun, 9 Mar 2003 14:25:38 -0500
Date: Sun, 9 Mar 2003 19:33:59 -0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Fwd: struct inode size reduction.
Message-ID: <20030309203359.GA7276@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Andries Brouwer <aebr@win.tue.nl>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20030309135402.GB32107@suse.de> <20030309171314.GA3783@win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030309171314.GA3783@win.tue.nl>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 09, 2003 at 06:13:14PM +0100, Andries Brouwer wrote:

 > > -	/* These three should probably be a union */
 > >  	struct list_head	i_devices;
 > > -	struct pipe_inode_info	*i_pipe;
 > > -	struct block_device	*i_bdev;
 > > -	struct char_device	*i_cdev;
 > > -
 > > +	union {
 > > +		struct pipe_inode_info	*i_pipe;
 > > +		struct block_device	*i_bdev;
 > > +		struct char_device	*i_cdev;
 > > +	} type;
 > 
 > Not really any objection, but this is half work where
 > more can be done. The comment is right: also i_devices
 > can go into the union.

The different size types threw me, and I figured it
was a misplaced comment. It certainly made more sense
that way when it mentioned 'these three' rather than
'these four'.  looking at bd_acquire I'm not so sure
it's as simple a job as the other three were.

 > (And i_cdev can be deleted altogether, but that is an
 > independent matter.)

There still seems to be some users of that, so I'll
leave that to a follow up patch, (or someone else who
really knows whats going on there).

		Dave

