Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261501AbSIZVHm>; Thu, 26 Sep 2002 17:07:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261507AbSIZVHm>; Thu, 26 Sep 2002 17:07:42 -0400
Received: from pD9E23892.dip.t-dialin.net ([217.226.56.146]:2282 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S261501AbSIZVHl>; Thu, 26 Sep 2002 17:07:41 -0400
Date: Thu, 26 Sep 2002 15:13:35 -0600 (MDT)
From: Thunder from the hill <thunder@lightweight.ods.org>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Rik van Riel <riel@conectiva.com.br>
cc: Thunder from the hill <thunder@lightweight.ods.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][2.5] Single linked lists for Linux, overly complicated
 v2
In-Reply-To: <Pine.LNX.4.44L.0209261659150.1837-100000@duckman.distro.conectiva>
Message-ID: <Pine.LNX.4.44.0209261511290.7827-100000@hawkeye.luckynet.adm>
X-Location: Dorndorf/Steudnitz; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 26 Sep 2002, Rik van Riel wrote:
> > > In the case of slist_del() you HAVE to know it.

What about

/**
 * slist_del -  remove an entry from list
 * @buf:        a storage area, just as long as the entry
 * @entry:      entry to be removed
 */
#define slist_del(_entry_in,_buf)			\
do {							\
	typeof(_entry_in) _entry = (_entry_in),		\
			  _head = (_buf), _free;	\
	memcpy(_head, _entry, sizeof(_entry));		\
	_free = _entry;					\
	_entry = _entry->next;				\
	_head->next = NULL;				\
	(_buf) = _head;					\
} while (0)

?

			Thunder
-- 
assert(typeof((fool)->next) == typeof(fool));	/* wrong */

