Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317451AbSFHVfz>; Sat, 8 Jun 2002 17:35:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317454AbSFHVfy>; Sat, 8 Jun 2002 17:35:54 -0400
Received: from webmail6.rediffmail.com ([202.54.124.151]:5355 "HELO
	webmail6.rediffmail.com") by vger.kernel.org with SMTP
	id <S317451AbSFHVfx>; Sat, 8 Jun 2002 17:35:53 -0400
Date: 8 Jun 2002 21:35:27 -0000
Message-ID: <20020608213527.28801.qmail@webmail6.rediffmail.com>
MIME-Version: 1.0
From: "tushar  korde" <tushar_k5@rediffmail.com>
Reply-To: "tushar  korde" <tushar_k5@rediffmail.com>
To: linux-kernel@vger.kernel.org
Content-type: text/plain;
	format=flowed
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi folks,
 	as kmalloc allocates memory in power of 2 ( starting from 32 )
instead of the size requested. there are following problems :

  1) we are allocating at least 32 bytes in all cases ( most of 
the times it is not
required ).

  2) if we allocate large memory, internal fregmentation also 
increases.

  3) allocating more memory then the request often leads to 
programming errors
esp. when we store some data and read it back or try to get size 
of data stored
  ( though it can be handled but we have to take special care of 
it at every point ).

the solution to above problems may be that we dont allocate 
objects from the 13
general purpose caches, instead we make a new cache keep its 
address either in
cache_sizes or declare it global. now as the kmalloc is invoked 
check the memory size
requested if predefined sizes are not suitable then make a new 
object of the size
requested ( now here the definition of c_offset flag of cache 
descriptor may be
violated ) and allot it to our new cache and return it .

 	i know that there may be subtle problems in it's 
implementation.
i need your suggestions. is it worth to make efforts in this 
field.

keenly waitinf for ur reply
tushar korde
_________________________________________________________
Click below to visit monsterindia.com and review jobs in India or 
Abroad
http://monsterindia.rediff.com/jobs

