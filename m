Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263685AbUDTTDo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263685AbUDTTDo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Apr 2004 15:03:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263862AbUDTTDo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Apr 2004 15:03:44 -0400
Received: from zasran.com ([198.144.206.234]:61063 "EHLO zasran.com")
	by vger.kernel.org with ESMTP id S263685AbUDTTDj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Apr 2004 15:03:39 -0400
Message-ID: <4085740A.6030609@bigfoot.com>
Date: Tue, 20 Apr 2004 12:03:38 -0700
From: Erik Steffl <steffl@bigfoot.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040413 Debian/1.6-5
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: logitech mouseMan wheel doesn't work with 2.6.5
References: <200404201522.i3KFMk120352@tag.witbe.net>
In-Reply-To: <200404201522.i3KFMk120352@tag.witbe.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Rolland wrote:
> Hello,
> 
> 
>>   it looks that after update to 2.6.5 kernel (debian source 
>>package but 
>>I guess it would be the same with stock 2.6.5) the mouse 
>>wheel and side 
>>button on Logitech Cordless MouseMan Wheel mouse do not work.
> 
> I've got a new mouse with a wheel, and I've got the same problem,
> though I can't tell if it was working before...
> 
> 
>>Here's the most basic/simple situation/symptoms:
>>
>>   I stop X, read bytes from /dev/psaux (c program, using open and 
>>read). for each mouse action there are few bytes read, usually number 
> 
> Could you provide me with the program so that I can test too ?

it's very simple, just gcc and run it from console, I guess you should 
quit X before running it, ctrl-c to exit:

#include <stdio.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>

int main(void)
{
   unsigned char buf[10];
   unsigned char last;
   unsigned long counter = 0;

   int fd = open("/dev/psaux", O_RDONLY);
   if(fd == -1) { perror("couldn't open file"); exit(1); }

   while(read(fd, buf, 1) != -1) {
     if( (last == 0) && (buf[0] != 0) ) {
       printf("\n[%010d] ", counter);
     }
     printf("[%03d] ", buf[0]);
     last = buf[0];
     counter++;
   }

   return 0;
}
/* eof */

	erik
