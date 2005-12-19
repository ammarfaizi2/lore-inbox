Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964850AbVLSVkg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964850AbVLSVkg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 16:40:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932356AbVLSVkg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 16:40:36 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:29876 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932296AbVLSVkf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 16:40:35 -0500
Date: Mon, 19 Dec 2005 15:40:19 -0600
From: Robin Holt <holt@sgi.com>
To: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org, rth@redhat.com,
       bj0rn@blox.se
Subject: Can somebody with flex/bison experience help with genksyms?
Message-ID: <20051219214019.GA25888@lnx-holt.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following code fails to generate a crc when run through genksyms.

#include <linux/module.h>

struct nodepda_s {
	int	z1, z2;
}

DEFINE_PER_CPU(struct nodepda_s *, __sn_nodepda);
EXPORT_PER_CPU_SYMBOL(__sn_nodepda);

While the following works:

#include <linux/module.h>

struct nodepda_s {
        int     z1, z2;
}

typedef struct nodepda_s * nodepda_s_p;

DEFINE_PER_CPU(nodepda_s_p, __sn_nodepda);
EXPORT_PER_CPU_SYMBOL(__sn_nodepda);



This appears to be due to the way STRUCT_KEYW is handled in parse.y as
compared to TYPEOF_KEYW.  I know nothing about flex and bison.  I am
just trolling for anybody willing to help.  I believe the STRUCT_KEYW
handling would need to consume the *, but am not sure how that is
conditionally done.

Thanks,
Robin Holt
