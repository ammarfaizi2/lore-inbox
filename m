Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319267AbSIKSin>; Wed, 11 Sep 2002 14:38:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319272AbSIKSin>; Wed, 11 Sep 2002 14:38:43 -0400
Received: from pD4B9D6F0.dip.t-dialin.net ([212.185.214.240]:46596 "EHLO
	router.abc") by vger.kernel.org with ESMTP id <S319267AbSIKSil> convert rfc822-to-8bit;
	Wed, 11 Sep 2002 14:38:41 -0400
Message-ID: <3D7F8ECA.21086A5@baldauf.org>
Date: Wed, 11 Sep 2002 20:43:22 +0200
From: Xuan Baldauf <xuan--reiserfs@baldauf.org>
X-Mailer: Mozilla 4.79 [en] (Win98; U)
X-Accept-Language: de-DE,en
MIME-Version: 1.0
To: Oliver Neukum <oliver@neukum.name>
CC: Rik van Riel <riel@conectiva.com.br>,
       Xuan Baldauf <xuan--lkml@baldauf.org>, linux-kernel@vger.kernel.org,
       Reiserfs List <reiserfs-list@namesys.com>
Subject: Re: Heuristic readahead for filesystems
References: <Pine.LNX.4.44L.0209111340060.1857-100000@imladris.surriel.com> <3D7F83BC.5DF306A@baldauf.org> <200209112030.27269.oliver@neukum.name>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Oliver Neukum wrote:

> > In theory, this also could be implemented explicitly if the application
> > could tell the kernel "I'm going to read these 100 files in the very
> > near future, please make them ready for me". But wait, maybe the
> > application can do this (for regular files, not for directory entries
> > and stat() data): Could it be efficient if the application used
> > open(file,O_NONBLOCK) for the next 100 files and subsequent read()s on
> > each of the returned filedescriptors?
>
> What do you want to trigger the reading ahead, open() or read() ?

As open() immediately returns, it does not matter by which call the readahead is
triggered. But I'm unsure about wether it is triggered at all for the amount of
data the read() requested.

>
> Please correct me, if I am wrong, but wouldn't read() block ?

AFAIK, "man open" tells

[...]
      int open(const char *pathname, int flags);
[...]
       O_NONBLOCK or O_NDELAY
               The file is opened in non-blocking mode. Neither the open nor any
__subsequent__ operations  on  the  file  descriptor
               which is returned will cause the calling process to wait.
[...]

So read won't block if the file has been opened with O_NONBLOCK.


>
>
> Aio should be able to do it. But even that want help you with the stat data.

Aio would help me announcing stat() usage for the future?

>
>
>         Regards
>                 Oliver

Xuân.


