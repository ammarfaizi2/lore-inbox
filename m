Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261520AbSJ1Xix>; Mon, 28 Oct 2002 18:38:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261521AbSJ1Xiw>; Mon, 28 Oct 2002 18:38:52 -0500
Received: from mtao-m02.ehs.aol.com ([64.12.52.8]:60288 "EHLO
	mtao-m02.ehs.aol.com") by vger.kernel.org with ESMTP
	id <S261520AbSJ1Xiv>; Mon, 28 Oct 2002 18:38:51 -0500
Date: Mon, 28 Oct 2002 15:45:06 -0800
From: John Gardiner Myers <jgmyers@netscape.com>
Subject: Re: and nicer too - Re: [PATCH] epoll more scalable than poll
In-reply-to: <20021028220809.GB27798@outpost.ds9a.nl>
To: bert hubert <ahu@ds9a.nl>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-aio@kvack.org, lse-tech@lists.sourceforge.net
Message-id: <3DBDCC02.6060100@netscape.com>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.2b)
 Gecko/20021016
References: <20021028220809.GB27798@outpost.ds9a.nl>
 <Pine.LNX.4.44.0210281420540.966-100000@blue1.dev.mcafeelabs.com>
 <20021028225821.GA29868@outpost.ds9a.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

bert hubert wrote:

>The interface is also lovely:
>  
>
The code you wrote has the standard epoll race condition.  If the file 
descriptor 's' becomes readable before the call to sys_epoll_ctl, 
sys_epoll_wait() will never return the socket.  The connection will hang 
and the file descriptor will effectively leak.

As you have amply demonstrated, the current epoll API is error prone. 
 The API should be fixed to test the poll condition and, if necessary, 
drop an event upon insertion to the set.


