Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265253AbTFROds (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 10:33:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265261AbTFROds
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 10:33:48 -0400
Received: from k101-205.bas1.dbn.dublin.eircom.net ([159.134.101.205]:33290
	"EHLO corvil.com") by vger.kernel.org with ESMTP id S265253AbTFROdr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 10:33:47 -0400
Message-ID: <3EF07A43.8000505@draigBrady.com>
Date: Wed, 18 Jun 2003 15:42:11 +0100
From: P@draigBrady.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3b) Gecko/20030210
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Guennadi Liakhovetski <gl@dsa-ac.de>
CC: linux-kernel@vger.kernel.org, debian-glibc@lists.debian.org
Subject: Re: VIA Ezra CentaurHauls
References: <Pine.LNX.4.33.0306181205180.2967-100000@pcgl.dsa-ac.de>
In-Reply-To: <Pine.LNX.4.33.0306181205180.2967-100000@pcgl.dsa-ac.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Guennadi Liakhovetski wrote:
> Hello
> 
> We have a platform with the above processor, and we happened to have 2
> revisions thereof: stepping 8 and 10. With stepping 8 we are getting
> "random" application crashes (segfaults), sometimes with kernel-Oopses.
> The distribution is Debian-Woody.

Interesting, so stepping 10 is OK?

> I saw some messages on the Debian
> mailing list about problems with exactly this CPU, however, it was not
> related to different revisions (stepping), perhaps, the author only had
>  / tried stepping 8. The fix was to upgrade libc.

so is it a glibc bug or CPU bug?

> I've done this (to
> version libc6_2.3.1-16, but it didn't help. Any ideas?

You could search for CMOV instructions on your system,
which could cause wierdness, like:

find / -perm +111 -type f |
while read bin; do
     objdump --disassemble $bin 2>/dev/null |
     grep -q cmov && echo "$bin has cmov"
done

Note C3 Nehemiah do have CMOV (but no 3dnow).

Pádraig.

