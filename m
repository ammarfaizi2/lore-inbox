Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129574AbRCAJqL>; Thu, 1 Mar 2001 04:46:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129576AbRCAJqB>; Thu, 1 Mar 2001 04:46:01 -0500
Received: from [194.67.35.250] ([194.67.35.250]:57827 "HELO skif.spylog.net")
	by vger.kernel.org with SMTP id <S129574AbRCAJpw>;
	Thu, 1 Mar 2001 04:45:52 -0500
Message-ID: <001701c0a230$40e12240$0e04a8c0@iv>
From: "Ivan Stepnikov" <iv@spylog.com>
To: <linux-kernel@vger.kernel.org>
Subject: Kernel is unstable
Date: Thu, 1 Mar 2001 12:16:08 +0300
MIME-Version: 1.0
Content-Type: text/plain;
	charset="koi8-r"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2919.6700
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2919.6700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

            Hello!

I tried to test linux memory allocation. For experiment I used i386
architecture with Pentium III processor, 512M RAM and 8G swap space. For
memory allocation libhoard was tried. Linux kernel 2.4.2 with patch
per-process-3.5G-IA32-no-PAE-1, at
/pub/linux/kernel/people/andrea/patches/v2.4/2.4.0-test11-pre5/ on
ftp.kernel.org (This patch should force memory allocation for one process up
to 3.5G approximately).

When I try large blocks (about 256K - 1M) everything was ok. More then 3G
memory was successfully allocated.

On small blocks result was significantly worse. About 2.3 - 2.4G was
allocated and system hanged. But it was possible to switch between  local
consoles, and to receive ping replay by network. Actually it's only one sign
of life (hard disk didn't work and it was impossible to reboot the machine
by correct methods). At /var/log/messages was

Feb 28 17:08:55 zetta kernel: <ed.
Feb 28 17:08:55 zetta kernel: __alloc_pages: 0-order allocation failed.
Feb 28 17:09:05 zetta last message repeated 363 times



Test program looks like this:



block = 1024;

for (i=1; ; ++i ){

                if(p==malloc(block)){

                        perror("failed");

                        fprintf(stderr,"Error! Size total:%uM pass:
%u\n",size/1024/1024,i);

                        return 0;

                }

                size += block;

                printf("Size total:%uM pass: %u\n",size/1024/1024,i);

}



I think, this test shouldn't hang system. System may work slowly, very
slowly but it shouldn't hang. If system cannot allocate any pages it should
return correct value.

And the main thing: it seems the system doesn't use all available swap
space.

I'm sure if system works properly results must be other.

--
Regards,
Ivan Stepnikov.


