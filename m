Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932351AbWGRSoO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932351AbWGRSoO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 14:44:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932352AbWGRSoO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 14:44:14 -0400
Received: from liaag2ag.mx.compuserve.com ([149.174.40.158]:55692 "EHLO
	liaag2ag.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S932351AbWGRSoN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 14:44:13 -0400
Date: Tue, 18 Jul 2006 14:39:33 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [RFC PATCH 06/33] Add Xen interface header files
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Christian Limpach <Christian.Limpach@cl.cam.ac.uk>,
       Chris Wright <chrisw@sous-sol.org>,
       virtualization <virtualization@lists.osdl.org>,
       Xen-devel <xen-devel@lists.xensource.com>,
       Jeremy Fitzhardinge <jeremy@goop.org>, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>, Rusty Russell <rusty@rustcorp.com.au>,
       Zachary Amsden <zach@vmware.com>, Ian Pratt <Ian.Pratt@xensource.com>
Message-ID: <200607181441_MC3-1-C556-4414@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <20060718091950.075712000@sous-sol.org>

On Tue, 18 Jul 2006 00:00:06 -0700, Chris Wright wrote:
>
> Add Xen interface header files.

> --- /dev/null Thu Jan 01 00:00:00 1970 +0000
> +++ b/include/xen/interface/arch-x86_32.h     Thu Jun 08 19:24:13 2006 -0400

> +#define FIRST_RESERVED_GDT_PAGE  14
> +#define FIRST_RESERVED_GDT_BYTE  (FIRST_RESERVED_GDT_PAGE * 4096)
> +#define FIRST_RESERVED_GDT_ENTRY (FIRST_RESERVED_GDT_BYTE / 8)

== 7168

> +
> +/*
> + * These flat segments are in the Xen-private section of every GDT. Since these
> + * are also present in the initial GDT, many OSes will be able to avoid
> + * installing their own GDT.
> + */
> +#define FLAT_RING1_CS 0xe019    /* GDT index 259 */
> +#define FLAT_RING1_DS 0xe021    /* GDT index 260 */
> +#define FLAT_RING1_SS 0xe021    /* GDT index 260 */
> +#define FLAT_RING3_CS 0xe02b    /* GDT index 261 */
> +#define FLAT_RING3_DS 0xe033    /* GDT index 262 */
> +#define FLAT_RING3_SS 0xe033    /* GDT index 262 */

Umm, these definitions are magic hardcoded constants that really refer
to indexes 7171 through 7174.

How about this instead?

+#define FLAT_RING1_CS (((FIRST_RESERVED_GDT_ENTRY + 3) << 3) | 1)
+#define FLAT_RING1_DS (((FIRST_RESERVED_GDT_ENTRY + 4) << 3) | 1)
+#define FLAT_RING1_SS FLAT_RING1_DS
+#define FLAT_RING3_CS (((FIRST_RESERVED_GDT_ENTRY + 5) << 3) | 3)
+#define FLAT_RING3_DS (((FIRST_RESERVED_GDT_ENTRY + 6) << 3) | 3)
+#define FLAT_RING3_SS FLAT_RING3_DS

-- 
Chuck
And did we tell you the name of the game, boy, we call it Riding the Gravy Train.
