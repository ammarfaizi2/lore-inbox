Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266251AbRGYMRq>; Wed, 25 Jul 2001 08:17:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268559AbRGYMRg>; Wed, 25 Jul 2001 08:17:36 -0400
Received: from smtp2.koti.soon.fi ([212.63.10.50]:40421 "EHLO
	smtp2.koti.soon.fi") by vger.kernel.org with ESMTP
	id <S266251AbRGYMRY>; Wed, 25 Jul 2001 08:17:24 -0400
From: "M. Tavasti" <tawz@nic.fi>
To: linux-kernel@vger.kernel.org
Subject: Select with device and stdin not working
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Date: 25 Jul 2001 15:17:14 +0300
Message-ID: <m266chnqyd.fsf@akvavitix.vuovasti.com>
X-Mailer: Gnus v5.6.45/XEmacs 21.1 - "Capitol Reef"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


I found this problem first time in 2.2 kernels, when doing own device
driver. Then it was not an issue for me, and I suspected it's my
fault. Now, with 2.4 again I tried to solve problem, but I can't find
my way out of this, and looks like there in-kernel drivers which have
same symptoms.

Here program where I get problems:

int fd;
fd_set rfds;

fd = open("/dev/random", O_RDWR );

while(1) {
        FD_ZERO(&rfds);
        FD_SET(fd,&rfds);
        FD_SET(fileno(stdin),&rfds);
        if( select(fd+1, &rfds, NULL, NULL, NULL  ) > 0) {
                fprintf(stderr,"Select\n");
                fflush(stderr);
                if(FD_ISSET(fd,&rfds)) {
                 .......
                } else if(FD_ISSET(fileno(stdin),&rfds) ) { 
                 ......
                }
        }
}


Select is working fine for device (in this example /dev/random) or
stdin. But for both, not. When entering something to stdin, it's not
sure select will return. 

I haven't tested is this problem present in all devices, but at least
/dev/random is infected. And if problem lies only in some of the
drivers, it would be nice to know which driver haves decent
implementation of poll and get others updated. 

I'm not subsribed on the list, so when replying this you may consider
Cc:ing me. 

-- 
M. Tavasti /  tawz@nic.fi  /   +358-40-5078254
