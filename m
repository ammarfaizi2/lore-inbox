Return-Path: <linux-kernel-owner+w=401wt.eu-S965132AbXAJWdP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965132AbXAJWdP (ORCPT <rfc822;w@1wt.eu>);
	Wed, 10 Jan 2007 17:33:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965143AbXAJWdP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Jan 2007 17:33:15 -0500
Received: from smtp108.mail.mud.yahoo.com ([209.191.85.218]:48708 "HELO
	smtp108.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S965132AbXAJWdO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Jan 2007 17:33:14 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:X-YMail-OSG:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=x+cssQXUe6uJ8/KVF/TheoXSLgEUYG9EO1YSQ3bcCFTy2zhKnP6A+1TtV0km2qXW/+Z2o9THERWhH+fAaBhSWmkUEaJRpxUYpQHGuWlBnq1bg2u2lodAvcPCdtr8uYAK7rTBelT8UswM7WRhqeAVBWdclTrhOxwSW9z7I/oZwRs=  ;
X-YMail-OSG: Y.QoCLMVM1nCIrHFhCpAFeanIP_ccpLkh89uELdjzOUtYx3jagHSdkXCAS1gHtIRZxPIZLvt6MvRavxJ5J6OFqH0iRf8xYug1fdzc73UNM.E6y5JA73fdr0rUD_gyhJNLCHt_6BQDuOVY0Q8FwX95Rnf3OXMZUeP.Pg-
Message-ID: <45A56989.3060209@yahoo.com.au>
Date: Thu, 11 Jan 2007 09:32:41 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Richard Purdie <richard@openedhand.com>
CC: Hugh Dickins <hugh@veritas.com>,
       kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 0/4] Improve swap page error handling
References: <1168452294.5801.58.camel@localhost.localdomain>
In-Reply-To: <1168452294.5801.58.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard Purdie wrote:

>>No, not this way, I'm afraid.  Sorry, I don't remember the prior
>>discussion on LKML, must have flooded past when my attention was
>>elsewhere.
> 
> 
> I think you were cc'd on some of it but you never commented. Anyhow,
> I've reworked this patch series based on your comments. The hints were
> appreciated, thanks. This was the way I'd originally hoped to be able to
> work things, I just couldn't find the right way to do it.

IMO it seems a bit complex for so small a benefit. Last time I was
working on this, I thought it would be almost as good to do something
simple like stop trying to write out the page if PG_error is set (and
clear that bit in delete_from_swap_cache or try_to_unusesomewhere).
This way the admin could swapoff and scan the swap device at some
point.

>>Is it worth doing this at all?  Probably, but I've no experience
>>whatsoever of swap write errors, so it's hard for me to judge: my
>>guess is that many cases would turn out to be software errors (e.g.
>>lower level needing more memory to perform the write).  But you'd
>>be right to counter: let's assume they're hardware errors, and
>>then fix up any software errors when reported.
> 
> 
> I have a swap block driver where hardware write errors are more likely
> and hence have a need to handle them more gracefully than IO loops. It
> seems like a good idea to avoid the IO loops anyway.
> 
> 
>>If it is worth doing this, then you'll need to add code to write
>>back the swap header, to note the bad pages permanently: you may
>>well have been waiting to see what reception the patches so far
>>get, before embarking on that.
> 
> 
> You can't proceed to do that until you're able to identify the bad pages
> so this would be a necessary first step towards that, yes.

Agreed here, FWIW. I think that might be just as well done in
userspace?

Nick

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
