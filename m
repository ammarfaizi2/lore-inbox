Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310916AbSCROGs>; Mon, 18 Mar 2002 09:06:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310913AbSCROGj>; Mon, 18 Mar 2002 09:06:39 -0500
Received: from d12lmsgate-2.de.ibm.com ([195.212.91.200]:60061 "EHLO
	d12lmsgate-2.de.ibm.com") by vger.kernel.org with ESMTP
	id <S310916AbSCROG0> convert rfc822-to-8bit; Mon, 18 Mar 2002 09:06:26 -0500
Importance: Normal
Sensitivity: 
Subject: Re: 2.4.9-pre3 s390 patch for partition code
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.4a  July 24, 2000
Message-ID: <OFDDA69694.7030D648-ONC1256B80.00373644@de.ibm.com>
From: "Martin Schwidefsky" <schwidefsky@de.ibm.com>
Date: Mon, 18 Mar 2002 15:03:40 +0100
X-MIMETrack: Serialize by Router on D12ML016/12/M/IBM(Release 5.0.9a |January 7, 2002) at
 18/03/2002 15:06:17
MIME-Version: 1.0
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Pete,

>This is a patch that I extracted from a tarball received last week.
>It is said to be failed by Marcelo for 2.4.18, but something is
>need to fix this.

Definitly.

>To that end, I considered pulling ioctls and replacing them with
>reads, but it is too much work. So, I talked to Al Viro
>and secured his help to have ioctl_by_bdev working at check_part()
>time with a proper fix. Before it is available, I suggest we
>push the fs/block_dev.c change into 2.4.19-preX as a stop-gap.

Even worse, you can't replace the ioctls by reads. You need two
pieces of information 1) the number of the label block which is
different for the three formats CMS1, VOL1, and LNX1 and 2) the
geometry of the device to do the calculations for the VOL1 format.
Both informations are only known to the dasd driver. The only
clean way to get them is to "ask" the dasd driver using an ioctl.
The try to be smarter then the dasd driver and do you own reads
to find out what is needed is imho asking for trouble.

>The fs/partitions/ibm.c change from the tarball was useful, but
>I *STRONGLY* disagree with putting so much crap on the stack.
>It may explain why we have so much trouble with stacks on s390:
>they are simply overused. I changed the code to allocate structures
>properly. This should go in regartless of Al's work on ioctl.

I just checked. Its 744 bytes for ibm_partition(). Probably a bit
much ... so you version makes sense.

blue skies,
   Martin

Linux/390 Design & Development, IBM Deutschland Entwicklung GmbH
Schönaicherstr. 220, D-71032 Böblingen, Telefon: 49 - (0)7031 - 16-2247
E-Mail: schwidefsky@de.ibm.com


