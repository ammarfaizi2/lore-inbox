Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132894AbRAJWVp>; Wed, 10 Jan 2001 17:21:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132366AbRAJWVf>; Wed, 10 Jan 2001 17:21:35 -0500
Received: from p3EE3CB90.dip.t-dialin.net ([62.227.203.144]:58897 "HELO
	emma1.emma.line.org") by vger.kernel.org with SMTP
	id <S132930AbRAJWV1>; Wed, 10 Jan 2001 17:21:27 -0500
Date: Wed, 10 Jan 2001 23:21:23 +0100
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: antirez <antirez@invece.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: * 4 converted to << 2 for networking code
Message-ID: <20010110232123.A9585@emma1.emma.line.org>
Mail-Followup-To: antirez <antirez@invece.org>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20010110174859.R7498@prosa.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010110174859.R7498@prosa.it>; from antirez@invece.org on Wed, Jan 10, 2001 at 17:48:59 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Jan 2001, antirez wrote:

> Hi all,
> 
> The attached patch converts many occurences of '* 4' in the networking code
> (often used to convert in bytes the TCP data offset and the IP header len)
> to the faster '<< 2'. Since this was a quite repetitive work it's better
> if someone double-check it before to apply the patch.
> The patch is for linux-2.4.
> 
> Please, CC: me for replies since I'm not subscribed to the list.

You'd better be. As Alan Cox pointed out some time ago, this is the
compiler's duty, to be more precise, it's the peephole (local)
optimizer's task, if it's actually implemented in the core or the
backend, I cannot currently tell, and I don't care.

But see a minimal program 
main(int argc) {
        j(argc * 4);
}

run gcc -O2 -S thissource.c and then -O0 and compare. On an
amigaos-m68k configured gcc 2.7.2.3, this directly throws asll #2,d0
(arithmetic shift left by 2 positions, fill with trailing zeroes), -O2
saves some moving around. (I cannot read 386 assembly language, thus
m68k ;)
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
