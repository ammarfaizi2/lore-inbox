Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284979AbRLVAKr>; Fri, 21 Dec 2001 19:10:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285134AbRLVAKh>; Fri, 21 Dec 2001 19:10:37 -0500
Received: from h00e02954cece.ne.mediaone.net ([24.91.228.68]:7040 "EHLO
	gonzo.amherst.genlogic.com") by vger.kernel.org with ESMTP
	id <S284979AbRLVAK1>; Fri, 21 Dec 2001 19:10:27 -0500
Message-ID: <3C23CF86.6010600@mediaone.net>
Date: Fri, 21 Dec 2001 19:10:46 -0500
From: Sam <genlogic@mediaone.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: scsi acard AEC6712D and atp870u.c driver
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

*please cc the answers to me*


hello

i am using an acer scanwit scanner which comes with the acard AEC6712D 
scsi controller.
i am also using the acard driver in 2.4.7 (also tried 2.4.13). ejecting 
the scanner seems to work (no data sent),
but scanning and previewing seems to cause problems.

it seems to be the driver that is causing the problems. when it 
eventually times out,
i get:

scsi : aborting command due to timeout : pid 0, scsi0, channel 0, id 0, 
lun 0 Write (10) 00 82 00 00 01 00 1d e2 00
working=1 last_cmd=0  quhdu=1a quendu=1a  r 0= a r 1=2c r 2=cf r 3=2a r 
4= 0 r 5=82 r 6= 0 r 7= 0 r 8= 1 r 9= 0 r a=1d r b=e2 r c= 0 r d= 0 r e= 
0 r f= 0 r10=3a r11=20 r12= 0 r13= 0 r14= 2 r15=20 r16=80 r1c= 0 r1f=35 
in_snd= 0  r20= 1 r22= 8 r3a=2b
 r3b=20

 que cdb=  2a   0  82   0   0   1   0  1d  e2   0  last_lenu= 1de2

i have gotten some suggestions such as

removing

      if (dev->ata_cdbu[0] == READ_CAPACITY) {
        if (workrequ->request_bufflen > 8) {
                workrequ->request_bufflen = 0x08;
        }
      }

from the driver code, but this just causes the target id (as seen above to be: 0) to be the last command
so the command it got before was 0xff

as seen from
if ((j & 0x40) != 0)
		{
		     if (dev->last_cmd == 0xff)
		     {
			dev->last_cmd = target_id;
		     }
		     dev->last_cmd |= 0x40;
		}

any ideas on what the problem might be? when was the lastest bug update on atp870u.c?


thanx,

*please cc the answers to me*

--sam


