Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261435AbVG1MoP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261435AbVG1MoP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 08:44:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261434AbVG1MoO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 08:44:14 -0400
Received: from wproxy.gmail.com ([64.233.184.197]:49365 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261435AbVG1MnS convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 08:43:18 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=KQkl6ScmXZ9vpBiSyS32LpqWHFQEEGDUqkdIDY8GsT43BNQ2IA0XH5sDb7hSjwUEErtq+TzC5GG6cgDNGhyMLKMMrKoVZE55ORVYkqYEJUE6sWhgTIr8cpWbuO34+v8uSJ4OpIjf6QJdp8Y+HEDuTgT91laguj+Mk3a3/dEo+/g=
Message-ID: <ada605fb05072805434ab861f4@mail.gmail.com>
Date: Thu, 28 Jul 2005 08:43:16 -0400
From: John Que <qwejohn@gmail.com>
Reply-To: John Que <qwejohn@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: 
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I want ,for tracing and debugging purposes, to be able to generate a single 
interrupt on a device which (unlike the timer or ide devices, for example) does 
not get interrupts very frequently.

Looking at the output of /proc/interrupts (and look at IRQ 6 of the
floppy) shows
that the floppy device interrupt counter is not incremented during time if you
are not constatntly working with it.

So a good candidate for generating a single interrupt can be a floppy.

Is there a way to generate a single interrupt on a floppy device?

I had tried the following:

I mount the floppy;
I see that during the time, sometimes after running ls on a floppy
2 interrupts are generated; and sometimes after ls on a floppy
no interrupts are generated. The same is with
creating a file/reading a file: sometimes there
are interrupts and sometimes there are no interrupts.


So I wrote the following little program:

#define BUFFER_SIZE 2048

char buffer[BUFFER_SIZE] __attribute__((aligned(4096)));

int main()
        {

        int fd;
        int bytes_read;
        int i;
        fd = open("/dev/fd0",O_DIRECT);

        void* data;

        if (fd < 0 )
          printf("could not open device\n");

       else

        printf("device opened\n");

                {
                bytes_read = read(fd,buffer,512);

                //fseek(fd,SEEK_CUR,1);
                printf("bytes_read = %d\n",bytes_read);
                }

        close(fd);
        }

Each time I ran it I got course :
device opened
bytes_read = 512

But running this program again and again ***DOES NOT*** increase the
number of interrupt on the floppy device IRQ (6).

Any ideas?

Which user space code I should write / Which operation should I do so that each
time I will do it,(again and again) it will generate an interrupt on the 
floppy IRQ (6) ?

(BTW I build this program by  gcc -D_GNU_SOURCE floppy.c)

Regards,
John
