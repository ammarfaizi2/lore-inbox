Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279722AbRKIJ3q>; Fri, 9 Nov 2001 04:29:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279739AbRKIJ3h>; Fri, 9 Nov 2001 04:29:37 -0500
Received: from d12lmsgate-2.de.ibm.com ([195.212.91.200]:35038 "EHLO
	d12lmsgate-2.de.ibm.com") by vger.kernel.org with ESMTP
	id <S279722AbRKIJ3X> convert rfc822-to-8bit; Fri, 9 Nov 2001 04:29:23 -0500
Importance: Normal
Subject: Re: if (a & X || b & ~Y) in dasd.c
To: Kevin <kevin@pheared.net>
Cc: Pete Zaitcev <zaitcev@redhat.com>, <linux-kernel@vger.kernel.org>,
        "BOEBLINGEN LINUX390" <LINUX390@de.ibm.com>
X-Mailer: Lotus Notes Release 5.0.4a  July 24, 2000
Message-ID: <OF8658D049.3695DA65-ONC1256AFF.00336535@de.ibm.com>
From: "Carsten Otte" <COTTE@de.ibm.com>
Date: Fri, 9 Nov 2001 11:29:54 +0100
X-MIMETrack: Serialize by Router on D12ML033/12/M/IBM(Release 5.0.8 |June 18, 2001) at
 09/11/2001 10:29:15
MIME-Version: 1.0
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pete, Hi Kevin,

it's just like Kevin explained, the singe &/|/~ are bit operations
while &&/|| are logical operations. The bit operations are handled
before the logical ones (am I correct?)- so compiler-wise this should
be fine.
Sure, one should use some paranthesises to make things clearer,
but why are you examining  such ancient code? 2.2.14. seems a little
bit historical for me. The current dasd device driver is much more
readable and better designed (is redesigned in the 2.4 series).

mit freundlichem Gruﬂ / with kind regards
Carsten Otte

IBM Deutschland Entwicklung GmbH
Linux for 390/zSeries Development - Device Driver Team
Phone: +49/07031/16-4076
IBM internal phone: *120-4076
--
We are Linux.
Resistance indicates that you're missing the point!


Kevin <kevin@pheared.net> on 11/08/2001 10:10:51 PM

Please respond to Kevin <kevin@pheared.net>

To:   Pete Zaitcev <zaitcev@redhat.com>
cc:   Carsten Otte/Germany/IBM@IBMDE, <linux-kernel@vger.kernel.org>,
      BOEBLINGEN LINUX390/Germany/IBM@IBMDE
Subject:  Re: if (a & X || b & ~Y) in dasd.c



On Thu, 8 Nov 2001, Pete Zaitcev wrote:

[zaitce] Date: Thu, 8 Nov 2001 15:57:49 -0500
[zaitce] From: Pete Zaitcev <zaitcev@redhat.com>
[zaitce] To: Cotte@de.ibm.com
[zaitce] Cc: linux-kernel@vger.kernel.org, Linux390@de.ibm.com
[zaitce] Subject: if (a & X || b & ~Y) in dasd.c
[zaitce]
[zaitce] Carsten and others:
[zaitce]
[zaitce] this code in 2.2.14 looks suspicious to me:
[zaitce]
[zaitce] ./drivers/s390/block/dasd.c:
[zaitce]         /* first of all lets try to find out the appropriate
era_action */
[zaitce]         if (stat->flag & DEVSTAT_FLAG_SENSE_AVAIL ||
[zaitce]             stat->dstat & ~(DEV_STAT_CHN_END | DEV_STAT_DEV_END))
{
[zaitce]                 /* anything abnormal ? */
[zaitce]                 if (device->discipline->examine_error == NULL ||
[zaitce]                     stat->flag & DEVSTAT_HALT_FUNCTION) {
[zaitce]                         era = dasd_era_fatal;
[zaitce]                 } else {
[zaitce]                         era = device->discipline->examine_error
(cqr, stat);
[zaitce]                 }
[zaitce]                 DASD_DRIVER_DEBUG_EVENT (1, dasd_int_handler,"
era_code %d",
[zaitce]                                          era);
[zaitce]         }
[zaitce]
[zaitce] Are you sure any parenthesises are not needed here?

I'm not going to pretend to know what the code is accomplishing, but as
a matter of C, those &'s aren't the same as &&'s and will get executed as
the || is tested.  So the first one will get &'ded and if false then the
second will and if neither return true then we move on.

Or, perhaps I'm being an idiot and misunderstanding the question and the
code.  In that case, I'll pretend I didn't say anything.  :)

-[ kevin@pheared.net                 devel.pheared.net ]-
-[ Rather be forgotten, than remembered for giving in. ]-
-[ ZZ = g ^ (xb * xa) mod p      g = h^{(p-1)/q} mod p ]-





