Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261329AbSIZThs>; Thu, 26 Sep 2002 15:37:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261335AbSIZThr>; Thu, 26 Sep 2002 15:37:47 -0400
Received: from pD9E23892.dip.t-dialin.net ([217.226.56.146]:37096 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S261329AbSIZThr>; Thu, 26 Sep 2002 15:37:47 -0400
Date: Thu, 26 Sep 2002 13:43:41 -0600 (MDT)
From: Thunder from the hill <thunder@lightweight.ods.org>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Rik van Riel <riel@conectiva.com.br>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][2.5] Single linked lists for Linux, overly complicated
 v2
In-Reply-To: <Pine.LNX.4.44L.0209261628490.1837-100000@duckman.distro.conectiva>
Message-ID: <Pine.LNX.4.44.0209261337290.7827-100000@hawkeye.luckynet.adm>
X-Location: Dorndorf/Steudnitz; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 26 Sep 2002, Rik van Riel wrote:
> On Thu, 26 Sep 2002, Thunder from the hill wrote:
> In the case of slist_del() you HAVE to know it.
> 
> Think about removing a single entry from the middle of
> the list ... the entries before and after need to stay
> on the list.

2 solutions without list head:

1.
#define slist_del_next(_entry_in)			\
do {							\
	typeof(_entry_in) _entry = (_entry_in),		\
			  _next  = (_entry)->next;	\
	_entry->next = _next->next;			\
	_next->next = NULL;				\
} while (0)

2.	The previous entry points to the address that _entry has. If we 
	copy _entry somewhere else and overwrite the old _entry with 
	_entry->next, we made it without knowing the list topology. The 
	previous->next still points to the new _entry, things are fine.

My problem is just: where to put the old _entry? Anyway, since we're 
talking about list entry deletion, we could copy it nowhere and just 
overwrite it with _entry->next...

Details, details...

			Thunder
-- 
assert(typeof((fool)->next) == typeof(fool));	/* wrong */

