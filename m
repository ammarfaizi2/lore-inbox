Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313016AbSDYJaF>; Thu, 25 Apr 2002 05:30:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313019AbSDYJaE>; Thu, 25 Apr 2002 05:30:04 -0400
Received: from [159.226.41.188] ([159.226.41.188]:30982 "EHLO
	gatekeeper.ncic.ac.cn") by vger.kernel.org with ESMTP
	id <S313016AbSDYJaD>; Thu, 25 Apr 2002 05:30:03 -0400
Date: Thu, 25 Apr 2002 17:12:21 +0800
From: "Huo Zhigang" <zghuo@gatekeeper.ncic.ac.cn>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Re: what`s wrong?
Organization: NCIC
X-mailer: FoxMail 3.11 Release [cn]
Content-Type: text/plain; charset="GB2312"
Content-Transfer-Encoding: 7bit
Message-ID: <7754BE8DC82.AAA4CC2@gatekeeper.ncic.ac.cn>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>On Apr 24, 2002  18:06 +0200, il boba wrote:
>> Is there anybody that can help me understand what`s wrong with this code?

>Yes, easily spotted a major problem without even reading the whole
>thing.

>> #define BUFSIZ 8192
>> 
>> int init_module()
>> {
>>  int err_frame[BUFSIZ];
>
>The entire kernel stack is only 8kB in size.  You have already killed
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>a bunch of random memory by allocating this much memory on the stack.
>You allocated 4*8192 = 32kB on the stack here.
  
   Sure, the kernel stack is 8192 Bytes, but "err_frame[]" is a local variable. Does the kernel allocate memory for "err_frame[]" from the stack?? 

>> int init_err_frame(int err_frame[]) {
>>  int i, k = 0, j = 0;
>>  char buffer[BUFSIZ];
>
>Another 8kB on the stack here - further random corruption.
   Here, I think, err_frame[] as a function parameter  will take 8K in the kernel stack.
   Am I correct?
  
   Thank you.


