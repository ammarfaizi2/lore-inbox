Return-Path: <linux-kernel-owner+w=401wt.eu-S932780AbWLSKzm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932780AbWLSKzm (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 05:55:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932789AbWLSKzm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 05:55:42 -0500
Received: from smtp110.mail.mud.yahoo.com ([209.191.85.220]:37990 "HELO
	smtp110.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S932787AbWLSKzl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 05:55:41 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:X-YMail-OSG:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=f6Vee6s3Tx6uVLXwHaCR9/Vc7Lr66wUecn6YePT68tg8xfHna/QOlFW1Cfi/VqBIvsl1/GFyHreol+Izdmog3UqWMdckIW+nuu3grU4KoV4hqQQ5WeEzhdDsmowOHhipeZg4xCWSNzjtAQWQ2T9DoZVEmCoEY5u+HNLuAm7tgM4=  ;
X-YMail-OSG: KNx0kUcVM1kZu0Pb4vBXLYgENo.qIvnRI2kR1MxMaNb_ASxF.ko1r9LSKi.bAE_0rl7QIs4EeXeVh45FWnXtGDA0Ns.5VKrxvjlBUeZP_4Bn.BfXVHXpt3Z3MkmVp4Eg2HhTZxuplepyYU2iguj3xM1f4cZYeJKg3g--
Message-ID: <4587C506.5000900@yahoo.com.au>
Date: Tue, 19 Dec 2006 21:55:02 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Linus Torvalds <torvalds@osdl.org>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>, andrei.popa@i-neo.ro,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Hugh Dickins <hugh@veritas.com>, Florian Weimer <fw@deneb.enyo.de>,
       Marc Haber <mh+linux-kernel@zugschlus.de>,
       Martin Michlmayr <tbm@cyrius.com>
Subject: Re: 2.6.19 file content corruption on ext3
References: <1166314399.7018.6.camel@localhost>	<20061217040620.91dac272.akpm@osdl.org>	<1166362772.8593.2.camel@localhost>	<20061217154026.219b294f.akpm@osdl.org>	<1166460945.10372.84.camel@twins>	<Pine.LNX.4.64.0612180933560.3479@woody.osdl.org>	<45876C65.7010301@yahoo.com.au>	<Pine.LNX.4.64.0612182230301.3479@woody.osdl.org>	<45878BE8.8010700@yahoo.com.au>	<Pine.LNX.4.64.0612182313550.3479@woody.osdl.org>	<Pine.LNX.4.64.0612182342030.3479@woody.osdl.org>	<4587B762.2030603@yahoo.com.au> <20061219023255.f5241bb0.akpm@osdl.org>
In-Reply-To: <20061219023255.f5241bb0.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Tue, 19 Dec 2006 20:56:50 +1100
> Nick Piggin <nickpiggin@yahoo.com.au> wrote:

>>I think it could be very likely that indeed the bug is a latent one in
>>a clear_page_dirty caller, rather than dirty-tracking itself.
> 
> 
> The only callers are try_to_free_buffers(), truncate and a few scruffy
> possibly-wrong-for-fsync filesytems which aren't being used here.

Well truncate/invalidate will not operate on mapped pages (barring the
very-unlikely truncate/invalidate vs fault races). We can ignore those
filesystems as they don't include ext3. Which brings us back to
try_to_free_buffers().

Maybe it is something else entirely, but did try_to_free_buffers ever
get completely cleared? Or was some of Andrei's corruption possibly
leftover on-disk corruption from a previous kernel?

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
