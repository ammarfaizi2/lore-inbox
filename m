Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261443AbSI2ROB>; Sun, 29 Sep 2002 13:14:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261446AbSI2ROB>; Sun, 29 Sep 2002 13:14:01 -0400
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:901 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S261443AbSI2ROA>;
	Sun, 29 Sep 2002 13:14:00 -0400
Date: Sun, 29 Sep 2002 18:22:47 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Zach Brown <zab@zabbo.net>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.39 list_head debugging
Message-ID: <20020929172247.GA23543@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Zach Brown <zab@zabbo.net>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org
References: <20020929015852.K13817@bitchcake.off.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020929015852.K13817@bitchcake.off.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 29, 2002 at 01:58:52AM -0400, Zach Brown wrote:
 > +static inline struct list_head * __list_valid(struct list_head *list)
 > +{
 > +	BUG_ON(list == NULL);
 > +	BUG_ON(list->next == NULL);
 > +	BUG_ON(list->prev == NULL);
 > +	BUG_ON(list->next->prev != list);
 > +	BUG_ON(list->prev->next != list);
 > +	BUG_ON((list->next == list) && (list->prev != list));
 > +	BUG_ON((list->prev == list) && (list->next != list));
 > +
 > +	return list;
 > +}
 > +#else 
 > +
 > +#define __list_valid(args...)
 > +
 > +#endif

Two points (both related to return type).
1, why is it needed ? none of the macros seems to check it.
2, will this work for the #define __list_valid(args...) case ?


		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
