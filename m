Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289937AbSAOPai>; Tue, 15 Jan 2002 10:30:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289939AbSAOPa3>; Tue, 15 Jan 2002 10:30:29 -0500
Received: from mail.scs.ch ([212.254.229.5]:52363 "EHLO mail.scs.ch")
	by vger.kernel.org with ESMTP id <S289937AbSAOPaR>;
	Tue, 15 Jan 2002 10:30:17 -0500
Message-ID: <3C444AFA.8000605@scs.ch>
Date: Tue, 15 Jan 2002 16:30:02 +0100
From: Markus Walser <walser@scs.ch>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20011221
X-Accept-Language: en-us
MIME-Version: 1.0
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
CC: linux-kernel@vger.kernel.org
Subject: aic7xxx bus speed
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi
I've an aic7899: Ultra160 Wide scsi controller with a few disks
under an alpha ds20 running.
Now I'm having troubles getting 160MB/s bus speed on the
actual kernels (2.4.18pre2/2.5.2pre9). On the kernel 2.2.18 and
the redhat kernels 2.4.3-12, 2.4.9-13 I get full speed of 160MB/s.
But on the new kernel I get just 80MB/s per bus.
So I took a look at the differences between 2.4.9-13 and 2.4.18pre2.
You can find a diff of the aic7xxx driver here:
    http://www.scs.ch/~walser/aic7xxx.diff
Basically its the aic7xxx version 6.2.4 insteed of 6.2.1 in the new
 2.4.18pre2 kernel. I couldn't find where the problem comes from.
Here also some proc info:

[root@gugus /root]# uname -a
Linux gugus 2.5.2-pre9 #9 SMP Mon Jan 14 21:08:19 CET 2002 alpha unknown

[root@gugus /root]# cat /proc/scsi/aic7xxx/2
Adaptec AIC7xxx driver version: 6.2.4
aic7899: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs
Channel A Target 0 Negotiation Settings
        User: 160.000MB/s transfers (80.000MHz DT, offset 255, 16bit)
        Goal: 80.000MB/s transfers (40.000MHz, offset 63, 16bit)
        Curr: 80.000MB/s transfers (40.000MHz, offset 63, 16bit)
        Channel A Target 0 Lun 0 Settings
                Commands Queued 5
                Commands Active 0
                Command Openings 253
                Max Tagged Openings 253
                Device Queue Frozen Count 0
Channel A Target 1 Negotiation Settings
        User: 160.000MB/s transfers (80.000MHz DT, offset 255, 16bit)
        Goal: 80.000MB/s transfers (40.000MHz, offset 63, 16bit)
        Curr: 80.000MB/s transfers (40.000MHz, offset 63, 16bit)
        Channel A Target 1 Lun 0 Settings
                Commands Queued 5
                Commands Active 0
                Command Openings 253
                Max Tagged Openings 253
                Device Queue Frozen Count 0
Channel A Target 2 Negotiation Settings
        User: 160.000MB/s transfers (80.000MHz DT, offset 255, 16bit)
        Goal: 80.000MB/s transfers (40.000MHz, offset 63, 16bit)
        Curr: 80.000MB/s transfers (40.000MHz, offset 63, 16bit)
        Channel A Target 2 Lun 0 Settings
                Commands Queued 5
                Commands Active 0
                Command Openings 253
                Max Tagged Openings 253
                Device Queue Frozen Count 0
Channel A Target 3 Negotiation Settings
        User: 160.000MB/s transfers (80.000MHz DT, offset 255, 16bit)
        Goal: 80.000MB/s transfers (40.000MHz, offset 63, 16bit)
        Curr: 80.000MB/s transfers (40.000MHz, offset 63, 16bit)
        Channel A Target 3 Lun 0 Settings
                Commands Queued 5
                Commands Active 0
                Command Openings 253
                Max Tagged Openings 253
                Device Queue Frozen Count 0
