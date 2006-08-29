Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750796AbWH2EwF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750796AbWH2EwF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 00:52:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750811AbWH2EwE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 00:52:04 -0400
Received: from exprod6og56.obsmtp.com ([64.18.1.208]:30872 "HELO
	exprod6og56.obsmtp.com") by vger.kernel.org with SMTP
	id S1750796AbWH2EwC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 00:52:02 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6603.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Subject: [PATCH] sun disk label: fix signed int usage for sector count
Date: Tue, 29 Aug 2006 06:52:00 +0200
Message-ID: <DA6197CAE190A847B662079EF7631C06015692A6@OEKAW2EXVS03.hbi.ad.harman.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] sun disk label: fix signed int usage for sector count
Thread-Index: AcbLJtzlNKfbHDA1Q3WkO1w9a+8Zkw==
From: "Jurzitza, Dieter" <DJurzitza@harmanbecker.com>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 29 Aug 2006 04:52:00.0504 (UTC) 
    FILETIME=[DD15FF80:01C6CB26]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear listmembers,
citing Jeff Mahoney:

> I'm not sure how many people out there are using Sun disk labels with sizes > 1TB.
> It seems like a pretty rare corner case, but there's no reason any data stored in
> those partitions wouldn't be invalid, and it will suddenly cut them off. Is this a
> rare enough occurrence that we don't care?

I am one of those guys using Sun disklabels with sizes > 1TB. And I would highly appreciate if nobody out there would make my disk drive useless by simply discarding anything larger than 1 TB. This would render our department server useless, what is everything but desirable :-)

Fdisk says:

Kommando (m für Hilfe): 
Disk /dev/sda (Sun disk label): 1024 heads, 63 sectors, 36187 cylinders
Units = Zylinder of 64512 * 512 bytes

    Gerät Flag    Start       End    Blocks   Id  System
/dev/sda1             0         1     32256   83  Linux native
/dev/sda2  u          1        64   2032128   82  Linux Swap
/dev/sda3             0     36187 -980235776    5  Whole disk
/dev/sda4            64       320   8257536    1  Boot
/dev/sda5           320      4864 146571264   83  Linux native
/dev/sda6          4864     16384 371589120   83  Linux native
/dev/sda7         16384     36187 638765568   83  Linux native

Kommando (m für Hilfe): 

cat /proc/partitions says:
/home/fred> cat /proc/partitions 
major minor  #blocks  name

   8     0 1171874880 sda
   8     1      32256 sda1
   8     2    2032128 sda2
   8     3 -980235776 sda3
   8     4    8257536 sda4
   8     5  146571264 sda5
   8     6  371589120 sda6
   8     7  638765568 sda7

but do not leave sda3 useless by changing the code. If there would be a chance to make fdisk and /proc/partitions not to display negative numbers (since, though obvious, they are nonsense) it would be preferrable.

Many thanks for your help,
take care


Dieter Jurzitza

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

