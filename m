Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932444AbWHWMKG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932444AbWHWMKG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 08:10:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932443AbWHWMKF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 08:10:05 -0400
Received: from mailer.gwdg.de ([134.76.10.26]:57738 "EHLO mailer.gwdg.de")
	by vger.kernel.org with ESMTP id S932444AbWHWMKC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 08:10:02 -0400
Date: Wed, 23 Aug 2006 14:06:10 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Richard Knutsson <ricknu-0@student.ltu.se>
cc: Andrew Morton <akpm@osdl.org>, Prajakta Gudadhe <pgudadhe@nvidia.com>,
       jeff@garzik.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.18-rc4-mm2] Generic boolean (was: Re: Generic booleans
 in -mm)
In-Reply-To: <44EC3878.9070300@student.ltu.se>
Message-ID: <Pine.LNX.4.61.0608231403280.14327@yvahk01.tjqt.qr>
References: <1156209426.2840.15.camel@dhcp-172-16-174-114.nvidia.com>
 <20060821224457.65de5111.akpm@osdl.org> <44EB8B2A.8030603@student.ltu.se>
 <20060822161706.bad04598.akpm@osdl.org> <44EC3878.9070300@student.ltu.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


> There has been concern about adding other values then 0 and 1. There has been
> ideas to do something like:
> bool b = i & 1 : 0;

I think you miseed a '?'

bool b = (i & 1) ? : 0;

> /*or*/
> bool b = !!i;
>
> but all that is needed is just a casting:
>
> bool b = (bool) i;

No casting needed (in fact, casting is more evil than !!). If bool is a
bool, then the compiler will (hopefully) ensure that b will only get
values valid for bools.

$ cat x.c
#include <stdbool.h>
#include <stdio.h>

int main(int argc, const char **argv) {
    _Bool b = argc;
    printf("%d\n", (int)b);
    return 0;
}
$ ./a.out 
1



Jan Engelhardt
-- 
