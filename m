Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267466AbTAVMhh>; Wed, 22 Jan 2003 07:37:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267469AbTAVMhg>; Wed, 22 Jan 2003 07:37:36 -0500
Received: from services.cam.org ([198.73.180.252]:906 "EHLO mail.cam.org")
	by vger.kernel.org with ESMTP id <S267466AbTAVMhg>;
	Wed, 22 Jan 2003 07:37:36 -0500
From: Ed Tomlinson <tomlins@cam.org>
Subject: Re: {sys_,/dev/}epoll waiting timeout
To: Jamie Lokier <jamie@shareable.org>, linux-kernel@vger.kernel.org
Reply-To: tomlins@cam.org
Date: Wed, 22 Jan 2003 07:46:24 -0500
References: <20030122065502.GA23790@math.leidenuniv.nl> <20030122080322.GB3466@bjl1.asuk.net>
Organization: me
User-Agent: KNode/0.7.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Message-Id: <20030122124625.8CBFD2661@oscar.casa.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier wrote:

>         jtimeout = 0;
>         if (timeout) {
>                 /* Careful about overflow in the intermediate values */
>                 if ((unsigned long) timeout < MAX_SCHEDULE_TIMEOUT / HZ)
>                         jtimeout = (unsigned long)(timeout*HZ+999)/1000+1;
>                 else /* Negative or overflow */
>                         jtimeout = MAX_SCHEDULE_TIMEOUT;
>         }

Why assume HZ=1000?  Would not:

timeout = (unsigned long)(timeout*HZ+(HZ-1))/HZ+1;

make more sense?

