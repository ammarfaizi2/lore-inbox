Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751088AbWGDGTV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751088AbWGDGTV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 02:19:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751186AbWGDGTV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 02:19:21 -0400
Received: from mtagate3.uk.ibm.com ([195.212.29.136]:23417 "EHLO
	mtagate3.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1751088AbWGDGTU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 02:19:20 -0400
Date: Tue, 4 Jul 2006 08:17:54 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Martin Peschke <mp3@de.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, clg@fr.ibm.com,
       linux-kernel@vger.kernel.org
Subject: Re: [Patch] statistics infrastructure - update 9
Message-ID: <20060704061754.GB9417@osiris.boeblingen.de.ibm.com>
References: <1151943862.2936.10.camel@dyn-9-152-230-71.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1151943862.2936.10.camel@dyn-9-152-230-71.boeblingen.de.ibm.com>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +#else /* !CONFIG_STATISTICS */
> +/* These NOP functions unburden clients from handling !CONFIG_STATISTICS. */
> +
> +static inline int statistic_create(struct statistic_interface *interface,
> +				   const char *name)
> +{
> +	return 0;
> +}
> +
> +static inline int statistic_remove(struct statistic_interface *interface)
> +{
> +	return 0;
> +}
> +
> +static inline void statistic_set(struct statistic *stat, int i,
> +				 s64 value, u64 total)
> +{
> +}
> +
> +static inline void _statistic_add(struct statistic *stat, int i,
> +				  s64 value, u64 incr)
> +{
> +}
> +
> +static inline void statistic_add(struct statistic *stat, int i,
> +				 s64 value, u64 incr)
> +{
> +}
> +
> +static inline void _statistic_add_as(int type, struct statistic *stat, int i,
> +				     s64 value, u64 incr)
> +{
> +}
> +
> +static inline void statistic_add_as(int type, struct statistic *stat, int i,
> +				    s64 value, u64 incr)
> +{
> +}
> +
> +#endif /* CONFIG_STATISTICS */

Why not have something like:

#define statistic_create(interface, name) 	({ 0; })
#define statistic_remove(interface)		({ 0; })
#define statistic_set(stat, i, value, total)	do { } while (0)
...

That would be much shorter and easier to read. But maybe it's just me :)
