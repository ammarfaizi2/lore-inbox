Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031499AbWLGF5z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031499AbWLGF5z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 00:57:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031533AbWLGF5z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 00:57:55 -0500
Received: from smtp.osdl.org ([65.172.181.25]:51691 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1031499AbWLGF5y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 00:57:54 -0500
Date: Wed, 6 Dec 2006 21:57:48 -0800
From: Andrew Morton <akpm@osdl.org>
To: Michael Halcrow <mhalcrow@us.ibm.com>
Cc: LKML <linux-kernel@vger.kernel.org>, trevor.highland@gmail.com,
       tyhicks@ou.edu
Subject: Re: [PATCH 2/2] eCryptfs: Public key; packet management
Message-Id: <20061206215748.de51dc59.akpm@osdl.org>
In-Reply-To: <20061206231236.GB9358@us.ibm.com>
References: <20061206230638.GA9358@us.ibm.com>
	<20061206231236.GB9358@us.ibm.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Dec 2006 17:12:37 -0600
Michael Halcrow <mhalcrow@us.ibm.com> wrote:

> Public key support code. This reads and writes packets in the header
> that contain public key encrypted file keys. It calls the messaging
> code in the previous patch to send and receive encryption and
> decryption request packets from the userspace daemon.
> 
> ...
>
> +		memset(auth_tok_list_item, 0,
> +		       sizeof(struct ecryptfs_auth_tok_list_item));
> +		kmem_cache_free(ecryptfs_auth_tok_list_item_cache,
> +				auth_tok_list_item);
>
> ...
>
> +	memset(auth_tok_list_item, 0,
> +	       sizeof(struct ecryptfs_auth_tok_list_item));
> +	kmem_cache_free(ecryptfs_auth_tok_list_item_cache,
> +			auth_tok_list_item);

That's a bit wasteful of cycles.  Or is this done to minimise the exposure
of sensitive data?  If so, a comment would be in order.
