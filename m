Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262393AbVG0AXb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262393AbVG0AXb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 20:23:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262408AbVG0AX1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 20:23:27 -0400
Received: from smtp206.mail.sc5.yahoo.com ([216.136.129.96]:24691 "HELO
	smtp206.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262403AbVG0AXM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 20:23:12 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=TzluoHJDi/OGcNW1zidkz7X4lgh0Klp+o8ooKPqV38uZkrXNGj4XbLWMdIKhZMeqFOCASQx3CcjYyNlLW82Vc72XNIXaLdvc8UF1v5lr+JVdJHWBm9KuhJ/Ka/iUpXVnQ79j2kPkUwM1FRZrT5IOXFWQNMjOGdFo3qJeTG+LvCY=  ;
Message-ID: <42E6D3E2.3050601@yahoo.com.au>
Date: Wed, 27 Jul 2005 10:22:58 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050513 Debian/1.7.8-1
X-Accept-Language: en
MIME-Version: 1.0
To: Kumar Gala <kumar.gala@freescale.com>
CC: Andrew Morton <akpm@osdl.org>, Hugh Dickins <hugh@veritas.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch 0/6] remove PageReserved
References: <42E5F139.70002@yahoo.com.au> <9AB335F0-28CD-4561-B447-DA09CF44F0AB@freescale.com>
In-Reply-To: <9AB335F0-28CD-4561-B447-DA09CF44F0AB@freescale.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kumar Gala wrote:

>>
>> Most of the arch code is just reserved memory reporting, which
>> isn't very interesting and could easily be removed. Some arch users
>> are a bit more subtle, however they *should not* break, because all
>> the places that set and clear PageReserved are basically intact.
>
>
> What is the desired fix look like for arch users?
>

It really depends on how it is used.

Firstly, we want to retain all the places that do SetPageReserved and
ClearPageReserved to ensure that remaining places that test PageReserved
will continue to work.

So users of PageReserved need to be removed. For example, on i386 this
is simply reserved memory accounting - which isn't very meaningful and
can probably be simply deleted. i386 ioremap also tests PageReserved to
ensure it isn't remapping usable RAM, which is a similar need to swsusp's,
so one solution would likely cover that ioremap and swsusp.

For now, the main thing to keep in mind is to not add a new user of
PageReserved. We can start looking at how to cut down existing users when
the core patch gets into -mm or further upstream.

Nick


Send instant messages to your online friends http://au.messenger.yahoo.com 
