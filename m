Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262416AbSI2ITm>; Sun, 29 Sep 2002 04:19:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262421AbSI2ITl>; Sun, 29 Sep 2002 04:19:41 -0400
Received: from mx1.elte.hu ([157.181.1.137]:15778 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S262416AbSI2ITk>;
	Sun, 29 Sep 2002 04:19:40 -0400
Date: Sun, 29 Sep 2002 10:33:15 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Zach Brown <zab@zabbo.net>
Cc: Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.39 list_head debugging
In-Reply-To: <20020929015852.K13817@bitchcake.off.net>
Message-ID: <Pine.LNX.4.44.0209291027120.12583-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> This patch adds some straight-forward assertions that check the
> validity of arguments to the list_* inlines. [...]

+	BUG_ON(list == NULL);
+	BUG_ON(list->next == NULL);
+	BUG_ON(list->prev == NULL);

these checks are not needed - they'll trivially be oopsing when trying to
use them, right?

+	BUG_ON(list->next->prev != list);
+	BUG_ON(list->prev->next != list);

these two are indeed nice to have.

+	BUG_ON((list->next == list) && (list->prev != list));
+	BUG_ON((list->prev == list) && (list->next != list));

arent these redundant? If list->next->prev == list and list->prev->next ==
list, then if list->next == list then list->prev == list. Ditto for the 
other rule.

so i think we only need the following two checks:

+	BUG_ON(list->next->prev != list);
+	BUG_ON(list->prev->next != list);

and we could as well add these unconditionally (no .config complexity
needed), until 2.6.0 or so, hm?

	Ingo

