Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262611AbUCYBBv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 20:01:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262575AbUCYBBv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 20:01:51 -0500
Received: from ozlabs.org ([203.10.76.45]:43476 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262618AbUCYBBu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 20:01:50 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16482.12026.739450.257677@cargo.ozlabs.ibm.com>
Date: Thu, 25 Mar 2004 11:59:38 +1100
From: Paul Mackerras <paulus@samba.org>
To: trini@kernel.crashing.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [patch 3/22] __early_param for ppc
In-Reply-To: <20040324235747.NSKC2428.fed1mtao03.cox.net@localhost.localdomain>
References: <20040324235747.NSKC2428.fed1mtao03.cox.net@localhost.localdomain>
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

trini@kernel.crashing.org writes:

> -#ifdef CONFIG_XMON
> -	xmon_map_scc();
> -	if (strstr(cmd_line, "xmon"))
> -		xmon(0);
> -#endif /* CONFIG_XMON */
...
> +/* Allow us a hook to drop in early. */
> +static void __init early_xmon(char **ign)
> +{
> +	xmon_map_scc();
> +	xmon(0);
> +}
> +__early_param("xmon", early_xmon);

You have changed the behaviour here, in that now xmon_map_scc() only
gets called if you put xmon on the command line, whereas previously it
got called unconditionally (assuming CONFIG_XMON=y).  Did you check
whether this will cause problems?

Regards,
Paul.
