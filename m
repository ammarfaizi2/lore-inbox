Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315746AbSHRTP3>; Sun, 18 Aug 2002 15:15:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315748AbSHRTP3>; Sun, 18 Aug 2002 15:15:29 -0400
Received: from dsl-213-023-039-196.arcor-ip.net ([213.23.39.196]:6618 "EHLO
	starship") by vger.kernel.org with ESMTP id <S315746AbSHRTP2>;
	Sun, 18 Aug 2002 15:15:28 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: linux-kernel@vger.kernel.org
Subject: Generic list push/pop
Date: Sun, 18 Aug 2002 21:21:41 +0200
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17gVcL-00031m-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I took a run at writing generic single-linked list push and pop macros, to be 
used in the form:

	push_list(foo_list, foo_node);

and
	foo_node = pop_list(foo_list);

They came out predictably ugly:

#define push_list(_LIST_, _NODE_) \
	_NODE_->next = _LIST_; \
	_LIST_ =_NODE_;

#define pop_list(_LIST_) ({ \
	typeof(_LIST_) _NODE_ = _LIST_; \
	_LIST_ = _LIST_->next; \
	_NODE_; })

These work but imho, they are too ugly to live.  For one thing, they assume 
the link field is named 'next' and I don't see a nice way around that.
Before moving them to my scraps.c file I thought I'd let other people throw 
some tomatoes at them.

-- 
Daniel
