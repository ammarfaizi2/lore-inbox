Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265563AbUBFR6p (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 12:58:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265579AbUBFR6p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 12:58:45 -0500
Received: from chaos.analogic.com ([204.178.40.224]:51328 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S265563AbUBFR6i
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 12:58:38 -0500
Date: Fri, 6 Feb 2004 13:00:38 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Roland Dreier <roland@topspin.com>
cc: "Hefty, Sean" <sean.hefty@intel.com>, Troy Benjegerdes <hozer@hozed.org>,
       infiniband-general@lists.sourceforge.net,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Infiniband-general] Getting an Infiniband access layer in
 theLinux kernel
In-Reply-To: <52smhounpn.fsf@topspin.com>
Message-ID: <Pine.LNX.4.53.0402061258110.4045@chaos>
References: <C1B7430B33A4B14F80D29B5126C5E9470326258C@orsmsx401.jf.intel.com>
 <Pine.LNX.4.53.0402061150100.3862@chaos> <52smhounpn.fsf@topspin.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Feb 2004, Roland Dreier wrote:

>     Richard> If some major changes are being considered, I think it's
>     Richard> time to get rid of the:
>
>     Richard> do { } while(0) stuff that permiates a lot of MACROS and
>     Richard> just use the { } as they were designed.
>
>     Richard> Before everybody screams, think. It's perfectly correct
>     Richard> to start a new "program unit" without a conditional
>     Richard> expression.  You just add a curley-brace, then close the
>     Richard> brace when you are though.
>
> This is totally, totally wrong.  If you get rid of do { } while (0),
> then you can't use the macro in an if statement.  Read any C FAQ for
> details, or try the following:
>

Yes you can. You just don't use an ';' if you are going
to use 'else'.


>     #define MAC(x) { x = x + 1; }
>
>     int main() {
>       int x = 0;
>
>       if (1)
>         MAC(x);
>       else
>         x = x - 1;
>     }
>
> I get the following (correct) error:
>
>     $ gcc a.c
>     a.c: In function `main':
>     a.c:8: syntax error before "else"
>     $ gcc --version
>     gcc (GCC) 3.2.3 20030502 (Red Hat Linux 3.2.3-20)
>
> because
>
>     if (1)
>         { x = x + 1 } ; /* <-- note semicolon
>     else
>         x = x - 1;
>
> is not correct C.
>

As I stated.


> By the way, it is possible to use parentheses and commas for some
> simple macros, so for example the following is OK:
>
>     #define MAC(x) ( x = x + 1, x = x * 2 )
>
>     int main() {
>       int x = 0;
>
>       if (1)
>         MAC(x);
>       else
>         x = x - 1;
>     }
>
> However I don't see anything wrong with the perfectly standard "do { }
> while (0)" idiom.  Certainly if some compiler generates worse code for
> that construct that just a plain { }, _that_ is a compiler bug that we
> shouldn't have to work around.
>
>  - Roland
>



Cheers,
Dick Johnson
Penguin : Linux version 2.4.24 on an i986 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


