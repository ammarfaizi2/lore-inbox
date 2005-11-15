Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932563AbVKOXX1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932563AbVKOXX1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 18:23:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932565AbVKOXX1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 18:23:27 -0500
Received: from mail-haw.bigfish.com ([12.129.199.61]:60780 "EHLO
	mail32-haw-R.bigfish.com") by vger.kernel.org with ESMTP
	id S932563AbVKOXX0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 18:23:26 -0500
X-BigFish: V
Message-ID: <437A6DEC.4030900@am.sony.com>
Date: Tue, 15 Nov 2005 15:23:24 -0800
From: Tim Bird <tim.bird@am.sony.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Guillaume Chazarain <guichaz@yahoo.fr>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       "Bird, Tim" <Tim.Bird@am.sony.com>
Subject: Re: [-mm PATCH 1/2] printk return value: fix it
References: <4379D1F7.1000701@yahoo.fr>
In-Reply-To: <4379D1F7.1000701@yahoo.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Guillaume Chazarain wrote:
> What's the true meaning of the printk return value?
> Should it include the priority prefix length of 3? and what about the
> timing
> information? In both cases it was broken:
> 
> strace -e write echo 1 > /dev/kmsg
> => write(1, "1\n", 2)                      = 5
> strace -e write echo "<1>1" > /dev/kmsg
> => write(1, "<1>1\n", 5)                   = 8
This is clearly a bug, but due to (almost) no one
ever checking the return value, it has gone unnoticed.

> 
> The returned length was "length of input string + 3", I made it "length
> of string output to the log buffer".

I agree with this change.  I think it fits with how
the size is returned from printf in user space,
which can be greater than the length of the format
string when values are replaced in the string.  So
at least for printf, there is a precedent for returning a
number greater than the length of the submitted string.

 -- Tim

=============================
Tim Bird
Architecture Group Chair, CE Linux Forum
Senior Staff Engineer, Sony Electronics
=============================

