Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262513AbSJBSLJ>; Wed, 2 Oct 2002 14:11:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262517AbSJBSLJ>; Wed, 2 Oct 2002 14:11:09 -0400
Received: from n13.sp.op.dlr.de ([129.247.25.4]:21913 "EHLO n13.sp.op.dlr.de")
	by vger.kernel.org with ESMTP id <S262513AbSJBSLJ>;
	Wed, 2 Oct 2002 14:11:09 -0400
Message-ID: <3D9B376B.6060900@dlr.de>
Date: Wed, 02 Oct 2002 20:14:03 +0200
From: Martin Wirth <Martin.Wirth@dlr.de>
Reply-To: Martin.Wirth@dlr.de
User-Agent: Mozilla/5.0 (X11; U; SunOS sun4u; en-US; rv:1.0.0) Gecko/20020611
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Subject: Re: [patch] futex-2.5.40-B5
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo,

in your updated futex patch you use get_page/put_page for page pinning.
But for reserved pages, put_page does not decrement the page counter, so
get_page should not be called for such pages. These was a patch included
in 2.5.40 which changed this the call to page_cache_get
(==get_page in current implementation) in get_user_pages to:

	if (!PageReserved(page))
		get_page(page);

So I think the futex code should do the same.

Martin

