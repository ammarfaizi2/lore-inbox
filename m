Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314717AbSD2Al7>; Sun, 28 Apr 2002 20:41:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314715AbSD2Al6>; Sun, 28 Apr 2002 20:41:58 -0400
Received: from mail.webmaster.com ([216.152.64.131]:35583 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP
	id <S314711AbSD2Al5> convert rfc822-to-8bit; Sun, 28 Apr 2002 20:41:57 -0400
From: David Schwartz <davids@webmaster.com>
To: <linux-kernel@vger.kernel.org>
X-Mailer: PocoMail 2.61 (1025) - Licensed Version
Date: Sun, 28 Apr 2002 17:41:52 -0700
In-Reply-To: <20020425.194301.90782367.davem@redhat.com>
Subject: Re: Possible bug with UDP and SO_REUSEADDR.
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Message-ID: <20020429004153.AAA18838@shell.webmaster.com@whenever>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 25 Apr 2002 19:43:01 -0700 (PDT), David S. Miller wrote:
>From: Terje Eggestad <terje.eggestad@scali.com>
>Date: 25 Apr 2002 14:37:44 +0200
>
>However writing a test server that stand in blocking wait on a UDP
>socket, and start two instances of the server it's ALWAYS the server
>last started that get the udp message, even if it's not in blocking
>wait, and the first started server is.
>
>Smells like a bug to me, this behavior don't make much sence.
>
>Using stock 2.4.17.
>
>Can you post your test server/client application so that I
>don't have to write it myself and guess how you did things?

	There are really two possibilities:

	1) The two instances are cooperating closely together and should be sharing 
a socket (not each opening one), or

	2) The two instances are not cooperating closely together and each own their 
own socket. For all the kernel knows, they don't even know about each other.

	In the first case, it's logical for whichever one happens to try to read 
first to get the/a datagram. In the second case, it's logical for the kernel 
to pick one and give it all the data.

	DS


