Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263562AbTIHUWA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 16:22:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263578AbTIHUWA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 16:22:00 -0400
Received: from mailgate.uni-paderborn.de ([131.234.22.32]:40632 "EHLO
	mailgate.uni-paderborn.de") by vger.kernel.org with ESMTP
	id S263562AbTIHUV6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 16:21:58 -0400
Message-ID: <3F5CE3E6.8070201@upb.de>
Date: Mon, 08 Sep 2003 22:17:42 +0200
From: =?ISO-8859-1?Q?Sven_K=F6hler?= <skoehler@upb.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5b) Gecko/20030827
X-Accept-Language: de, en
MIME-Version: 1.0
To: Paul Clements <Paul.Clements@SteelEye.com>
CC: Pavel Machek <pavel@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: [NBD] patch and documentation
References: <3F5CB554.5040507@upb.de> <20030908193838.GA435@elf.ucw.cz> <3F5CE0E5.A5A08A91@SteelEye.com>
In-Reply-To: <3F5CE0E5.A5A08A91@SteelEye.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-MailScanner-Information: Please see http://imap.upb.de for details
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam, SpamAssassin (score=-25.4, required 4,
	IN_REP_TO -3.30, QUOTED_EMAIL_TEXT -3.20, REFERENCES -6.60,
	REPLY_WITH_QUOTES -6.50, USER_AGENT_MOZILLA_UA -5.80)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>The patch also looks harmless enough for applying ;-).
> 
> Harmless enough, although I'm not sure it really makes that much
> difference. The max_sectors being set to 255 doesn't, by itself, explain
> the back and forth 127k, 1k request thing. Typically what you'll see is
> 127k, 127k, 127k, etc. and then some odd sized request at the end. Or
> the device gets unplugged anyway at some point and there are odd sized
> requests scattered throughout...that's especially going to be true if
> the reads or writes are from an actual disk, rather than /dev/null. I
> may be just coincidence that setting max_sectors to 256 actually helps.
> Also, are we sure that all those requests you're seeing are of the same
> type (all reads, all writes)?

Well, i guess the cache uses a value of 256 sectors to do read-ahead and 
such. I used dd if=/dev/nbd/0 of=/dev/null bs=X with both X=1 and X=1M.
Both with the same result. That the 1byte requests join together to 
bigger ones can only be explained with read-aheads strategies.
Anyway, the result is always the same:

without patch: 127KB, 1KB, 127KB, 1KB
with path: 128KB, 128KB, 128KB

As long as dd doesn't write i'm sure that i didn't see any write 
requests. In addition it is a very regular pattern.
If it is really the case that the cache reads 256 sectors and the 
default limit is 255, than this would also happen for all other 
block-devices. In addition it would be a good thing to look up if the 
cache takes the max_sectors stuff into accout while determining the 
amout of sectors it reads ahead.


