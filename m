Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932160AbWFMSy7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932160AbWFMSy7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 14:54:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932164AbWFMSy7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 14:54:59 -0400
Received: from rwcrmhc13.comcast.net ([204.127.192.83]:49568 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S932160AbWFMSy6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 14:54:58 -0400
Message-ID: <448F0893.1080706@comcast.net>
Date: Tue, 13 Jun 2006 14:48:51 -0400
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Thunderbird 1.5.0.2 (X11/20060522)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Packing data in kernel memory
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Is there a way to pack and store arbitrary data in the kernel, or do I
need to roll my own?

As a simple example, let's say I wanted to store 8 elements.  Assume
PAGE_SIZE is 4.  If I store these individually, their size and use is:

ELEM      SIZE    PAGES    USE
[A.]      4        1        4
[B...]    6        2        8
[C]       3        1        4
[D....]   7        2        8
[E]       3        1        4
[F.]      4        1        4
[G......] 9        3       12
[H.....]  8        2        8

TOTAL    44       13       52

2 excess pages, 8 excess units of memory wasted.

Now let's say I used groups of 4 pages:

E                 S   P   U
[A.][H.....]      12   4  16
[B...][C][D....]  16   4  16
[E][F.][G......]  16   4  16
                  44  12  48

1 excess pages, 4 units wasted memory.
- --
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

    Creative brains are a valuable, limited resource. They shouldn't be
    wasted on re-inventing the wheel when there are so many fascinating
    new problems waiting out there.
                                                 -- Eric Steven Raymond

    We will enslave their women, eat their children and rape their
    cattle!
                  -- Bosc, Evil alien overlord from the fifth dimension
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iQIVAwUBRI8IkQs1xW0HCTEFAQJcCxAAnucDd+TBSS7hjHmYMdG64WRHwcidvGkS
prFXPSWKXZh0tTvV5+DGDwUvGeLew1VvEY5IJl7i6ak7V0nehAKuEIdMiL9x1RSI
OeZN2cA/eGl1Bv1r3QJdhutfCPF10yFMEUkkLwa2+z/bbPlN4zdoUaR0yAFRigwL
zuJbOTlrEQcY8lAIlPbtdm+c1mQ+FNfpe7dGEYWwOZZYeE8wglCQbFhzmda9nmP5
fJrod94dJnsGsD03MOs17+0+GaLEWz09KKCjMIXRi9fG4q1N9Kgi/GwH+kUR/Cnq
kT44JgcNIuHYMFVss4qUA+wBit3HuT7zL4U9BhxIMpg7BFaYPVCDD+Lpi4J50WXk
sYJs9GpOHwSAmeK1RQ68FU9iO7HI2g0LPKrAWxXj+nclaMhmBqQAF2Eue7LxnSbm
Cy2Ne3nWIPnIFA4y76L8VslsYgFhaBdrzydIHKTH/mqDHWvNMDmcCy6sSnueGXOR
qBopgebvKRpnCtwQvpQ+RgwvGx7/XyftP+W+Lag5BCC1yezP6vk7HDj1lvKrrKVf
kyGNcNx0t3yWnSqeJC1M8nOdpSfHsuDjoG03HdPcmdurQdaGtUmA5k37GpjvATBf
1JAst4FXf9LWJ8mwQakbp7r4vUrEyfMfub9J/j2u1zxq37bJCyAs6jxb5D7YmSno
zzV/7vqPdU0=
=kiK1
-----END PGP SIGNATURE-----
