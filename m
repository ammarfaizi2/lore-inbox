Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750829AbWEQCct@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750829AbWEQCct (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 22:32:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751153AbWEQCcs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 22:32:48 -0400
Received: from smtp110.mail.mud.yahoo.com ([209.191.85.220]:60583 "HELO
	smtp110.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750829AbWEQCcs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 22:32:48 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=hTOXqRM6iRecMHhMPzXgH+uWS4DcAEo+/znmlHJNvW1lCOs5ZFb6QtzplY4cIFidZJ6O6fxI1xREQjv/aCBRtg62vLssiZFvKmEUhM9WC6+Y3/kTme6uZJ6aiSo+4BteOJbC4tFDYXsq6aIWhxxu/4xtZLAIQPMRSCbPBkj5Jjo=  ;
Message-ID: <446A8B48.5060107@yahoo.com.au>
Date: Wed, 17 May 2006 12:32:40 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050927 Debian/1.7.8-1sarge3
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Martin Peschke <mp3@de.ibm.com>, linux-kernel@vger.kernel.org, ak@suse.de,
       hch@infradead.org, arjan@infradead.org, James.Smart@Emulex.Com,
       James.Bottomley@SteelEye.com, Ingo Molnar <mingo@elte.hu>
Subject: Re: [RFC] [Patch 7/8] statistics infrastructure - exploitation prerequisite
References: <446A1023.6020108@de.ibm.com> <20060516112824.39b49563.akpm@osdl.org>
In-Reply-To: <20060516112824.39b49563.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>Martin Peschke <mp3@de.ibm.com> wrote:
>
>>need sched_clock for latency statistics
>>
>
>sched_clock() probably isn't suitable for this application.  It's a
>scheduler thing and has a number of accuracy problems.
>
>But I thought we discussed this last time around?  Maybe not.
>
>Maybe you've considered sched_clock()'s drawbacks and you've decided
>they're all acceptable.  If so, the changelog should have described the
>reasoning.
>

Yeah; please, no more users of sched_clock(). Definitely don't export.

Even if it is what you want today (which it probably isn't), the scheduler
might want the ability to change it at short notice, depending on new
algorithms / new hardware etc. in future.

Make a new function if none of the suggested alternatives work.

--

Send instant messages to your online friends http://au.messenger.yahoo.com 
