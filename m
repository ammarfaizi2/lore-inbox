Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261207AbSI3TcM>; Mon, 30 Sep 2002 15:32:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261284AbSI3TcL>; Mon, 30 Sep 2002 15:32:11 -0400
Received: from dsl-213-023-038-108.arcor-ip.net ([213.23.38.108]:38292 "EHLO
	starship") by vger.kernel.org with ESMTP id <S261207AbSI3TcJ>;
	Mon, 30 Sep 2002 15:32:09 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Zach Brown <zab@zabbo.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][2.5] Single linked lists for Linux, overly complicated v2
Date: Mon, 30 Sep 2002 21:37:53 +0200
X-Mailer: KMail [version 1.3.2]
References: <Pine.LNX.4.44L.0209261628490.1837-100000@duckman.distro.conectiva> <Pine.LNX.4.44.0209261337290.7827-100000@hawkeye.luckynet.adm> <20020926205727.T13817@bitchcake.off.net>
In-Reply-To: <20020926205727.T13817@bitchcake.off.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17w6Mc-0005p6-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 27 September 2002 02:57, Zach Brown wrote:
> #define tslist_add(_head, _elem) 			\
> 	do {  						\
> 		BUG_ON(tslist_on_list(_head, _elem));	\
> 		(_elem)->_slist_next = (_head);		\
> 		(_head) = (_elem);			\
> 	} while(0)

This evaluates _head and _elem twice each, or three times if you count
the BUG_ON.

Smaller point: why bother obfuscating the parameter names?  You will
need to do that for locals in macros but parameters should cause no
name conflicts.

-- 
Daniel
