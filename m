Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314002AbSDKGhk>; Thu, 11 Apr 2002 02:37:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314003AbSDKGhj>; Thu, 11 Apr 2002 02:37:39 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:51725 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S314002AbSDKGhj>; Thu, 11 Apr 2002 02:37:39 -0400
Message-Id: <200204110634.g3B6YPX08966@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: esger@bumblebeast.com, linux-kernel@vger.kernel.org
Subject: Re: Problem using mandatory locks (other apps can read/delete etc)
Date: Thu, 11 Apr 2002 09:37:37 -0200
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <200204101708.TAA01151@fikkie.vesc.nl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10 April 2002 15:08, E. Abbink wrote:
> I'm trying to solve a problem using mandatory locks but am having some
> difficulty in doing so. (if there's a more appropriate place for
> discussing this please ignore the rest of this post. pointers to that
> place would be appreciated ;) )
>
> my problem:
>
> when I lock a file with a mandatory write lock (ie. fcntl, +s-x bits and
> mand mount option. for code see below) it is still possible:
>
> - for me to rm the file in question
> - for the file to be read by an other process

[snip]

>     lock.l_type = F_WRLCK ;   <================
>     lock.l_whence = SEEK_SET ;
>     lock.l_start = 0 ;
>     lock.l_len = 0 ;
>     lock.l_pid = 0 ; // ignored
>
>     int err = fcntl (fd, F_SETLK, &lock) ;

I know nothing about file locking in Unix, but it looks like you
requested write lock, i.e. forbid writing to a file. Why are you
surprised that reads are allowed?

Probably someone else would comment on why rm is working, though...
--
vda