Channel A Target 4 Negotiation Settings
        User: 160.000MB/s transfers (80.000MHz DT, offset 255, 16bit)
        Goal: 80.000MB/s transfers (40.000MHz, offset 63, 16bit)
        Curr: 80.000MB/s transfers (40.000MHz, offset 63, 16bit)
        Channel A Target 4 Lun 0 Settings
                Commands Queued 5
                Commands Active 0
                Command Openings 253
                Max Tagged Openings 253
                Device Queue Frozen Count 0
Channel A Target 5 Negotiation Settings
        User: 160.000MB/s transfers (80.000MHz DT, offset 255, 16bit)
        Goal: 80.000MB/s transfers (40.000MHz, offset 63, 16bit)
        Curr: 80.000MB/s transfers (40.000MHz, offset 63, 16bit)
        Channel A Target 5 Lun 0 Settings
                Commands Queued 5
                Commands Active 0
                Command Openings 253
                Max Tagged Openings 253
                Device Queue Frozen Count 0
Channel A Target 6 Negotiation Settings
        User: 160.000MB/s transfers (80.000MHz DT, offset 255, 16bit)
Channel A Target 7 Negotiation Settings
        User: 160.000MB/s transfers (80.000MHz DT, offset 255, 16bit)
Channel A Target 8 Negotiation Settings
        User: 160.000MB/s transfers (80.000MHz DT, offset 255, 16bit)
        Goal: 80.000MB/s transfers (40.000MHz, offset 63, 16bit)
        Curr: 80.000MB/s transfers (40.000MHz, offset 63, 16bit)
        Channel A Target 8 Lun 0 Settings
                Commands Queued 5
                Commands Active 0
                Command Openings 253
                Max Tagged Openings 253
                Device Queue Frozen Count 0
Channel A Target 9 Negotiation Settings
        User: 160.000MB/s transfers (80.000MHz DT, offset 255, 16bit)
Channel A Target 10 Negotiation Settings
        User: 160.000MB/s transfers (80.000MHz DT, offset 255, 16bit)
Channel A Target 11 Negotiation Settings
        User: 160.000MB/s transfers (80.000MHz DT, offset 255, 16bit)
Channel A Target 12 Negotiation Settings
        User: 160.000MB/s transfers (80.000MHz DT, offset 255, 16bit)
Channel A Target 13 Negotiation Settings
        User: 160.000MB/s transfers (80.000MHz DT, offset 255, 16bit)
Channel A Target 14 Negotiation Settings
        User: 160.000MB/s transfers (80.000MHz DT, offset 255, 16bit)
Channel A Target 15 Negotiation Settings
        User: 160.000MB/s transfers (80.000MHz DT, offset 255, 16bit)
[root@petal0 /root]#
__________________________________________________________

[root@gugus /root]# uname -a
Linux gugus 2.4.9-13custom #1 SMP Mon Nov 12 12:56:49 CET 2001 alpha unknown

[root@gugus /root]# cat /proc/scsi/aic7xxx/2
Adaptec AIC7xxx driver version: 6.2.1
aic7899: Ultra160 Wide Channel A, SCSI Id=7, 32/255 SCBs
Channel A Target 0 Negotiation Settings
        User: 160.000MB/s transfers (80.000MHz DT, offset 255, 16bit)
        Goal: 160.000MB/s transfers (80.000MHz DT, offset 63, 16bit)
        Curr: 160.000MB/s transfers (80.000MHz DT, offset 63, 16bit)
        Channel A Target 0 Lun 0 Settings
                Commands Queued 6
                Commands Active 0
                Command Openings 253
                Max Tagged Openings 253
                Device Queue Frozen Count 0
Channel A Target 1 Negotiation Settings
        User: 160.000MB/s transfers (80.000MHz DT, offset 255, 16bit)
        Goal: 160.000MB/s transfers (80.000MHz DT, offset 63, 16bit)
        Curr: 160.000MB/s transfers (80.000MHz DT, offset 63, 16bit)
        Channel A Target 1 Lun 0 Settings
                Commands Queued 6
                Commands Active 0
                Command Openings 253
                Max Tagged Openings 253
                Device Queue Frozen Count 0
