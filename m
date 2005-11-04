Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030557AbVKDAMZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030557AbVKDAMZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 19:12:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030559AbVKDAMZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 19:12:25 -0500
Received: from ylpvm12-ext.prodigy.net ([207.115.57.43]:31137 "EHLO
	ylpvm12.prodigy.net") by vger.kernel.org with ESMTP
	id S1030557AbVKDAMY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 19:12:24 -0500
X-ORBL: [69.149.117.103]
Date: Thu, 3 Nov 2005 18:08:30 -0600
From: Michael Halcrow <lkml@halcrow.us>
To: James Morris <jmorris@namei.org>
Cc: Phillip Hellewell <phillip@hellewell.homeip.net>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       mhalcrow@us.ibm.com, mcthomps@us.ibm.com, yoder1@us.ibm.com
Subject: Re: [PATCH 11/12: eCryptfs] Keystore
Message-ID: <20051104000830.GA21628@halcrow.us>
Reply-To: Michael Halcrow <lkml@halcrow.us>
References: <20051103033220.GD2772@sshock.rn.byu.edu> <20051103035611.GK3005@sshock.rn.byu.edu> <Pine.LNX.4.63.0511031856050.22256@excalibur.intercode>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0511031856050.22256@excalibur.intercode>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 03, 2005 at 06:59:42PM -0500, James Morris wrote:
> On Wed, 2 Nov 2005, Phillip Hellewell wrote:
> 
> > +	password_s_ptr = &auth_tok->token.password;
> > +	if (password_s_ptr->session_key_encryption_key_set) {
> > +		ecryptfs_printk(1, KERN_NOTICE, "Session key encryption key "
> > +				"set; skipping key generation\n");
> > +		goto session_key_encryption_key_set;
> > +	}
> > +      session_key_encryption_key_set:
> > +	ecryptfs_printk(1, KERN_NOTICE, "Session key encryption key (size [%d])"
> > +			":\n", password_s_ptr->session_key_encryption_key_size);
> 
> Spurious goto?

Yes, that was an artifact caused from the deletion of a block of code
that we decided to postpone for a future release of eCryptfs
(in-kernel session key encryption key generation, to be exact...).

> > +out:
> > +	if (tfm)
> > +		crypto_free_tfm(tfm);
> > +	return rc;
> 
> Just call crypto_free_tfm() unconditionally.

Yes, and it looks like the check for the failure condition on tfm
alloc did not get make it into this release either:

+        tfm = crypto_alloc_tfm(crypt_stats->cipher, 0);
+        crypto_cipher_setkey(tfm, password_s_ptr->session_key_encryption_key,
+                             password_s_ptr->session_key_encryption_key_size);

We'll be sure that those fixes are included in the next round of
updates.

Thanks,
Mike
