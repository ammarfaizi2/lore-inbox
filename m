Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262036AbVFQR43@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262036AbVFQR43 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Jun 2005 13:56:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262032AbVFQR42
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Jun 2005 13:56:28 -0400
Received: from tetsuo.zabbo.net ([207.173.201.20]:49113 "EHLO tetsuo.zabbo.net")
	by vger.kernel.org with ESMTP id S262036AbVFQR4Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Jun 2005 13:56:16 -0400
Message-ID: <42B30EC1.60608@zabbo.net>
Date: Fri, 17 Jun 2005 10:56:17 -0700
From: Zach Brown <zab@zabbo.net>
User-Agent: Mozilla Thunderbird 1.0.2-1.3.3 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: John McCutchan <ttb@tentacle.dhs.org>
Cc: Robert Love <rml@novell.com>, Nick Piggin <nickpiggin@yahoo.com.au>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] inotify, improved.
References: <1118855899.3949.21.camel@betsy> <42B1BC4B.3010804@zabbo.net> <1118946334.3949.63.camel@betsy> <42B227B5.3090509@yahoo.com.au> <1118972109.7280.13.camel@phantasy> <1119021336.3949.104.camel@betsy> <42B30654.4030307@zabbo.net> <20050617175455.GA1981@tentacle.dhs.org>
In-Reply-To: <20050617175455.GA1981@tentacle.dhs.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John McCutchan wrote:

> I really don't like sending partial events. 

Partial reads, not partial events.  Just like the previous code, it
returns to userspace after copying the events it found in the list
before it went empty.  It doesn't go back to sleep to fill the rest of
the buffer like a more classical blocking read() method would.

Where it differs is in what happens if you get errors copying events
after having successfully copied some.  The previous code would return
the error, that patch would return the bytes used by the good events.

- z
