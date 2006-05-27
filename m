Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751149AbWE0I1v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751149AbWE0I1v (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 May 2006 04:27:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751443AbWE0I1v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 May 2006 04:27:51 -0400
Received: from smtp.ustc.edu.cn ([202.38.64.16]:28904 "HELO ustc.edu.cn")
	by vger.kernel.org with SMTP id S1751149AbWE0I1u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 May 2006 04:27:50 -0400
Message-ID: <348718466.19693@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Date: Sat, 27 May 2006 16:27:58 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 14/33] readahead: state based method - data structure
Message-ID: <20060527082758.GF4991@mail.ustc.edu.cn>
Mail-Followup-To: Wu Fengguang <wfg@mail.ustc.edu.cn>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20060524111246.420010595@localhost.localdomain> <348469542.39504@ustc.edu.cn> <20060526100552.17edbf90.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060526100552.17edbf90.akpm@osdl.org>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 26, 2006 at 10:05:52AM -0700, Andrew Morton wrote:
> Wu Fengguang <wfg@mail.ustc.edu.cn> wrote:
> >
> >  #define RA_FLAG_MISS 0x01	/* a cache miss occured against this file */
> >   #define RA_FLAG_INCACHE 0x02	/* file is already in cache */
> >  +#define RA_FLAG_MMAP		(1UL<<31)	/* mmaped page access */
> >  +#define RA_FLAG_NO_LOOKAHEAD	(1UL<<30)	/* disable look-ahead */
> >  +#define RA_FLAG_EOF		(1UL<<29)	/* readahead hits EOF */
> 
> Odd.  Why not use 4, 8, 16?

I'm now settled with:

-#define RA_FLAG_MISS 0x01      /* a cache miss occured against this file */
-#define RA_FLAG_INCACHE 0x02   /* file is already in cache */
+#define RA_FLAG_MISS   (1UL<<31) /* a cache miss occured against this file */
+#define RA_FLAG_INCACHE        (1UL<<30) /* file is already in cache */
+#define RA_FLAG_MMAP           (1UL<<29) /* mmaped page access */
+#define RA_FLAG_NO_LOOKAHEAD   (1UL<<28) /* disable look-ahead */
+#define RA_FLAG_EOF            (1UL<<27) /* readahead hits EOF */

And still let the low bits hold ra_class values.
