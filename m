Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262731AbUAHBFh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 20:05:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262765AbUAHBFh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 20:05:37 -0500
Received: from mtvcafw.sgi.com ([192.48.171.6]:65450 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id S262731AbUAHBFg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 20:05:36 -0500
Date: Wed, 7 Jan 2004 17:06:50 -0800
From: Paul Jackson <pj@sgi.com>
To: Joe Korty <joe.korty@ccur.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: seperator error in __mask_snprintf_len
Message-Id: <20040107170650.0fca07a7.pj@sgi.com>
In-Reply-To: <20040107165607.GA11483@rudolph.ccur.com>
References: <20040107165607.GA11483@rudolph.ccur.com>
Organization: SGI
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joe proposed this change to the loop displaying masks:
-		len += snprintf(buf+len, buflen-len, "%s%x", sep, wordp[i]);
+		len += snprintf(buf+len, buflen-len, "%x%s", wordp[i], sep);


I doubt that your patch is correct, Joe.

Consider for example the case that exactly three words are displayed.

Before your patch, the code would output one hex word, then (after
looping around once) the "," separator and the second word, then on the
final loop another separator and word, resulting in something such as:

    deadbeef,12345678,87654321

After your patch, it would output the first word, then the second word,
then a trailing separator, and then the third word and separator,
resulting in something such as:

    deadbeef12345678,87654321,

Oops.

In the abstract, the separator is _not_ a trailing punctutator to each
word, but is rather used to separate each word from the _preceding_ word
(if any).

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
