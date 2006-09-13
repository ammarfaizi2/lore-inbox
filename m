Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751571AbWIMFG3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751571AbWIMFG3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 01:06:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751569AbWIMFG3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 01:06:29 -0400
Received: from exprod6og50.obsmtp.com ([64.18.1.181]:64897 "HELO
	exprod6og50.obsmtp.com") by vger.kernel.org with SMTP
	id S1751565AbWIMFG2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 01:06:28 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6603.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Subject: AW: fix 2.4.33.3 / sun partition size
Date: Wed, 13 Sep 2006 07:06:25 +0200
Message-ID: <DA6197CAE190A847B662079EF7631C06015692C4@OEKAW2EXVS03.hbi.ad.harman.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: fix 2.4.33.3 / sun partition size
Thread-Index: AcbWoSvqPVu9Yx2SQ3+AiSox8VhdywAUEexw
From: "Jurzitza, Dieter" <DJurzitza@harmanbecker.com>
To: "Willy Tarreau" <w@1wt.eu>, <davem@davemloft.net>
Cc: <linux-kernel@vger.kernel.org>, "Jeff Mahoney" <jeffm@suse.com>,
       <sparclinux@vger.kernel.org>
X-OriginalArrivalTime: 13 Sep 2006 05:06:25.0609 (UTC) 
    FILETIME=[5CECCB90:01C6D6F2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Willy,
> It would really depend on the on-disk format. If the 
> partition table really stores 32 bit ints for sector counts, 
> there's no point switching from ints to longs. But if it 
> already stores 64 bits, then we're limiting it to 2 TB with 
> 32 bit ints. I haven't checked the code right now, so I don't 
> know. I hope Davem will enlighten us on this matter.
> 
I see your point. The question is: what happens if we forcibly cast a 8 byte unsigned long into a 4 byte (unsigned ...) int.
One point is only sun related here: the 1/2TByte limit for sun partitions. The other things are generic ones, independent of the architecture but no: at the very moment that a long differs in size from an int we run into problems IMHO. It's unclean, at last.
Do you think it would be better to do an explicit cast in each call to pinpoint the issue?
Thanks for your inputs, and, yes, it's been quiet on sparclinux, it sounds like Dave Miller is (hopefully!) off for holidays - and I think he deserves it, doesn't he :-) ?
Take care



Dieter


-- 
________________________________________________

HARMAN BECKER AUTOMOTIVE SYSTEMS

Dr.-Ing. Dieter Jurzitza
Manager Hardware Systems
   System Development

Industriegebiet Ittersbach
Becker-Göring Str. 16
D-76307 Karlsbad / Germany

Phone: +49 (0)7248 71-1577
Fax:   +49 (0)7248 71-1216
eMail: DJurzitza@harmanbecker.com
Internet: http://www.becker.de


*******************************************
Diese E-Mail enthaelt vertrauliche und/oder rechtlich geschuetzte Informationen. Wenn Sie nicht der richtige Adressat sind oder diese E-Mail irrtuemlich erhalten haben, informieren Sie bitte sofort den Absender und loeschen Sie diese Mail. Das unerlaubte Kopieren sowie die unbefugte Weitergabe dieser Mail ist nicht gestattet.
 
This e-mail may contain confidential and/or privileged information. If you are not the intended recipient (or have received this e-mail in error) please notify the sender immediately and delete this e-mail. Any unauthorized copying, disclosure or distribution of the contents in this e-mail is strictly forbidden.
*******************************************

