Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932784AbVJ3CAM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932784AbVJ3CAM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 22:00:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932781AbVJ3CAM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 22:00:12 -0400
Received: from smtp202.mail.sc5.yahoo.com ([216.136.129.92]:18016 "HELO
	smtp202.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S932784AbVJ3CAK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 22:00:10 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=sIHVoM4X8KrPWbTOye5/EqjB2p+8BGV84izM/6NGClMjUSejpwN8gIA9Ld5J0w6syRG4H59pA/2SSm6CIhowbzvMiw+1KEruIFMt/A05LTG5sNauQtjU+wXo3ftiLKVNq6cr29TLKZEDyralPqzBOQr6e9rYEu9NuVBAl0Ihleo=  ;
Message-ID: <4364296E.1080905@yahoo.com.au>
Date: Sun, 30 Oct 2005 13:01:18 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Paul Jackson <pj@sgi.com>
CC: "Rohit, Seth" <rohit.seth@intel.com>, akpm@osdl.org, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH]: Clean up of __alloc_pages
References: <20051028183326.A28611@unix-os.sc.intel.com> <20051029184728.100e3058.pj@sgi.com>
In-Reply-To: <20051029184728.100e3058.pj@sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson wrote:
> A couple more items:
>  1) Lets try for a consistent use of type "gfp_t" for gfp_mask.
>  2) The can_try_harder flag values were driving me nuts.

Please instead use a second argument 'gfp_high', which will nicely
match zone_watermark_ok, and use that consistently when converting
__alloc_pages code to use get_page_from_freelist. Ie. keep current
behaviour.

That would solve my issues with the patch.

>  3) The "inline" you added to buffered_rmqueue() blew up my compile.

How? Why? This should be solved because a future possible feature
(early allocation from pcp lists) will want inlining in order to
propogate the constant 'replenish' argument.

>  4) The return from try_to_free_pages() was put in "i" for no evident reason.
>  5) I have no clue what the replenish flag you added to buffered_rmqueue does.
> 

Slight patch mis-split I guess. For the cleanup patch, you're right,
this should be removed.

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
