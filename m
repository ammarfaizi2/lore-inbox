Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268062AbTAIW2Z>; Thu, 9 Jan 2003 17:28:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268063AbTAIW2Z>; Thu, 9 Jan 2003 17:28:25 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:14088 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S268062AbTAIW2Y>; Thu, 9 Jan 2003 17:28:24 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: [Linux-fbdev-devel] Re: rotation.
Date: Thu, 9 Jan 2003 22:35:58 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <avktge$22o$1@penguin.transmeta.com>
References: <Pine.LNX.4.44.0301091956140.5660-100000@phoenix.infradead.org> <1042153388.28469.17.camel@irongate.swansea.linux.org.uk>
X-Trace: palladium.transmeta.com 1042151805 13989 127.0.0.1 (9 Jan 2003 22:36:45 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 9 Jan 2003 22:36:45 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <1042153388.28469.17.camel@irongate.swansea.linux.org.uk>,
Alan Cox  <alan@lxorguk.ukuu.org.uk> wrote:
>
>Note btw that the support ends rather abruptly on the console input side.
>There is no support for 3 or 4 byte utf8 input sequences and the delete
>key code in the kernel has no understanding of or support for UTF8
>deletion behaviour

UTF8 delete behaviour should be pretty trivial to add.  It's liketly to
be more involved than simply adding a

	/* multi-char UTF8 thing? Continue until we hit the first one */
	if (tty->utf8 && (c & 0x80) && !(c & 0x40))
		continue;

to the loop in n_tty.c: eraser(), but it might not be _much_ more than
that. 

		Linus
