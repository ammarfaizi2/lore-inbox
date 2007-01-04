Return-Path: <linux-kernel-owner+w=401wt.eu-S932288AbXADFwg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932288AbXADFwg (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 00:52:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932290AbXADFwe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 00:52:34 -0500
Received: from smtp108.mail.mud.yahoo.com ([209.191.85.218]:29644 "HELO
	smtp108.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S932288AbXADFwc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 00:52:32 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:X-YMail-OSG:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=N7uDNxg1RQw3x0lmtg8rDtJTeo6OwdSF60mojpaNFKlqm0znTjkiYPniBIeLxLXULYODblB8LfIEM001fYVt/Uxxb57XUcPtvSMk38KP/B5h034TWkteNTrobaxzKjJ4qYU2o4DVdSqoxWuyyXl9EVqng3x2p3rnW4kAMow+fFs=  ;
X-YMail-OSG: aSa80BEVM1nTm1RtRzPj0Jh5ofB6IfaY4AqldtxOUNKKQkq3oxpY4X54742BkDBNv6EvoUtKGIHELODr4hq1RzCaHetw4jrrxxA2JPC5_jAve2GZWzXdVXeYTsG.4HS0bRVVyGt8iMLstJI-
Message-ID: <459C95FE.1090802@yahoo.com.au>
Date: Thu, 04 Jan 2007 16:51:58 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: suparna@in.ibm.com
CC: Andrew Morton <akpm@osdl.org>, linux-aio@kvack.org, drepper@redhat.com,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       jakub@redhat.com, mingo@elte.hu
Subject: Re: [PATCHSET 1][PATCH 0/6] Filesystem AIO read/write
References: <20061227153855.GA25898@in.ibm.com> <20061228082308.GA4476@in.ibm.com> <20070103141556.82db0e81.akpm@osdl.org> <20070104045621.GA8353@in.ibm.com>
In-Reply-To: <20070104045621.GA8353@in.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Suparna Bhattacharya wrote:
> On Wed, Jan 03, 2007 at 02:15:56PM -0800, Andrew Morton wrote:

>>Plus Jens's unplugging changes add more reliance upon context inside
>>*current, for the plugging and unplugging operations.  I expect that the
>>fsaio patches will need to be aware of the protocol which those proposed
>>changes add.
> 
> 
> Whatever logic applies to background writeout etc should also just apply
> as is to aio worker threads, shouldn't it ? At least at a quick glance I
> don't see anything special that needs to be done for fsaio, but its good
> to be aware of this anyway, thanks !

The submitting process plugs itself, submits all its IO, then unplugs
itself (ie. so the plug is now on the process, rather than the block
device).

So long as AIO threads do the same, there would be no problem (plugging
is optional, of course).

This (is supposed to) give a number of improvements over the traditional
plugging (although some downsides too). Most notably for me, the VM gets
cleaner ;)

However AIO could be an interesting case to test for explicit plugging
because of the way they interact. What kind of improvements do you see
with samba and do you have any benchmark setups?

Thanks,
Nick

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
