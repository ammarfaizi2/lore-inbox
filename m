Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265447AbRF1AIX>; Wed, 27 Jun 2001 20:08:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265449AbRF1AIM>; Wed, 27 Jun 2001 20:08:12 -0400
Received: from tsukuba.m17n.org ([192.47.44.130]:3546 "EHLO tsukuba.m17n.org")
	by vger.kernel.org with ESMTP id <S265447AbRF1AIF>;
	Wed, 27 Jun 2001 20:08:05 -0400
Date: Thu, 28 Jun 2001 09:07:52 +0900 (JST)
Message-Id: <200106280007.f5S07qQ04446@mule.m17n.org>
From: NIIBE Yutaka <gniibe@m17n.org>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: "Stephen C. Tweedie" <sct@redhat.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] swapin flush cache bug
In-Reply-To: <Pine.LNX.4.21.0106270710050.1291-100000@freak.distro.conectiva>
In-Reply-To: <200106270051.f5R0pkl19282@mule.m17n.org>
	<Pine.LNX.4.21.0106270710050.1291-100000@freak.distro.conectiva>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti wrote:
 > I think Stephen C. Tweedie has some considerations about the cache
 > flushing calls on do_swap_page().

Yup.  IIRC, he said that flushing cache at do_swap_page() (which I've
tried at first) is not good, because it's the hot path and it causes
another performance problem in apache or sendmail, where many
processes share the pages in swap cache.

Then, the fix I sent yesterday is second try.  The flush is moved to
I/O routine, instead of do_swap_page().

Actually, I really wonder why current code causes no problem in other
architectures.
-- 
