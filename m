Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262074AbVAZBVw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262074AbVAZBVw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 20:21:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262050AbVAZBT1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 20:19:27 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:35564 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261831AbVAZBSG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 20:18:06 -0500
Message-ID: <41F6E175.9000502@austin.ibm.com>
Date: Tue, 25 Jan 2005 18:16:53 -0600
From: Steven Pratt <slpratt@austin.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ram <linuxram@us.ibm.com>
CC: Oleg Nesterov <oleg@tv-sign.ru>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 2/4] page_cache_readahead: remove duplicated code
References: <41F63493.309B0ADB@tv-sign.ru> <1106698119.3298.57.camel@localhost>
In-Reply-To: <1106698119.3298.57.camel@localhost>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ram wrote:

>On Tue, 2005-01-25 at 03:59, Oleg Nesterov wrote:
>  
>
>>Cases "no ahead window" and "crossed into ahead window"
>>can be unified.
>>    
>>
>
>
>No. There is a reason why we had some duplication. With your patch,
>we will end up reading-on-demand instead of reading ahead.
>
>When we notice a sequential reads have resumed, we first read in the
>data that is requested. 
>However if the read request is for more pages than what are being held
>in the current window, we make the ahead window as the current window
>and read in more pages in the ahead window. Doing that gives the
>opportunity of always having pages in the ahead window when the next
>sequential read request comes in.  If we apply this patch, we will
>always have to read the pages that are being requested instead of
>satisfying them from the ahead window.
>  
>
Ah, you are right! 

>Ok, if this does not make it clear, here is another way of proving that
>your patch does not exactly behave the way it did earlier.
>
>With your patch you will have only one call to
>block_page_cache_readahead(), when earlier there could be cases where
>block_page_cache_readahead() could be called twice.
>
>Am I am making sense?
>

Completely, this patch should not be applied.  Good catch.

Steve

>RP
> 
>  
>

