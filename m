Return-Path: <linux-kernel-owner+w=401wt.eu-S933640AbWLKOVr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933640AbWLKOVr (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 09:21:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933840AbWLKOVr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 09:21:47 -0500
Received: from smtp107.mail.mud.yahoo.com ([209.191.85.217]:36640 "HELO
	smtp107.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S933640AbWLKOVq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 09:21:46 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:X-YMail-OSG:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=n8HqccuExJKe/ov4zrXQHtIWQDgpJdtaGSICmBMuGDi4v4JEnT/BZNKH68PdzentGrtSgWy6pIopdJFYqKlgUS0DgzbnSP4EFXU/H1KYG5tSxV0NVBS/tTI703ZMhyfgq33aDqdNaRdVPDg7Bdl/kwcG5j+BhA10xu3mK7pr0vU=  ;
X-YMail-OSG: ATLJgH4VM1ljwbj03_jMWnvpTFx41c7Cd_POCcgPkT9ZJxixZcDIhEDwQ4cGaraOOPgaXxbkw0iRshGX4fgTIewAYUnqtgMNlKUO6M2GXtQ1Wa.3hl6d3DfSvqa58TeXT1gqINdlCBIihjc-
Message-ID: <457D6944.4010703@yahoo.com.au>
Date: Tue, 12 Dec 2006 01:20:52 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Mark Fasheh <mark.fasheh@oracle.com>
CC: Linux Memory Management <linux-mm@kvack.org>,
       linux-fsdevel@vger.kernel.org,
       linux-kernel <linux-kernel@vger.kernel.org>,
       OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
       Andrew Morton <akpm@google.com>
Subject: Re: Status of buffered write path (deadlock fixes)
References: <45751712.80301@yahoo.com.au> <20061207195518.GG4497@ca-server1.us.oracle.com> <4578DBCA.30604@yahoo.com.au> <20061208234852.GI4497@ca-server1.us.oracle.com> <457D20AE.6040107@yahoo.com.au>
In-Reply-To: <457D20AE.6040107@yahoo.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:
> Mark Fasheh wrote:

>> If we make the change I described above (looking for BH_New buffers 
>> outside
>> the range passed), then zero length or partial shouldn't matter, but zero
>> length instead of partial would be nicer imho just for the sake of 
>> reducing
>> the total number of cases down to the entire range or zero length.
> 
> 
> We don't want to do zero length, because we might make the theoretical
> livelock much easier to hit (eg. in the case of many small iovecs). But
> yes we can restrict ourselves to zero-length or full-length.

On second thoughts, I think I'm wrong about that.

Consider the last page of a file, which is uptodate. A full length
commit, which extends the file, will expose transient zeroes if the
usercopy fails.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
