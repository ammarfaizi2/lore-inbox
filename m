Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262486AbSI2OZC>; Sun, 29 Sep 2002 10:25:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262488AbSI2OZB>; Sun, 29 Sep 2002 10:25:01 -0400
Received: from bitchcake.off.net ([216.138.242.5]:26023 "EHLO mail.off.net")
	by vger.kernel.org with ESMTP id <S262486AbSI2OZB>;
	Sun, 29 Sep 2002 10:25:01 -0400
Date: Sun, 29 Sep 2002 10:30:24 -0400
From: Zach Brown <zab@zabbo.net>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.39 list_head debugging
Message-ID: <20020929103024.B13755@bitchcake.off.net>
References: <20020929015852.K13817@bitchcake.off.net> <Pine.LNX.4.44.0209291027120.12583-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0209291027120.12583-100000@localhost.localdomain>; from mingo@elte.hu on Sun, Sep 29, 2002 at 10:33:15AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > This patch adds some straight-forward assertions that check the
> > validity of arguments to the list_* inlines. [...]
> 
> +	BUG_ON(list == NULL);
> +	BUG_ON(list->next == NULL);
> +	BUG_ON(list->prev == NULL);

oh, sorry, I'm reminded that list->next == NULL check is indeed needed.
list_empty(list) will fail when the elements are null (list->NULL !=
list) but the entry isn't on any lists.  

so we can lose the first check, sure, it was just cute, but I'd like to
keep checking for null member pointers.  They already found a bug in
vmscan.c where list_empty(mapping->blahblah) was failing for the swapper
mapping even though it was on no lists.  (harmless?  perhaps, but not
the symantics list_head is trying to provide)

- z
