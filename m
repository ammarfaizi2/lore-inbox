Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964997AbVITM2d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964997AbVITM2d (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 08:28:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964995AbVITM2d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 08:28:33 -0400
Received: from pat.uio.no ([129.240.130.16]:57305 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S964994AbVITM2b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 08:28:31 -0400
Subject: Re: ctime set by truncate even if NOCMTIME requested
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: smfrench@austin.rr.com, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <E1EHh6U-0001Hp-00@dorka.pomaz.szeredi.hu>
References: <432EFAB1.4080406@austin.rr.com>
	 <1127156303.8519.29.camel@lade.trondhjem.org>
	 <432F2684.4040300@austin.rr.com>
	 <1127165311.8519.39.camel@lade.trondhjem.org>
	 <432F5968.1020106@austin.rr.com>
	 <1127180199.26459.17.camel@lade.trondhjem.org>
	 <E1EHdrk-00014N-00@dorka.pomaz.szeredi.hu>
	 <E1EHf0E-000197-00@dorka.pomaz.szeredi.hu>
	 <1127218345.8413.32.camel@lade.trondhjem.org>
	 <E1EHh6U-0001Hp-00@dorka.pomaz.szeredi.hu>
Content-Type: text/plain
Date: Tue, 20 Sep 2005 08:27:57 -0400
Message-Id: <1127219277.11420.0.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-2.678, required 12,
	autolearn=disabled, AWL 2.13, FORGED_RCVD_HELO 0.05,
	RCVD_IN_SORBS_DUL 0.14, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ty den 20.09.2005 Klokka 14:20 (+0200) skreiv Miklos Szeredi:
> > > ATTR_MTIME is _only_ set in utime[s], which all filesystems want to
> > > honor.
> > 
> > ATTR_MTIME is set in both utimes and truncate.
> 
> Not in truncate:
> 
> int do_truncate(struct dentry *dentry, loff_t length)
> {
> 	/* ... */
> 
> 	newattrs.ia_size = length;
> 	newattrs.ia_valid = ATTR_SIZE | ATTR_CTIME;
> 
> 	down(&dentry->d_inode->i_sem);
> 	err = notify_change(dentry, &newattrs);
> 	up(&dentry->d_inode->i_sem);
> 	return err;
> }

Oops. You're right. That is a recent change that I missed...

Cheers,
  Trond