Channel A Target 2 Negotiation Settings
        User: 160.000MB/s transfers (80.000MHz DT, offset 255, 16bit)
        Goal: 160.000MB/s transfers (80.000MHz DT, offset 63, 16bit)
        Curr: 160.000MB/s transfers (80.000MHz DT, offset 63, 16bit)
        Channel A Target 2 Lun 0 Settings
                Commands Queued 6
                Commands Active 0
                Command Openings 253
                Max Tagged Openings 253
                Device Queue Frozen Count 0
Channel A Target 3 Negotiation Settings
        User: 160.000MB/s transfers (80.000MHz DT, offset 255, 16bit)
        Goal: 160.000MB/s transfers (80.000MHz DT, offset 63, 16bit)
        Curr: 160.000MB/s transfers (80.000MHz DT, offset 63, 16bit)
        Channel A Target 3 Lun 0 Settings
                Commands Queued 6
                Commands Active 0
                Command Openings 253
                Max Tagged Openings 253
                Device Queue Frozen Count 0
Channel A Target 4 Negotiation Settings
        User: 160.000MB/s transfers (80.000MHz DT, offset 255, 16bit)
        Goal: 160.000MB/s transfers (80.000MHz DT, offset 63, 16bit)
        Curr: 160.000MB/s transfers (80.000MHz DT, offset 63, 16bit)
        Channel A Target 4 Lun 0 Settings
                Commands Queued 6
                Commands Active 0
                Command Openings 253
                Max Tagged Openings 253
                Device Queue Frozen Count 0
Channel A Target 5 Negotiation Settings
        User: 160.000MB/s transfers (80.000MHz DT, offset 255, 16bit)
        Goal: 160.000MB/s transfers (80.000MHz DT, offset 63, 16bit)
        Curr: 160.000MB/s transfers (80.000MHz DT, offset 63, 16bit)
        Channel A Target 5 Lun 0 Settings
                Commands Queued 6
                Commands Active 0
                Command Openings 253
                Max Tagged Openings 253
                Device Queue Frozen Count 0
Channel A Target 6 Negotiation Settings
        User: 160.000MB/s transfers (80.000MHz DT, offset 255, 16bit)
Channel A Target 7 Negotiation Settings
        User: 160.000MB/s transfers (80.000MHz DT, offset 255, 16bit)
Channel A Target 8 Negotiation Settings
        User: 160.000MB/s transfers (80.000MHz DT, offset 255, 16bit)
        Goal: 160.000MB/s transfers (80.000MHz DT, offset 63, 16bit)
        Curr: 160.000MB/s transfers (80.000MHz DT, offset 63, 16bit)
        Channel A Target 8 Lun 0 Settings
                Commands Queued 6
                Commands Active 0
                Command Openings 253
                Max Tagged Openings 253
                Device Queue Frozen Count 0
Channel A Target 9 Negotiation Settings
        User: 160.000MB/s transfers (80.000MHz DT, offset 255, 16bit)
Channel A Target 10 Negotiation Settings
        User: 160.000MB/s transfers (80.000MHz DT, offset 255, 16bit)
Channel A Target 11 Negotiation Settings
        User: 160.000MB/s transfers (80.000MHz DT, offset 255, 16bit)
Channel A Target 12 Negotiation Settings
        User: 160.000MB/s transfers (80.000MHz DT, offset 255, 16bit)
Channel A Target 13 Negotiation Settings
        User: 160.000MB/s transfers (80.000MHz DT, offset 255, 16bit)
Channel A Target 14 Negotiation Settings
        User: 160.000MB/s transfers (80.000MHz DT, offset 255, 16bit)
Channel A Target 15 Negotiation Settings
        User: 160.000MB/s transfers (80.000MHz DT, offset 255, 16bit)

Do you have any hints to get back the full 160MB/s speed?

Regards, Markus
________________________________________________________

Supercomputing Systems AG       email: walser@scs.ch
Markus Walser                   web:   http://www.scs.ch
Technoparkstrasse 1             phone: +41 1 445 16 00
CH-8005 Zuerich                 fax:   +41 1 445 16 10


