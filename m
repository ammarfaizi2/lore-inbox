Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281759AbRK0Rx5>; Tue, 27 Nov 2001 12:53:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282178AbRK0Rxq>; Tue, 27 Nov 2001 12:53:46 -0500
Received: from mail.spylog.com ([194.67.35.220]:48612 "HELO mail.spylog.com")
	by vger.kernel.org with SMTP id <S282062AbRK0Rxg>;
	Tue, 27 Nov 2001 12:53:36 -0500
Date: Tue, 27 Nov 2001 20:54:24 +0300
From: Peter Zaitsev <pz@spylog.ru>
X-Mailer: The Bat! (v1.53d)
Reply-To: Peter Zaitsev <pz@spylog.ru>
Organization: SpyLOG
X-Priority: 3 (Normal)
Message-ID: <149725995035.20011127205424@spylog.ru>
To: Andrew Morton <akpm@zip.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re[2]: MMAP issues
In-Reply-To: <3C03D108.E3FADE95@zip.com.au>
In-Reply-To: <183721898675.20011127194607@spylog.ru>
 <3C03D108.E3FADE95@zip.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andrew,

Tuesday, November 27, 2001, 8:44:40 PM, you wrote:

OK. Of course. It's just a few lines length:
Just mention to create any "test.dat" file in the current directory;

#include <stdio.h>
#include <unistd.h>
#include <sys/mman.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <errno.h>

int main()
 {
  int i=0;
  void* p;
  int t;
  int fd;
  
  
  t=time(NULL);
  while(1)
    {     
     fd=open("test.dat",O_RDWR);
     if (fd<0)
      {
       puts("Unable to open file !");
       return;
      }
     p=mmap(NULL,4096, PROT_READ | PROT_WRITE , MAP_PRIVATE ,fd ,0);
     if ((int)p==-1) 
          {
           printf("Failed %d\n",errno);
           return;
          }       
     i++;     
     if (i%10000==0)
       {
        printf(" %d  Time: %d\n",i,time(NULL)-t);
        t=time(NULL);
       }
     
    } 
 }

AM> Peter Zaitsev wrote:
>> 
>> Hello ,
>> 
>>   I'm trying to write a program which uses mmap agressively to mmap
>>   files (really it's used as fail safe memory allocator to store data
>>   if application failed)
>>

AM> It would really help if you could make your test application available to
AM> the kernel developers.

AM> Thanks.



Additionally  the interesting thing is - if I change MMAP params to:
p=mmap(NULL,4096, PROT_READ | PROT_WRITE , MAP_PRIVATE | MAP_ANON ,-1 ,0);

(The only change is mapping done ammoniums instead of mmaping  a file
- this increases speed really much and it does not decrease)





-- 
Best regards,
 Peter                            mailto:pz@spylog.ru

