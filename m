Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317014AbSFANJ6>; Sat, 1 Jun 2002 09:09:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317015AbSFANJ5>; Sat, 1 Jun 2002 09:09:57 -0400
Received: from mout0.freenet.de ([194.97.50.131]:43143 "EHLO mout0.freenet.de")
	by vger.kernel.org with ESMTP id <S317014AbSFANJy>;
	Sat, 1 Jun 2002 09:09:54 -0400
Message-ID: <3CF8C84A.2080101@athlon.maya.org>
Date: Sat, 01 Jun 2002 15:12:42 +0200
From: Andreas Hartmann <andihartmann@freenet.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020523
X-Accept-Language: de, en-us, en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: Memory management in Kernel 2.4.x
In-Reply-To: <fa.iklie8v.5k2hbj@ifi.uio.no> <fa.na0lviv.e2a93a@ifi.uio.no> <actahk$6bp$1@ID-44327.news.dfncis.de> <3CF23893.207@loewe-komp.de> <20020531211951.GZ1172@dualathlon.random>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andrea,

 >> Andreas Hartmann wrote:
 > Andrea Arcangeli wrote:

[...]

 >> can you reproduce with 2.4.19pre9aa2? I expect at least the deadlock
 >> (if it's a deadlock and not a livelock) should go away.
 >>
 >> Also I read in another email that somebody grown the per-socket
 >> buffer
 >> to hundred mbytes, if you do that on a 32bit arch with highmem you'll
 >> run into troubles, too much ZONE_NORMAL ram will be constantly pinned
 >> for the tcp pipeline and the machine can enter livelocks.

 > I tested it and the error-situation occured again (thanks to rsync
 > :-)).

 > How did the kernel react?
 > Well, I waited some seconds until all the memory was in use (256 MB
 > RAM
 > and 128 MB swap). I have to say, nearly all the memory, because there
 > was allways some MB's free in RAM. So I was able to login via ssh as
 > root. As I wanted to do something, the machine didn't react. Until
 > this
 > point, the machine seemed to work fine - xosview through ssh showed
 > the
 > activity very well. But then it crashed, because it couldn't open
 > /proc/stat:
 >	Can not open file : /proc/stat
 > Some seconds later, the machine was working normal again. What
 > happened?
 >  /var/log/messages says:

[...]

 > I would like to know, if the killing of rsync was pure chance or if it
 > was systematically. I will try it again :-).

I did now two more tests. The kernel reacted nearly as described above. 
The malicious process was killed but one time unfortunately xosview, 
too. I always tried to open a new ssh session, wich always worked. Even 
  innd was able to server some news-postings :-).

If the kernel always only would kill the malicious process, it would be 
really great and probably the solution of a really big problem of 
2.4.-kernels!

1. try
Jun  1 14:40:58 susi PAM_unix[2650]: (sshd) session closed for user root
Jun  1 14:42:08 susi sshd[2660]: Accepted publickey for root from 
192.168.1.3 port 32987 ssh2
Jun  1 14:42:20 susi PAM_unix[2660]: (sshd) session opened for user root 
by (uid=0)
Jun  1 14:44:36 susi kernel: __alloc_pages: 0-order allocation failed 
(gfp=0x1d2/0)
Jun  1 14:44:36 susi kernel: VM: killing process rsync


2. try
Jun  1 14:49:00 susi PAM_unix[2804]: (sshd) session closed for user root
Jun  1 14:50:21 susi sshd[2813]: Accepted publickey for andreas from 
192.168.1.3 port 32991 ssh2
Jun  1 14:50:27 susi PAM_unix[2813]: (sshd) session opened for user 
andreas by (uid=0)
Jun  1 14:51:37 susi kernel: __alloc_pages: 0-order allocation failed 
(gfp=0x1f0/0)
Jun  1 14:51:46 susi last message repeated 2 times
Jun  1 14:51:50 susi kernel: __alloc_pages: 0-order allocation failed 
(gfp=0x1d2/0)
Jun  1 14:51:50 susi kernel: VM: killing process xosview
Jun  1 14:52:03 susi kernel: __alloc_pages: 0-order allocation failed 
(gfp=0x1d2/0)
Jun  1 14:52:03 susi kernel: VM: killing process rsync


The problems of resync always occure if the rsync-process on the other 
side is stoped with CTRL-C e.g. At this moment, the ssh-connection to 
the host susi is closed, which rsync obviously can't handle correctly.
That's why it's very easy for me to reproduce the situation and how the 
kernel is acting.


Regards,
Andreas Hartmann

