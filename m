Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272052AbRH2TMe>; Wed, 29 Aug 2001 15:12:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272056AbRH2TMY>; Wed, 29 Aug 2001 15:12:24 -0400
Received: from wildsau.idv-edu.uni-linz.ac.at ([140.78.40.25]:46087 "EHLO
	wildsau.idv-edu.uni-linz.ac.at") by vger.kernel.org with ESMTP
	id <S272052AbRH2TMN>; Wed, 29 Aug 2001 15:12:13 -0400
From: Herbert Rosmanith <herp@wildsau.idv-edu.uni-linz.ac.at>
Message-Id: <200108291911.f7TJBvX11490@wildsau.idv-edu.uni-linz.ac.at>
Subject: Re: [IDEA+RFC] Possible solution for min()/max() war
In-Reply-To: <200108291905.f7TJ59T11456@wildsau.idv-edu.uni-linz.ac.at> from Kernel Mailing List at "Aug 29, 1 09:05:09 pm"
To: linux-kernel@vger.kernel.org
Date: Wed, 29 Aug 2001 21:11:57 +0200 (MET DST)
X-Mailer: ELM [version 2.4ME+ PL37 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Helge Hafting <helgehaf@idb.hist.no>
> X-Mailer: Mozilla 4.76 [no] (X11; U; Linux 2.4.10-pre1 i686)
> X-Accept-Language: no, en
> To: Brad Chapman <kakadu_croc@yahoo.com>, linux-kernel@vger.kernel.org
> Subject: Re: [IDEA+RFC] Possible solution for min()/max() war
> References: <20010828204207.12623.qmail@web10908.mail.yahoo.com>
> Sender: linux-kernel-owner@vger.kernel.org
> Precedence: bulk
> X-Mailing-List: 	linux-kernel@vger.kernel.org
> 
> Brad Chapman wrote:
> > 
> > Then why, IIRC, are the kernel hackers so upset about how
> > the three-arg macros _prevent_ signed/unsigned comparisons?
> > Apparently the ability to compare
> > signed/unsigned variables must have _some_ significance....
> 
> You are misunderstanding this.
> It is possible to write something that _looks like_ a signed to unsigned
> comparison, i.e.:
> int a;
> unsigned int b;
> ...
> x = min(a,b);
> 
> Looks like a signed to unsigned comparison - but it isn't!
> 
> You see, the compiler always does an _implicit_ cast in cases like this.
                             ^^^^^^^^^^^^^^^^^^^^^

if that's your concern, we can easily fix this by still moving min/max
to its same form.


#define type_min(type,x,y) \
        ({ type __x = (x), __y = (y); __x < __y ? __x: __y; })
#define type_max(type,x,y) \
        ({ type __x = (x), __y = (y); __x > __y ? __x: __y; })

#define min(x,y) type_min(typeof(x),x,y)
#define max(x,y) type_max(typeof(x),x,y)

no _implicit_ cast and ...

> One of the arguments gets changed invisibly, and that is what kernel
> developers are so upset about.  You don't really know which one without
> thinking hard about it, and that is a source of many hard-to-find bugs.

... joy, we would even know which one.


-- 
mfg,
Dipl.-Ing. H.Rosmanith                    Karrer & Partner Gesellschaft mbH
Freistaedter Str. 236, A-4040 Linz,                   Tel. +43/732/75 71 30
                                                      Fax. +43/732/75 71 44

