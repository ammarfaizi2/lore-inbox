Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279180AbRKAPf7>; Thu, 1 Nov 2001 10:35:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279170AbRKAPft>; Thu, 1 Nov 2001 10:35:49 -0500
Received: from chaos.analogic.com ([204.178.40.224]:13954 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S279157AbRKAPfi>; Thu, 1 Nov 2001 10:35:38 -0500
Date: Thu, 1 Nov 2001 10:34:53 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: vda <vda@port.imtp.ilyichevsk.odessa.ua>
cc: Tim Schmielau <tim@physik3.uni-rostock.de>,
        Andreas Dilger <adilger@turbolabs.com>, linux-kernel@vger.kernel.org,
        J Sloan <jjs@lexus.com>
Subject: Re: [Patch] Re: Nasty suprise with uptime
In-Reply-To: <01110116355201.01137@nemo>
Message-ID: <Pine.LNX.3.95.1011101102602.30559A-101000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1678434306-1308609190-1004628893=:30559"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--1678434306-1308609190-1004628893=:30559
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Thu, 1 Nov 2001, vda wrote:

> On Thursday 01 November 2001 00:52, Tim Schmielau wrote:
> 
> > OK, absolutely last patch for today. Sorry to bother everyone, but the
> > jiffies wraparound logic was broken in the previous patch.
> >
> > As stated before, I would kindly ask for widespread testing PROVIDED IT IS
> > OK FOR YOU TO RISK THE STABILITY OF YOUR BOX!
> 
> I see you dropped jiffies_hi update in timer int.
> IMHO argument on wasting 6 CPU cycles or so per each timer int:
> 
> -	jiffies++;
> +	if(++jiffies==0) jiffies_hi++;
> 
> is not justified. I'd rather see simple and correct code in timer int
> rather than jumping thru the hoops in get_jiffies_64().
> 
> For CPU cycle saving zealots: I advocate saving 2 static longs in get_jiffies
> instead :-)
> --
> vda
> -

Well not exactly zealots. I test a lot of stuff. In fact, the code
you propose:

	if(++jiffies==0) jiffies_hi++;

... actually works quite well:

Script started on Thu Nov  1 10:23:54 2001
# ./chk
Simple bump = 13
Bump chk and incr = 15
# ./chk
Simple bump = 13
Bump chk and incr = 15
# ./chk
Simple bump = 13
Bump chk and incr = 15
# exit
exit
Script done on Thu Nov  1 10:24:08 2001

It adds only two CPU clock cycles if (iff) the 'C' compiler is
well behaved.

Test code is appended. In the test code, I calculate everything, then
print the results. This is so the 'C' library + system call doesn't
mess up the cache. Note this if you use this as a template to test
other questionable code snippets.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


--1678434306-1308609190-1004628893=:30559
Content-Type: APPLICATION/octet-stream; name="test_jiff.tar.gz"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.3.95.1011101103453.30559B@chaos.analogic.com>
Content-Description: 

H4sIAGZp4TsAA+2WUW/bNhDH/Sp+ikODADESa5Jlx0OyDEP7MKxAt6FpsZcB
AS2eLC40aZCUnaDod99RlmPH6ZYNmFsU4w+BI979eTzpKOo8On/zh6yqb3oH
A0bZZDyGHgSyvf/dACbFJBuej0bjCUCeZ0XRg/HhUtrSOM8tQM8a4/9O95z/
K8U/1N8K78r0+gBr5FlGhf3L+ud5PtrUPx8Nz8kyLM7zHmQHyOUJ//P6H7Gj
5F0tHdBfZRHBmcqvuEVYWek9apjew1tZ1twKeJnCa1NrZ3QKPxuaWZrFvZWz
2ofppeJyjiKFn9ohV86ANh5mDbdce0QB3oAwwPW9r6WeUYDGYdWolFEajKWC
e84Ud15dJKkyepZk7bDeDlOPd56lXMmZTr5NWDpTZqoSL+fkul8ghMsfqkaX
XhrNQmCAt+gbq8HXCK9+fU+JmvIWBG16tKhLhCn6FdKtuqYs0Tm5RCi5Ui7k
ReEukkXjapUc4/SOJe17wpK5WaqkzfUMgiNJjuBH9BBMoMwKQsIrY8WOtA7S
8rG0pse3rz1GfnfWulXQXvOQUGMp2U+GPkbRyesn8r3wrpmu7yNkwttMXnXK
QRuBJNNWUrYScbeOOKf9IH0NU2OtWbFkYRYPzwOpHqgFY196L0f+Pdvz/w2/
xUoq/O/XeOb8p+P+/OH7XwyLYBgXk3j+fw4YnXMXSVnfMkY/7VVaQtcLsGRW
ljD4jTQwMEA+GPwy3Hih1dI8hVxf0EEwh0EFbagvfVeRf8r2/W+reZA1nuv/
siLfvv+j0P8Ps2IY3//PwZHUpWoEwnfOC2nS+nu2a7LUpgUbWxrFPX0d2l4C
woaR6C4/bb6p5SVj1KchNV2to/2hTupkaaTok1NSwzHnUp/02QcWNsFWZpZo
a+Tics/u5HyhcN86beaLG9q6FDM41guElfpr5SYaXMGOdeeyy/n0dD1cr/JY
/SSorE5OT7uJcHUFWZ9tvmXbR7CJuMnwccxuHYDB1d4dP+ifeBZUDV+dvLhe
zw1CCnqslPhdvzjrQvYfa18GUYjGtQAqrN2dsVmqm2PXbXJ2yT7GIzwSiUQi
kUgkEolEIpFIJBKJRCKRr5g/AR31gEsAKAAA
--1678434306-1308609190-1004628893=:30559--
