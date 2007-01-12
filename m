Return-Path: <linux-kernel-owner+w=401wt.eu-S1751547AbXALAr6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751547AbXALAr6 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 19:47:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751539AbXALAr6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 19:47:58 -0500
Received: from smtp103.mail.mud.yahoo.com ([209.191.85.213]:24579 "HELO
	smtp103.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751460AbXALAr6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 19:47:58 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:X-YMail-OSG:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=yoAOZiMMzx8WS0Wj4RmTDVeqiepisrxq+zrum0r3kWOcBi7OSkC6HpTegZ9JpLcv2i6zX2/PlBim2E1Bk8GM4d2pLNYjsMZ5Dpkak2m7N0dVAC4Pax0Pz3LQysni4b7cwtg89pKZxgII8Lp9JLppPhG2dXqs8uLD+KoPwrIBUn8=  ;
X-YMail-OSG: pNHEqQ4VM1n1IL_j.X7BCSu7QS8hy46O0qcm.OhCVpDx36k9ZatgtaVhL0ChHY4HM1D3NCc78HtpsaDw51Zdwmt5UVq6AiaZvfIDL0f6nNUYs3S2QRCtVqilRsvzC2S7xV9vhaU3YqWHKLI-
Message-ID: <45A6DAA2.8070605@yahoo.com.au>
Date: Fri, 12 Jan 2007 11:47:30 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Jaya Kumar <jayakumar.lkml@gmail.com>
CC: Andrew Morton <akpm@osdl.org>, linux-fbdev-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH/RFC 2.6.20-rc4 1/1] fbdev,mm: hecuba/E-Ink fbdev driver
References: <20070111142427.GA1668@localhost>	 <20070111133759.d17730a4.akpm@osdl.org> <45a44e480701111622i32fffddcn3b4270d539620743@mail.gmail.com>
In-Reply-To: <45a44e480701111622i32fffddcn3b4270d539620743@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jaya Kumar wrote:
> On 1/11/07, Andrew Morton <akpm@osdl.org> wrote:
> 
>> That's all very interesting.
>>
>> Please don't dump a bunch of new implementation concepts like this on us
>> with no description of what it does, why it does it and why it does it in
>> this particular manner.
> 
> 
> Hi Andrew,
> 
> Actually, I didn't dump without description. :-) I had posted an RFC
> and an explanation of the design to the lists. Here's an archive link
> to that post. 
> http://marc.theaimsgroup.com/?l=linux-kernel&m=116583546411423&w=2
> I wasn't sure whether to include that description with the patch email
> because it was long.
> 
>> From that email:
> 
> ---
> This is there in order to hide the latency
> associated with updating the display (500ms to 800ms). The method used
> is to fake a framebuffer in memory. Then use pagefaults followed by delayed
> unmaping and only then do the actual framebuffer update. To explain this
> better, the usage scenario is like this:
> 
> - userspace app like Xfbdev mmaps framebuffer
> - driver handles and sets up nopage and page_mkwrite handlers
> - app tries to write to mmaped vaddress
> - get pagefault and reaches driver's nopage handler
> - driver's nopage handler finds and returns physical page ( no
>  actual framebuffer )
> - write so get page_mkwrite where we add this page to a list
> - also schedules a workqueue task to be run after a delay
> - app continues writing to that page with no additional cost
> - the workqueue task comes in and unmaps the pages on the list, then
>  completes the work associated with updating the framebuffer

Have you thought about implementing a traditional write-back cache using
the dirty bits, rather than unmapping the page?

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
