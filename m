Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310190AbSFXKr0>; Mon, 24 Jun 2002 06:47:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312254AbSFXKrZ>; Mon, 24 Jun 2002 06:47:25 -0400
Received: from smtp2.tivoli.com ([216.140.178.3]:35807 "HELO smtp2.tivoli.com")
	by vger.kernel.org with SMTP id <S310190AbSFXKrY>;
	Mon, 24 Jun 2002 06:47:24 -0400
Message-ID: <3D16F252.90309@tiscalinet.it>
Date: Mon, 24 Jun 2002 12:20:02 +0200
From: "Salvatore D'Angelo" <dangelo.sasaman@tiscalinet.it>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc2) Gecko/20020513 Netscape/7.0b1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris McDonald <chris@cs.uwa.edu.au>
CC: linux-kernel@vger.kernel.org
Subject: Re: gettimeofday problem
References: <3D16DE83.3060409@tiscalinet.it> <200206240934.g5O9YL524660@budgie.cs.uwa.edu.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In this piece of code I convert seconds and microseconds in 
milliseconds. I think the problem is not in my code, in fact I wrote the 
following piece of code in Java, and it does not work too. In the for 
loop the 90% of times b > a while for 10% of times not.

    class Prova {
          public static void main(....) {
               for (;;) {
                    long a = System.currentTimeMillis();
                    long b = System.currentTimeMillis();

                    if (a > b) {
                         System.out.println("Wrong!!!!!!!!!!!!!");
                    }
               }
          }
    }


Chris McDonald wrote:

>In linux.kernel you write:
>
>  
>
>>Hi,
>>    
>>
>
>  
>
>>I am writing a small piece of code that use the gettimeofday routine and 
>>I have noticed a very strange behaviour. If I call the routine two times 
>>in sequence I expect that the second value is greater than or equal to 
>>the first one, but it is not true.
>>    
>>
>
>Perhaps because tv_usecs are MICROsecs, not MILLIsecs ?
>
>_______________________________________________________________________________
>                  Dr Chris McDonald   EMAIL:  chris@csse.uwa.edu.au
>     Department of Computer Science & Software Engineering
>The University of Western Australia   WWW: http://www.csse.uwa.edu.au/~chris
>   Crawley, Western Australia, 6009   PH: +61 8 9380 2533, FAX: +61 8 9380 1089
>
>
>  
>
>>please check the following code.
>>    
>>
>
>  
>
>>Sometimes happen that the string "Strange Behaviour" is printed with 
>>kernel 2.4.18.
>>    
>>
>
>  
>
>>I tried to find in the Linux Archive patches to solve this problem,  but 
>>I didn't find anything (there are emails that talk about gettimeofday, 
>>but probably they do not answer to my questions).
>>    
>>
>
>  
>
>>The same thing happen in Java using the System.currentTimeMillis() routine.
>>    
>>
>
>  
>
>>#include <fstream.h>
>>#include <sys/time.h>
>>    
>>
>
>  
>
>>// this routine calculate the current time returning its value in long 
>>long format.
>>long long currentTimeMillis() {
>>  long long t;
>>  struct timeval tv;
>>    
>>
>
>  
>
>>  gettimeofday(&tv, 0);
>>    
>>
>
>  
>
>>  t = tv.tv_sec;
>>  t = (t *1000) + (tv.tv_usec/1000);
>>    
>>
>
>  
>
>>  return t;
>>}
>>    
>>
>
>  
>
>>void main() {
>>  for (;;) {
>>      long long a = currentTimeMillis();
>>      long long b = currentTimeMillis();
>>    
>>
>
>  
>
>>      if (a>b) {
>>          cout << "Strange Behaviour" << endl;
>>      }
>>  }
>>}
>>    
>>
>
>  
>


