Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318696AbSHSM1G>; Mon, 19 Aug 2002 08:27:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318742AbSHSM1G>; Mon, 19 Aug 2002 08:27:06 -0400
Received: from dsl-213-023-038-065.arcor-ip.net ([213.23.38.65]:10719 "EHLO
	starship") by vger.kernel.org with ESMTP id <S318696AbSHSM1F>;
	Mon, 19 Aug 2002 08:27:05 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: William Lee Irwin III <wli@holomorphy.com>
Subject: Re: Generic list push/pop
Date: Mon, 19 Aug 2002 14:32:48 +0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
References: <E17gVcL-00031m-00@starship> <20020819120550.GA21683@holomorphy.com>
In-Reply-To: <20020819120550.GA21683@holomorphy.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17gliC-0003DD-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 19 August 2002 14:05, William Lee Irwin III wrote:
> On Sun, Aug 18, 2002 at 09:21:41PM +0200, Daniel Phillips wrote:
> > I took a run at writing generic single-linked list push and pop macros, to be 
> > used in the form:
> 
> Dear gawd, I've gone blind.
> 
> How's this look?

Unfortunately, not good.  You get code like:

	foo = (struct mylist *) slist_pop((slist *) &somelist->next);

So type safety goes out the window, and you gain some niceness in the
definition in exchange for ugliness in usage, the wrong tradeoff imho.

> struct slist
> {
> 	struct slist *next;
> };
> 
> 
> static inline void slist_add(struct slist *head, struct slist *elem)
> {
> 	elem->next = head->next;
> 	head->next = elem;
> }
> 
> #define slist_push(head, elem)	slist_add(head, elem)
> 
> static inline struct slist *slist_pop(struct slist *head)
> {
> 	struct slist *elem = head->next;
> 
> 	if (elem) {
> 		head->next = elem->next;
> 		elem->next = NULL;
> 	}
> 	return elem;
> }

-- 
Daniel
