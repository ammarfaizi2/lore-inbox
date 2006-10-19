Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946646AbWJSX1Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946646AbWJSX1Q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 19:27:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946670AbWJSX1Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 19:27:16 -0400
Received: from smtp105.mail.mud.yahoo.com ([209.191.85.215]:53129 "HELO
	smtp105.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1946669AbWJSX1P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 19:27:15 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=OGWRZp2FBm8GHYs2S1fPYeGEAGuJkIlwIAtH0QEplyi2grAeVbmde5iPkxI8659itCjI2qawpZp90o9pWwuPojHNHaEQ2dwMknmDHolC73WM6z1T9GXCusuLhRW60j/tsjUm/PjoG/vKpgwLXsiRslQZagOsBntdawWpD3MznMQ=  ;
Message-ID: <453809C6.20708@yahoo.com.au>
Date: Fri, 20 Oct 2006 09:27:02 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Mark Fasheh <mark.fasheh@oracle.com>
CC: Nick Piggin <npiggin@suse.de>, linux-kernel@vger.kernel.org, akpm@osdl.org,
       linux-fsdevel@vger.kernel.org
Subject: Re: + fs-prepare_write-fixes.patch added to -mm tree
References: <200610182150.k9ILoLNk019702@shell0.pdx.osdl.net> <20061019014209.GA10128@ca-server1.us.oracle.com> <20061019052537.GA15687@wotan.suse.de> <20061019230900.GE10128@ca-server1.us.oracle.com>
In-Reply-To: <20061019230900.GE10128@ca-server1.us.oracle.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Fasheh wrote:
> On Thu, Oct 19, 2006 at 07:25:37AM +0200, Nick Piggin wrote:
> 
>>I sent an RFC to linux-fsdevel, did you get that?
> 
> Yeah, I don't think I thought of my concerns at the time.
> 
> 
> 
>>I was planning to cc some maintainers, including you, for those
>>filesystems that are non-trivial. I just hadn't had a chance to
>>test it properly last night.
> 
> Cool, I appreciate that.

OK, I will be posting that mail tomorrow or next day... I'll summarise
your concerns you've posted in this thread too.


>>OK thanks for looking at that. If the length of the commit is greater
>>than 0 (but still short), then the page is uptodate so it should be
>>fine to commit what we have written, I think?
> 
> That seems to make sense to me.
> 
>  
> 
>>If the length is zero, then we probably want to roll back entirely.
> 
> The thing is, rollback might be hard (or expensive) for some file systems
> with more complicated tree implementations, etc.
> 
> Do we have the option in this case of just zeroing the newly allocated
> portions and writing them out? Userspace would then just be seeing
> that like any other hole.

Sure that's possible. You could even recognise that it is a hole in your
prepare_write, and zero the page and set it uptodate there.

You probably don't actually want to do that, because it means a double
overwrite in the case of a page sized,aligned write... but you have a
fairly broad scope of what you can do here. You are holding i_mutex and
the page lock, and the rest is up to you.

zeroing out the hole and marking it uptodate in case of a 0 length
->commit_write does sound like the right way to go. I probably haven't
handled that correctly if it needs to be done in ext? or generic fs/
routines...

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
