Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965063AbWD0MJz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965063AbWD0MJz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 08:09:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965064AbWD0MJz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 08:09:55 -0400
Received: from wohnheim.fh-wedel.de ([213.39.233.138]:1253 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S965063AbWD0MJy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 08:09:54 -0400
Date: Thu, 27 Apr 2006 14:09:51 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Heiko J Schick <schihei@de.ibm.com>
Cc: openib-general@openib.org, Christoph Raisch <RAISCH@de.ibm.com>,
       Hoang-Nam Nguyen <HNGUYEN@de.ibm.com>, Marcus Eder <MEDER@de.ibm.com>,
       linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 02/16] ehca: module infrastructure
Message-ID: <20060427120951.GE32127@wohnheim.fh-wedel.de>
References: <4450A165.4000701@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4450A165.4000701@de.ibm.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 April 2006 12:48:05 +0200, Heiko J Schick wrote:
>
> +	if (ehca_module->cache_pd == NULL) {

Hmm.

> +	ret = kmem_cache_destroy(ehca_module->cache_pd);
> +	if (ret != 0)

The " != 0" is completely superfluous.  Above NULL check is a matter
of taste, this one demonstates lack of boolean algebra understanding.

> +	rblock = kzalloc(H_CB_ALIGNMENT, GFP_KERNEL);
> +	if (!rblock) {

Hmm.  And your taste seems to change. :)

> +	if (ehca_hw_level == 0) {

And since we're on the subject.  Ignoring the recent discussion
involving akpm, viro and others, the kernel historically used int both
for integer and boolean, plus return values as a special kind of
"boolean with error indication attached".

For boolean, it is nicer to do things like "if (!error)", for
integers, a comparison as above is nicer.  Return codes fall into the
boolean category.  Pointers after kmalloc() and similar are viewed as
rich boolean by some people, but not by all.

Jörn

-- 
Geld macht nicht glücklich.
Glück macht nicht satt.
