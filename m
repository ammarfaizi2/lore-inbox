Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276350AbRJYVTp>; Thu, 25 Oct 2001 17:19:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276364AbRJYVTf>; Thu, 25 Oct 2001 17:19:35 -0400
Received: from fungus.teststation.com ([212.32.186.211]:36109 "EHLO
	fungus.teststation.com") by vger.kernel.org with ESMTP
	id <S276350AbRJYVTX>; Thu, 25 Oct 2001 17:19:23 -0400
Date: Thu, 25 Oct 2001 23:19:51 +0200 (CEST)
From: Urban Widmark <urban@teststation.com>
To: Samium Gromoff <_deepfire@mail.ru>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.12-ac4 10Mbit NE2k interrupt load kills p166
In-Reply-To: <200110251930.f9PJUJl26883@vegae.deep.net>
Message-ID: <Pine.LNX.4.30.0110252253270.7785-100000@cola.teststation.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Oct 2001, Samium Gromoff wrote:

>        Hello folks...
> 
> 	Host A: p166, ISA NE2K, linux-2.4.12-ac4
> 	Host B: p2-400, rtl-8129, WinXP (heh, not my box though ;)
> 
> 	Load: smbmount connection from host A to the host B, and getting
>      large files.

You don't say if any of the tests you did are related to smbfs. I suspect
this reasoning is completely irrelevant (not, that it has stopped me
before ... :)

smbfs is not the fastest thing around. I think the slowness on some
operations is related to how it waits after sending each request.

     process A				  process B
   get semaphore
   request 4096 bytes			wait on semaphore
   ... wait for network ...
   read packet
   read packet
   read packet
   release semaphore
					get semaphore
					request 4096 bytes

It could send the second request without waiting for the first to complete
(if it knew how to separate the responses). Doing that should speed things
up.

If you play mp3's over smbfs while also doing something else I suppose the
delay could become noticable. I can't explain the other effects, so
possibly this is unrelated to smbfs.

You could make me happy by repeating the tests, but generating the network
load with something else (http?).

/Urban

