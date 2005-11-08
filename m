Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965100AbVKHBhM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965100AbVKHBhM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 20:37:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965126AbVKHBhL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 20:37:11 -0500
Received: from smtp206.mail.sc5.yahoo.com ([216.136.129.96]:13665 "HELO
	smtp206.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S965100AbVKHBhK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 20:37:10 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=XD7rbOVjYkljVyTgUysd80Si8yAFkc6w8EJinMizl7LLsvYkPj/msJrG8/Jqyb9MDcdMF2hrUrCHVAeYz1XA4r1Kgw5DNLNh+faZM8cKzV8By2rCnT6ccnDB+I8Kf2CpnuY2OTYSSKLj1RyTQ5PUe4I8knLU1rjV3caWg2CteKk=  ;
Message-ID: <4370015A.8010402@yahoo.com.au>
Date: Tue, 08 Nov 2005 12:37:30 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Neil Brown <neilb@suse.de>
CC: Andrew Morton <akpm@osdl.org>, dm-devel@redhat.com,
       heiko.carstens@de.ibm.com, linux-kernel@vger.kernel.org,
       aherrman@de.ibm.com, bunk@stusta.de, cplk@itee.uq.edu.au
Subject: Re: [dm-devel] Re: [PATCH resubmit] do_mount: reduce stack consumption
References: <20051104105026.GA12476@osiris.boeblingen.de.ibm.com>	<20051104084829.714c5dbb.akpm@osdl.org>	<20051104212742.GC9222@osiris.ibm.com>	<20051104235500.GE5368@stusta.de>	<20051104160851.3a7463ff.akpm@osdl.org>	<Pine.GSO.4.60.0511051108070.2449@mango.itee.uq.edu.au>	<20051104173721.597bd223.akpm@osdl.org>	<17260.17661.523593.420313@cse.unsw.edu.au>	<17262.40176.342746.634262@cse.unsw.edu.au>	<20051107153706.2f3c8b67.akpm@osdl.org>	<436FF20D.8030200@yahoo.com.au> <17263.63845.556511.171582@cse.unsw.edu.au>
In-Reply-To: <17263.63845.556511.171582@cse.unsw.edu.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Brown wrote:
> On Tuesday November 8, nickpiggin@yahoo.com.au wrote:

>>Possibly it could go into struct io_context?
>>
> 
> 
> My quick reading of the code says that we could have to 
> allocate the struct right there in generic_make_request, and I don't
> think we can be certain that such an allocation will succeed.
> 
> Code that uses io_context can limp along if it doesn't exist.  
> The new generic_make_request needs this bio_list to be present 
> or it cannot do it's job.
> 

You can ask for the io context without having a request. However,
there is nothing like a mempool for them so code really should be
able to limp along without them.

I guess it would be silly to require such an allocation to succeed
here, because the block layer is pretty free of OOM deadlocks.

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
