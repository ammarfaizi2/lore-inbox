Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751222AbWJMGyL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751222AbWJMGyL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 02:54:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751233AbWJMGyL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 02:54:11 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:49295 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751222AbWJMGyK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 02:54:10 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=MfmNl5OaqMtEx7MOKiw6vInO9UqimCwbsYK4SkY5CmmUX2JQPk0bp0q1k7tuclU9B2oRF/1+f8CUXDMmv0Wrnsshytd/rZsakoGu8WZva9k1XTiU9/MoCI6LACHIpKw5g9d6ekSbyj32qSPFghWyLjoVRGXHtPf1eJ1DiN2o8qs=
Message-ID: <84144f020610122354s3f217a7fh1500f82da25f4739@mail.gmail.com>
Date: Fri, 13 Oct 2006 09:54:09 +0300
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: [PATCH 00 of 23][-mm] Unionfs: Stackable Namespace Unification Filesystem
Cc: "Josef Jeff Sipek" <jsipek@cs.sunysb.edu>, linux-kernel@vger.kernel.org
In-Reply-To: <20061012135428.024d0d33.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <patchbomb.1160633917@thor.fsl.cs.sunysb.edu>
	 <20061012135428.024d0d33.akpm@osdl.org>
X-Google-Sender-Auth: 674319e977bfad44
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/12/06, Andrew Morton <akpm@osdl.org> wrote:
> Meanwhile, from a quick scan I'd say that unionfs is much, much too lightly
> commented for a review to be particularly effective.   Please work on that.

Could use some basic coding style fixes too.

- Move assignments outside of if statement expression "if (err = foo_bar())"
- No C99-style comments "//"
- Use struct kmem_cache instead of the deprecated kmem_cache_t
- Don't use function-like macros as the left hand side of assignment
expression "itohi_ptr(inode) = kzalloc(size, GFP_KERNEL);". It's much
better to open-code the assignment or introduce a setter function
(e.g. inode_set_hiptr).
- Kill wrappers (e.g. unionfs_kill_block_super can be replaced with
generic_shutdown_super)

                                                  Pekka
