Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318783AbSHSMCu>; Mon, 19 Aug 2002 08:02:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318744AbSHSMCu>; Mon, 19 Aug 2002 08:02:50 -0400
Received: from holomorphy.com ([66.224.33.161]:24779 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S318783AbSHSMCt>;
	Mon, 19 Aug 2002 08:02:49 -0400
Date: Mon, 19 Aug 2002 05:05:50 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Daniel Phillips <phillips@arcor.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Generic list push/pop
Message-ID: <20020819120550.GA21683@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Daniel Phillips <phillips@arcor.de>, linux-kernel@vger.kernel.org
References: <E17gVcL-00031m-00@starship>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <E17gVcL-00031m-00@starship>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 18, 2002 at 09:21:41PM +0200, Daniel Phillips wrote:
> I took a run at writing generic single-linked list push and pop macros, to be 
> used in the form:

Dear gawd, I've gone blind.

How's this look?


Cheers,
Bill


struct slist
{
	struct slist *next;
};


static inline void slist_add(struct slist *head, struct slist *elem)
{
	elem->next = head->next;
	head->next = elem;
}

#define slist_push(head, elem)	slist_add(head, elem)

static inline struct slist *slist_pop(struct slist *head)
{
	struct slist *elem = head->next;

	if (elem) {
		head->next = elem->next;
		elem->next = NULL;
	}
	return elem;
}

static inline int slist_remove(struct slist *head, struct slist *elem)
{
	struct slist *curr, *prev;

	for (prev = head, curr = head->next; curr; prev = curr, curr = curr->next)
		if (curr == head) {
			prev->next = curr->next;
			curr->next = NULL;
			return 1;
		}

	return 0;
}
