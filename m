Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131485AbRCWWZ5>; Fri, 23 Mar 2001 17:25:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131484AbRCWWYs>; Fri, 23 Mar 2001 17:24:48 -0500
Received: from ztxmail03.ztx.compaq.com ([161.114.1.207]:28421 "HELO
	ztxmail03.ztx.compaq.com") by vger.kernel.org with SMTP
	id <S131486AbRCWWYn>; Fri, 23 Mar 2001 17:24:43 -0500
Message-ID: <C50AB9511EE59B49B2A503CB7AE1ABD1128E0D@cceexc19.americas.cpqcorp.net>
From: "Cagle, John" <John.Cagle@COMPAQ.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Cc: "'marcus.meissner@caldera.de'" <marcus.meissner@caldera.de>,
        "'v.sweeney@dexterus.com'" <v.sweeney@dexterus.com>
Subject: Re: cpqarray & 2.4.1+ hang
Date: Fri, 23 Mar 2001 16:23:39 -0600
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2652.78)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcus Meissner wrote:
>> I have a problem with the 2.4 series kernel running on a number of
>> Compaq ProLiant DL360 servers. The 2.2.x kernels and 2.4.0 work fine,
>> however from 2.4.1 onwards the boxes just hang at the following position
>> on bootup:
>
>> Partition check: 
>> ida/c0d0:
>
>> I have also tested with 2.4.2-ac20 and the same problem occurs. Doing a
>> search on the web some people recommend changing the OS setting in the
>> Compaq BIOS to Linux fixes this problem, however my servers are already
>> running with this BIOS setting and I've also tested with numerous other
>> OS's in the BIOS but the same problem occurs.
>
>Workaround: run the kernel with the 'noapic' option on its commandline. 
>
>The ServerWorks chipset used in this Compaq Server somehow does not pass 
>the the relevant information to Linux mapping routines. :/ 
>

The real problem lies in the OSB4 driver beginning with the 2.4.0 kernel.
Its initialization of the OSB4 breaks APIC interrupt processing, causing a
lockup during boot of any APIC-enabled server that uses the OSB4.  Rolling
back to the version in 2.4.0-prerelease will resolve your lockup during
boot.  Alternatively, you can set CONFIG_BLK_DEV_OSB4=n in your .config.
This will revert to using the generic IDE driver instead of the
OSB4-specific code that is broken.  That's not a problem on ProLiants since
the OSB4 is only used to access the CD-ROM drive, hence you don't need any
enhanced performance.

Regards,
John Cagle
Principal Member Technical Staff
ProLiant Servers, Compaq

