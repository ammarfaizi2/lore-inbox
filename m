Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131653AbRCXMjn>; Sat, 24 Mar 2001 07:39:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131654AbRCXMje>; Sat, 24 Mar 2001 07:39:34 -0500
Received: from zooty.lancs.ac.uk ([148.88.16.231]:51694 "EHLO
	zooty.lancs.ac.uk") by vger.kernel.org with ESMTP
	id <S131653AbRCXMjQ> convert rfc822-to-8bit; Sat, 24 Mar 2001 07:39:16 -0500
Message-Id: <l03130316b6e24383c538@[192.168.239.101]>
In-Reply-To: <Pine.LNX.4.21.0103240355560.1863-100000@imladris.rielhome.conectiva>
In-Reply-To: <l03130311b6e19132f3bf@[192.168.239.101]>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Date: Sat, 24 Mar 2001 12:38:01 +0000
To: Rik van Riel <riel@conectiva.com.br>
From: Jonathan Morton <chromi@cyberspace.org>
Subject: Re: [PATCH] Prevent OOM from killing init
Cc: Andries.Brouwer@cwi.nl, alan@lxorguk.ukuu.org.uk,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 6:58 am +0000 24/3/2001, Rik van Riel wrote:
>On Sat, 24 Mar 2001, Jonathan Morton wrote:
>
>> Hmm...  "if ( freemem < (size_of_mallocing_process / 20) )
>>fail_to_allocate;"
>>
>> Seems like a reasonable soft limit - processes which have already got
>> lots of RAM can probably stand not to have that little bit more and
>> can be curbed more quickly.
>
>This looks like it could nicely in preventing a single process
>from getting out of hand and gobbling up all memory.
>
>It won't prevent the system from a mongolian horde of processes,
>but nobody should expect your one-liner to fix world piece ;)
>
>I like it, now lets test it ;)

I thought of some things which could break it, which I want to try and deal
with before releasing a patch.  Specifically, I want to make freepages.min
sacrosanct, so that malloc() *never* tries to use it.  This should be
fairly easy to implement - simply subtract freepages.min from the freemem
part.  An even nicer way would be to subtract freepages.low (or some
similar value) instead of freepages.min for non-root or non-privileged
processes.

BTW, is the 'current' pointer always valid when vm_enough_memory() is
called?  If so, I can remove one redundant check.

My NetBSD friend appears to have found code in the BSD kernel which sets up
ulimit values sensibly by default - eg. it's not handled by the boot
scripts.  Presumably a root process is capable of changing the limits, but
I'm guessing that sensible defaults in the kernel have to be a Good ThingÅ.
Comments?

--------------------------------------------------------------
from:     Jonathan "Chromatix" Morton
mail:     chromi@cyberspace.org  (not for attachments)
big-mail: chromatix@penguinpowered.com
uni-mail: j.d.morton@lancaster.ac.uk

The key to knowledge is not to rely on people to teach you it.

Get VNC Server for Macintosh from http://www.chromatix.uklinux.net/vnc/

-----BEGIN GEEK CODE BLOCK-----
Version 3.12
GCS$/E/S dpu(!) s:- a20 C+++ UL++ P L+++ E W+ N- o? K? w--- O-- M++$ V? PS
PE- Y+ PGP++ t- 5- X- R !tv b++ DI+++ D G e+ h+ r++ y+(*)
-----END GEEK CODE BLOCK-----


