Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267605AbSLNMkJ>; Sat, 14 Dec 2002 07:40:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267606AbSLNMkJ>; Sat, 14 Dec 2002 07:40:09 -0500
Received: from 195-219-31-160.sp-static.linix.net ([195.219.31.160]:9088 "EHLO
	r2d2.office") by vger.kernel.org with ESMTP id <S267605AbSLNMkI>;
	Sat, 14 Dec 2002 07:40:08 -0500
Message-ID: <3DFB2859.80401@walrond.org>
Date: Sat, 14 Dec 2002 12:47:21 +0000
From: Andrew Walrond <andrew@walrond.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021020
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Joseph Fannin <jhf@rivenstone.net>, linux-kernel@vger.kernel.org
Subject: Re: Symlink indirection
References: <3DF9F780.1070300@walrond.org> <mailman.1039792562.8768.linux-kernel2news@redhat.com> <200212131616.gBDGGH302861@devserv.devel.redhat.com> <3DFA0F6D.1010904@walrond.org> <20021213115508.A16493@devserv.devel.redhat.com> <3DFA130C.1030106@walrond.org> <20021214055716.GA14721@zion.rivenstone.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Joseph Fannin wrote:
> 
>     I don't understand what you are trying to explain.  Do you mean a
> union mount, or a variation thereof?
> 
>     I thought Al Viro was going to do union mount support for 2.5, but
> I haven't heard about it in a while.  Maybe it went in and no one noticed?
> 

Hi Joseph

I'm not familiar with the phrase 'union mount' and although google gives 
wads of hits, I can't find a good description of it

What I mean is (contrived example with made-up mount option --overlay)

mkdir a
echo "a/x" > a/x
echo "a/y" > a/y
echo "a/z" > a/z

mkdir b
echo "b/y" > b/y

mkdir c
echo "c/z" > c/z

mkdir d
mount --bind a d
mount --bind --overlay b d
mount --bind --overlay c d

cat d/x
"a/x"

cat d/y
"b/x"

cat d/z
"c/z"

This would be *really* useful and nice. I currently emulate this 
behavior with a bash script which creates hard or soft links, but the 
mounting system would be much nicer, easier to unwind etc.

I assume this isn't possible now (man mount gives no hint), but how 
feasible is it? Has anybody tried to implement this? If yes and No 
perhaps I could (with some initial guidance) have a look at implementing 
this.

I don't use HD's much anymore, so it would need to work for tmpfs.

