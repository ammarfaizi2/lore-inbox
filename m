Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266850AbUHCVIF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266850AbUHCVIF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 17:08:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266854AbUHCVIF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 17:08:05 -0400
Received: from mail-relay-3.tiscali.it ([213.205.33.43]:47795 "EHLO
	mail-relay-3.tiscali.it") by vger.kernel.org with ESMTP
	id S266850AbUHCVIC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 17:08:02 -0400
Date: Tue, 3 Aug 2004 23:07:37 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Rik van Riel <riel@redhat.com>
Cc: Chris Wright <chrisw@osdl.org>, Arjan van de Ven <arjanv@redhat.com>,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [patch] mlock-as-nonroot revisted
Message-ID: <20040803210737.GI2241@dualathlon.random>
References: <20040729185215.Q1973@build.pdx.osdl.net> <Pine.LNX.4.44.0408031654290.5948-100000@dhcp83-102.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0408031654290.5948-100000@dhcp83-102.boston.redhat.com>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 03, 2004 at 04:55:49PM -0400, Rik van Riel wrote:
> @@ -198,9 +201,11 @@
>  		return error;
>  	}
>  
> -	if (shmflg & SHM_HUGETLB)
> +	if (shmflg & SHM_HUGETLB) {
> +		/* hugetlb_zero_setup takes care of mlock user accounting */
>  		file = hugetlb_zero_setup(size);
> -	else {
> +		shp->mlock_user = current->user;
> +	} else {
>  		sprintf (name, "SYSV%08x", key);
>  		file = shmem_file_setup(name, size, VM_ACCOUNT);
>  	}

where do you change mlock_user in chown?
