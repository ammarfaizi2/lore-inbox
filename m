Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964922AbWE0R3y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964922AbWE0R3y (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 May 2006 13:29:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964923AbWE0R3y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 May 2006 13:29:54 -0400
Received: from hobbit.corpit.ru ([81.13.94.6]:2143 "EHLO hobbit.corpit.ru")
	by vger.kernel.org with ESMTP id S964922AbWE0R3x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 May 2006 13:29:53 -0400
Message-ID: <44788C8A.2070900@tls.msk.ru>
Date: Sat, 27 May 2006 21:29:46 +0400
From: Michael Tokarev <mjt@tls.msk.ru>
Organization: Telecom Service, JSC
User-Agent: Mail/News 1.5 (X11/20060318)
MIME-Version: 1.0
To: Wu Fengguang <wfg@mail.ustc.edu.cn>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/32] Adaptive readahead V14
References: <348745084.15239@ustc.edu.cn>
In-Reply-To: <348745084.15239@ustc.edu.cn>
X-Enigmail-Version: 0.94.0.0
OpenPGP: id=4F9CF57E
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wu Fengguang wrote:
> Andrew,
> 
> This is the 14th release of the adaptive readahead patchset.

A question I wanted to ask for quite some time already but for
some reason didn't ask...

How the new readahead logic works with media read errors?
Current linux behavior is questionable (it killed my dvd drive
for example, due to too many retries to read a single bad block
on a CD-Rom), it - I think - should be to stop reading ahead if
an read error occurs, instead of re-trying, and only retry to
read that block (if at all) when and only when an application
asks for that block.  I'm unsure when it should "resume reading
ahead" again (ie, like, setting ra to 0 on first error, and
restoring it back if we trying to read past the bad block.. or
set it to 0, and try to increase it on subsequent reads one by
one back to the original value, or...) - but that's probably
different story, for now, i think just setting ra to 0 on read
error will be sufficient...

Thanks.

/mjt
