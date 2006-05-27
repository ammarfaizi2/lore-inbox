Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751431AbWE0HCm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751431AbWE0HCm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 May 2006 03:02:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751432AbWE0HCm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 May 2006 03:02:42 -0400
Received: from smtp.ustc.edu.cn ([202.38.64.16]:64465 "HELO ustc.edu.cn")
	by vger.kernel.org with SMTP id S1751431AbWE0HCl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 May 2006 03:02:41 -0400
Message-ID: <348713356.18117@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Date: Sat, 27 May 2006 15:02:48 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 14/33] readahead: state based method - data structure
Message-ID: <20060527070248.GD4991@mail.ustc.edu.cn>
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

Sorry, the lower 8 bits are for ra_class values in the new code. It can
cause data corruption when dynamic switching between the two logics :(

I'd like to change the flags member to explicit ones like

        struct {
                unsigned miss           :1;
                unsigned incache        :1;
                unsigned mmap           :1;
                unsigned no_lookahead   :1;
                unsigned eof            :1;
        } flags;

        unsigned class_new              :4;
        unsigned class_old              :4;

Reasonable?
