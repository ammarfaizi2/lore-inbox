Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264503AbUHNSYj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264503AbUHNSYj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Aug 2004 14:24:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264500AbUHNSYj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Aug 2004 14:24:39 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:50091 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S264444AbUHNSYg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Aug 2004 14:24:36 -0400
Date: Sat, 14 Aug 2004 20:20:27 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: James Morris <jmorris@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, Stephen Smalley <sds@epoch.ncsc.mil>,
       neilb@cse.unsw.edu.au, viro@parcelfarce.linux.theplanet.co.uk,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH][LIBFS] Move transaction file ops into libfs + cleanup (update)
Message-ID: <20040814182027.GA23293@electric-eye.fr.zoreil.com>
References: <Xine.LNX.4.44.0408131157350.23262-100000@dhcp83-76.boston.redhat.com> <Xine.LNX.4.44.0408141231300.27007-100000@dhcp83-76.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Xine.LNX.4.44.0408141231300.27007-100000@dhcp83-76.boston.redhat.com>
User-Agent: Mutt/1.4.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Morris <jmorris@redhat.com> :
[...]
> diff -urN -X dontdiff linux-2.6.8.1.o/include/linux/fs.h linux-2.6.8.1.w/include/linux/fs.h
> --- linux-2.6.8.1.o/include/linux/fs.h	2004-08-14 10:25:44.000000000 -0400
> +++ linux-2.6.8.1.w/include/linux/fs.h	2004-08-14 12:57:56.175796496 -0400
> @@ -1550,6 +1550,32 @@
[...]
> +static inline void simple_transaction_set(struct file *file, size_t n)
> +{
> +	struct simple_transaction_argresp *ar = file->private_data;
> +	
> +	BUG_ON(n > SIMPLE_TRANSACTION_LIMIT);
> +	mb();
> +	ar->size = n;
> +}

Could you add the justification for the 'mb' (or the expected effect on the
api) as a comment ?

--
Ueimor
