Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265446AbTANWrF>; Tue, 14 Jan 2003 17:47:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265457AbTANWrF>; Tue, 14 Jan 2003 17:47:05 -0500
Received: from c16410.randw1.nsw.optusnet.com.au ([210.49.25.29]:29423 "EHLO
	mail.chubb.wattle.id.au") by vger.kernel.org with ESMTP
	id <S265446AbTANWrE>; Tue, 14 Jan 2003 17:47:04 -0500
From: Peter Chubb <peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15908.38251.398048.612268@wombat.chubb.wattle.id.au>
Date: Wed, 15 Jan 2003 09:55:39 +1100
To: root@chaos.analogic.com
Cc: DervishD <raul@pleyades.net>, Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Changing argv[0] under Linux.
In-Reply-To: <122203493@toto.iv>
X-Mailer: VM 7.07 under 21.4 (patch 10) "Military Intelligence" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Richard" == Richard B Johnson <root@chaos.analogic.com> writes:

Richard> On Tue, 14 Jan 2003, DervishD wrote:
>> Hi Richard :)
>> 
>>>> Any header where I can see the length for argv[0] or is this SOME
>>>> kind of unoficial standard? Just doing strcpy seems dangerous to
>>>> me  (you can read 'paranoid'...).  

>> They need to have space for _POSIX_PATH_MAX (512 bytes), to claim POSIX
>> compatibility so any POSIX system will have at  least 512 bytes
>> available because the pathname of the executable normally goes
>> there.

No, because argv[0] is followed immediately  by a NUL then argv[1],
then argv[2], etc.  They're not fixed length strings -- the kernel
allocates just enough for the actual arguments, rounded up to
PAGESIZE.

So if you copy more than strlen(argv[0]), you'll start overwriting
argv[1].

--
Dr Peter Chubb				    peterc@gelato.unsw.edu.au
You are lost in a maze of BitKeeper repositories, all almost the same.
