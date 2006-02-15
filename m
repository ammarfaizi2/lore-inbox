Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030604AbWBOCuP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030604AbWBOCuP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 21:50:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030603AbWBOCuO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 21:50:14 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:40129 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1030604AbWBOCuN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 21:50:13 -0500
Subject: Re: [PATH 0/2] strndup_user, description
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Davi Arnaut <davi.arnaut@gmail.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <20060214214747.ef05e4d8.davi.arnaut@gmail.com>
References: <20060214214747.ef05e4d8.davi.arnaut@gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 15 Feb 2006 02:53:10 +0000
Message-Id: <1139971990.14831.2.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2006-02-14 at 21:47 -0300, Davi Arnaut wrote:
> This patch series creates a strndup_user() function in order to avoid duplicated
> and error-prone (userspace modifying the string after the strlen_user()) code.

Well userspace can still modify in this case. So you could still get a
\0 mid buffer but that seems harmless.

However

> +#define strdup_user(s)	strndup_user(s, PAGE_SIZE)

Better this doesn't exist as it is a wrapper for a bad habit that isnt
yet used so why encourage it.



> +	length = strlen_user(s);

What if n is very large ? Should use strnlen_user clipped by n

Also say the length limit is 8 and the text is "hello\0"

We get length = 5  5 < 8, alloc 5 bytes set 5th to \0 and return "hell
\0"



