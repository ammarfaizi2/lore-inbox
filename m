Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030563AbVKDASS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030563AbVKDASS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 19:18:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030560AbVKDASS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 19:18:18 -0500
Received: from ylpvm15-ext.prodigy.net ([207.115.57.46]:27541 "EHLO
	ylpvm15.prodigy.net") by vger.kernel.org with ESMTP
	id S1030563AbVKDASQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 19:18:16 -0500
X-ORBL: [69.149.117.103]
Date: Thu, 3 Nov 2005 18:14:09 -0600
From: Michael Halcrow <lkml@halcrow.us>
To: James Morris <jmorris@namei.org>
Cc: Phillip Hellewell <phillip@hellewell.homeip.net>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       mike@halcrow.us, mhalcrow@us.ibm.com, mcthomps@us.ibm.com,
       yoder1@us.ibm.com
Subject: Re: [PATCH 12/12: eCryptfs] Crypto functions
Message-ID: <20051104001409.GB21628@halcrow.us>
Reply-To: Michael Halcrow <lkml@halcrow.us>
References: <20051103033220.GD2772@sshock.rn.byu.edu> <20051103035659.GL3005@sshock.rn.byu.edu> <Pine.LNX.4.63.0511031902570.22256@excalibur.intercode>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0511031902570.22256@excalibur.intercode>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 03, 2005 at 07:08:46PM -0500, James Morris wrote:
> > +	if (likely(1 == crypt_stats->encrypted)) {
> > +		if (!crypt_stats->key_valid) {
> > +			ecryptfs_printk(1, KERN_NOTICE, "Key is "
> > +					"invalid; bailing out\n");
> > +			rc = -EINVAL;
> > +			goto out;
> > +		}
> > +	} else {
> > +		rc = -EINVAL;
> > +		ecryptfs_printk(0, KERN_WARNING,
> > +				"Called with crypt_stats->encrypted == 0\n");
> > +		goto out;
> > +	}
> 
> What's going on here?  Is (crypt_stats->encrypted != 1) a kernel
> bug?

If ecryptfs_write_headers() is ever called on an unencrypted file,
then that is a programming error in eCryptfs. This will need to be
replaced with a BUG_ON().

Mike
