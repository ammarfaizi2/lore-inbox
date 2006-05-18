Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932119AbWERSMs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932119AbWERSMs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 14:12:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932117AbWERSMs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 14:12:48 -0400
Received: from mailgw.cvut.cz ([147.32.3.235]:65514 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id S932115AbWERSMr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 14:12:47 -0400
Message-ID: <446CB91C.50302@vc.cvut.cz>
Date: Thu, 18 May 2006 20:12:44 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); en-US; rv:1.7.12) Gecko/20060205 Debian/1.7.12-1.1
X-Accept-Language: cs, en
MIME-Version: 1.0
To: Avishay Traeger <atraeger@cs.sunysb.edu>
CC: Xin Zhao <uszhaoxin@gmail.com>, Chris Wedgwood <cw@f00f.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-fsdevel@vger.kernel.org
Subject: Re: HELP! vfs_readv() issue
References: <4ae3c140605151657m152c0e7bl7f52e2a2def0aeca@mail.gmail.com>	 <20060516043107.GA5321@taniwha.stupidest.org>	 <4ae3c140605171444o66de4caqdbe38e028aed94bf@mail.gmail.com> <1147975279.3073.4.camel@85.65.211.169.dynamic.barak-online.net>
In-Reply-To: <1147975279.3073.4.camel@85.65.211.169.dynamic.barak-online.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Avishay Traeger wrote:
> On Wed, 2006-05-17 at 17:44 -0400, Xin Zhao wrote:
> 
>>Thank you for your care. What I am trying to do is to rewrite NFS in
>>the virtual machine environment so that network communication can be
>>replaced with inter-VM communication.
>>
>>But after I remove the original rpc stuff, I ran into some strange
>>problem, including this one.  Interesting thing is that I noticed that
>>even with standard NFS implementation, it is still possible that
>>nfsd_read() return resp->count to be 0. At this time, eof is also
>>equal to 1. This seems to be right since NFSD already reach the end of
>>the file. But question is since 0 byte is read this time, NFS should
>>detect EOF in previous read. Why need one more read?
>>
>>Xin
> 
> 
> How are you reading the file?  Some programs (I believe 'cat' is one of
> them) will read a file until 0 is returned.  Try writing a small C
> program to read a file until EOF and see if the behavior changes.

Returning 0 from read() is only situation when you can be sure you are at the 
end of file.  If you get short read(), it may be short due to EOF, but it may be 
short also because some error was hit - EIO and EFAULT are two which can occur 
almost always.  And only next read will either return that error (or some other 
error, or success if error condition disappeared meanwhile), or zero if it is 
really EOF.
								Petr

