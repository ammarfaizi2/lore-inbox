Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130733AbRCGJd2>; Wed, 7 Mar 2001 04:33:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130826AbRCGJdT>; Wed, 7 Mar 2001 04:33:19 -0500
Received: from eschelon.gamesquad.net ([216.115.239.45]:9489 "HELO
	eschelon.gamesquad.net") by vger.kernel.org with SMTP
	id <S130733AbRCGJdE>; Wed, 7 Mar 2001 04:33:04 -0500
From: "Vibol Hou" <vhou@khmer.cc>
To: "Mike Galbraith" <mikeg@wen-online.de>, "Vibol Hou" <vhou@khmer.cc>
Cc: "Linux-Kernel" <linux-kernel@vger.kernel.org>, <andrewm@uow.edu.au>,
        <balbir@reflexnet.net>, <hahn@coffee.psychology.mcmaster.ca>
Subject: RE: System slowdown on 2.4.2-ac5 (recurring from 2.4.1-ac20 and 2.4.0)
Date: Wed, 7 Mar 2001 01:31:49 -0800
Message-ID: <NDBBKKONDOBLNCIOPCGHKEFAFDAA.vhou@khmer.cc>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
In-Reply-To: <Pine.LNX.4.33.0103070939011.1305-100000@mikeg.weiden.de>
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You're right,

It looks like it says NMI Watchdog LOCKUP CPU0.  I didn't think much of it,
but I suspected someone see that piece.  Now, I have the tasklist from the
lockup that occured 3 days before this one:

httpd     S CE4F3F28   148 28524  22643        (NOTLB)   28569 28523
Call Trace: [<c011473a>] [<c0114664>] [<c014276e>] [<c0142b12>] [<c013af14>]
[<c0108ehNMdoIg  Wa0[<02cb01>]00 02ebte>]ct ed
 LhOCttKUpdP  o  n   CPUS0, 7 rFeFFgiFsFFteF rs :
   0 CP U :0
   E IP0
:  E I 0P:        0  01 0:(N[<OcTL01B0) 7e4  1>28]
570EF 2LA85G2S:4
 00C00al0l0 8T7
racea4ax2:[11<4c601d714>]6 d7 >] e bx[:< cf0173cc6d00b700> ]   e[<cxc0:1
ff7b8820d6>a8] 0  [ <ced01x:db 080f06>0]00 0[0
<c01ec1seif: 80c100ef[5><]c0 1f 2 ef5d5i>: ] f7[3c<0c0001c0 3 fb e1>b]p:  c
02 8a  42  0     [es<pc:01 fc7403cb1e>ef]c
[<c d0s:01 800  18 e  s ][ <c 01000818ec b  >]ss :
 00h1t8t
pdssPr kolcesZsA 0F7 Ag7dF3 (A0p id    18 04, 2 s85t7ac0 kp 2ag2e64=f3 73 c
10  00  )
StacStka: ck:  c10fe1f06e0

What would cause the NMI Watchdog to fire?

-Vibol

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of Mike Galbraith
Sent: Wednesday, March 07, 2001 12:48 AM
To: Vibol Hou
Cc: Linux-Kernel; andrewm@uow.edu.au; balbir@reflexnet.net;
hahn@coffee.psychology.mcmaster.ca
Subject: Re: System slowdown on 2.4.2-ac5 (recurring from 2.4.1-ac20 and
2.4.0)


On Tue, 6 Mar 2001, Vibol Hou wrote:

> Hi,
>
> This is a follow up report on a server I run which is now using 2.4.2-ac5.
> It was suggested that the problem might be a NIC driver issue, but that
> seems unlikely at this point.
>
> You can find my previous posts at the following links to get a better idea
> of what I am encountering:
>
> http://www.uwsg.indiana.edu/hypermail/linux/kernel/0101.3/0470.html
> http://www.uwsg.indiana.edu/hypermail/linux/kernel/0102.3/0401.html
>
> The problem still persists with the new 2.4.2-ac5 kernel, and I have a
> feeling it has to do with the VM subsystem.  The system runs Apache,
MySQL,
> and Sendmail.  It has ~900MB RAM.  The first lockup in 2.4.2-ac5 occured

Hi,

This portion of your log...

httpd     S 7FFFFFFF  3700 15058   1684        (NOTLB)   15061 15055
Call Trace: [<IN MWaI tcWahtdochg do[] <ce01ted9c9t2edd> L] OC[K<UPc0 o1ndb
1CPadU0>],  re[<gic0st1e1r3bsf:
8>] C[<c<c001f1f2f2afa66>>]]  [ <  c0 01c013f05:[5<>]c 010[<7ec0411>c4]3
8d>EF] LA
GS:  0  00  00 0 8[7
<c0 eac0x:2 8ac042208a[>]<c 0 13 e32bxd3: >]ce 8[4a<c00010 26  e6ec0>x:]
f7[<94ce0013803 43  5>ed]x : [0<0c00010008e00c
b>] e
i:dht  tp  d   0 0     Se dDi:7 A4ce3F8428a0 00       0eb 1p:5 0c601 28 a
412680 4    es  p:    ce8 (4NbeOTfLc
B) ds: 0018   es: 0018   ss: 0018

...leads me to believe that the NMI-Watchdog fired.  (I think that points
the finger away from VM, but..)  It looks like it's saying that a lock
of cpu 0 was detected if I squint at it right.  It's too munged to tell.

	-Mike

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

