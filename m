Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751249AbWCMW4F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751249AbWCMW4F (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 17:56:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751358AbWCMW4F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 17:56:05 -0500
Received: from smtp110.mail.mud.yahoo.com ([209.191.85.220]:6521 "HELO
	smtp110.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751249AbWCMW4E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 17:56:04 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=sOQn5r2HSpFL8zVyL5PtAhFJvH+6PPRUsybWvlS5RRFmxrTRkILtgpGSDnmOs+y9iY06VYA97sCVHdQxsc2FA7AbZWE98eHcvmp2cLqKrAiRewrCSQuC3nJu/31CtCCVEZxIxrol6mwu08Ioe4INsQEdM+aOL+MuJNJrdMdyUa0=  ;
Message-ID: <4415F87E.806@yahoo.com.au>
Date: Tue, 14 Mar 2006 09:55:58 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050927 Debian/1.7.8-1sarge3
X-Accept-Language: en
MIME-Version: 1.0
To: Jonathan Corbet <corbet@lwn.net>
CC: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: RFC: radix tree safety
References: <20060313224344.9173.qmail@lwn.net>
In-Reply-To: <20060313224344.9173.qmail@lwn.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jonathan Corbet wrote:

>I've been digging through the radix tree code, and I noticed that the
>tag functions have an interesting limitation.  The tag is given as an
>integer value, but, in reality, the only values that work are zero and
>one.  Anything else will return random results or (when setting tags)
>corrupt unrelated memory.
>
>The number of radix tree users is small, so it's not hard to confirm
>that all tag values currently in use are legal.  But the interface would
>seem to invite mistakes.
>
>The following patch puts in checks for out-of-range tag values.  I've
>elected to have the relevant call fail; one could argue that it should
>BUG instead.  Either seems better than silently doing weird stuff.  Not
>2.6.16 material, obviously, but maybe suitable thereafter.
>
>

I'd agree if you make them BUG_ON()s.

Andrew Morton's kind of the radix-tree tags guy though... Andrew?

Nick

Send instant messages to your online friends http://au.messenger.yahoo.com 
