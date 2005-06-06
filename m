Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261500AbVFFSmi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261500AbVFFSmi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 14:42:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261523AbVFFSmi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 14:42:38 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:5072 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261500AbVFFSmf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 14:42:35 -0400
Date: Mon, 6 Jun 2005 13:42:13 -0500
From: Michael Halcrow <mhalcrow@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Phillip Hellewell <phillip@hellewell.homeip.net>,
       linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 2/3, 2.6.12-rc5-mm1] eCryptfs: export user key type
Message-ID: <20050606184212.GD7947@halcrow.us>
Reply-To: Michael Halcrow <mhalcrow@us.ibm.com>
References: <20050603200339.GA2445@halcrow.us> <20050602054852.GB4514@sshock.rn.byu.edu> <16336.1118050922@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16336.1118050922@redhat.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 06, 2005 at 10:42:02AM +0100, David Howells wrote:
> Michael Halcrow <mhalcrow@us.ibm.com> wrote:
> > > +EXPORT_SYMBOL( key_type_user );
> > 
> > This is the only modification necessary to support eCryptfs.
> 
> Unfortunately, that might have to be EXPORT_SYMBOL_GPL() nowadays
> since I reimplemented the predefined keyring types of user and
> keyring using RCU.

Noted; new patch included below.

> > While we are working on getting it ready for merging into the
> > mainline kernel, we would like to distribute it as a separate
> > kernel module, and we would like for users or distro's do not need
> > to modify their kernels to build and run it.
> 
> "It" being?

eCryptfs.

> > Would there be any objections to exporting the key_type_user
> > symbol?  Is there any general reason why kernel modules should not
> > have access to the user key type struct?
> 
> No and no, but see above. You could also export the user defined key
> type ops and define your own key type using them.

I can imagine scenarios where new kernel modules make use some
universal key type (i.e., without userspace apps having to be aware of
a special keytype).  The ``user'' key type seems like a good candidate
for that.

Signed off by: Michael Halcrow <mhalcrow@us.ibm.com>

--- linux-2.6.12-rc5-mm1/security/keys/user_defined.c	2005-05-28 17:18:52.000000000 -0500
+++ linux-2.6.12-rc5-mm1-ecryptfs/security/keys/user_defined.c	2005-06-06 13:26:58.757403080 -0500
@@ -48,6 +48,8 @@
 	char		data[0];	/* actual data */
 };
 
+EXPORT_SYMBOL_GPL(key_type_user);
+
 /*****************************************************************************/
 /*
  * instantiate a user defined key
