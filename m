Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135904AbREBU5K>; Wed, 2 May 2001 16:57:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135936AbREBU5C>; Wed, 2 May 2001 16:57:02 -0400
Received: from zeus.kernel.org ([209.10.41.242]:7305 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S135958AbREBU4p>;
	Wed, 2 May 2001 16:56:45 -0400
X-Envelope-From: news@bytesex.org
To: linux-kernel@vger.kernel.org
Path: kraxel
From: Gerd Knorr <kraxel@bytesex.org>
Newsgroups: lists.linux.kernel
Subject: Re: Problem with map_user_kiobuf() not mapping to physical memory
Date: 2 May 2001 19:17:51 GMT
Organization: [x] network byte order
Message-ID: <slrn9f0nav.18a.kraxel@bytesex.org>
In-Reply-To: <3AF028D3.8EE24BE1@beam.demon.co.uk>
NNTP-Posting-Host: localhost
X-Trace: bytesex.org 988831071 1291 127.0.0.1 (2 May 2001 19:17:51 GMT)
User-Agent: slrn/0.9.7.0 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  to the driver which performs a map_user_kiobuf() on it, the resulting
>  kiobuf
>  structure has all of the pagelist[] physical address entries set to the
>  same value
>  and the maplist[] entries set to 0. The devices access to this memory
>  now
>  causes system problems.
>  Is map_user_kiobuf() working correctly ?

Yes, it is.  You have to lock down the pages for I/O with
lock_kiovec() before using the maplist.  The locking will
also fault the pages if needed.

  Gerd

-- 
sigfault (core dumped)
