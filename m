Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965038AbVITP0V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965038AbVITP0V (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 11:26:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965037AbVITP0V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 11:26:21 -0400
Received: from trixi.wincor-nixdorf.com ([217.115.67.77]:18869 "EHLO
	trixi.wincor-nixdorf.com") by vger.kernel.org with ESMTP
	id S965039AbVITP0U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 11:26:20 -0400
Message-ID: <433028A3.9090503@wincor-nixdorf.com>
Date: Tue, 20 Sep 2005 17:20:03 +0200
From: Peter Duellings <Peter.Duellings@wincor-nixdorf.com>
Organization: Wincor Nixdorf
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.1) Gecko/20040707
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Benjamin LaHaise <bcrl@kvack.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: kernel error in system call accept() under kernel 2.6.8
References: <43301BC4.9080305@wincor-nixdorf.com> <20050920150755.GH32751@kvack.org>
In-Reply-To: <20050920150755.GH32751@kvack.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ben,

if Log.Log would modify errno the Log.Log debug output should
not be affected since the value of errno - from my understanding -
is copied on the stack *before* Log.Log is called.
Or did I forget something?



Thanx,


Peter


Benjamin LaHaise wrote:
> On Tue, Sep 20, 2005 at 04:25:08PM +0200, Peter Duellings wrote:
> 
>>//accept may return with a protocol error, simply try again
>>while( (n = accept(m_ListenFd, (struct sockaddr *) cliaddr, &len)) < 0)
>>{
>>  Log.Log("Error accept, fd=%d, addrlen=%d, len=%d, errno=%d, %s",
>>m_ListenFd,
>>m_AddrLen, len, errno, strerror_r(errno, l_strebuf, sizeof(l_strebuf)));
>>  if (errno == EPROTO || errno == ECONNABORTED)   //connection already
> 
> 
> Let's see here: what happens if Log.Log() performs a syscall to, say, 
> write out the log message to a buffer?
> 
> 		-ben

