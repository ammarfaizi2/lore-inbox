Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270468AbTGUQDj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 12:03:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270472AbTGUQDg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 12:03:36 -0400
Received: from wsip-68-99-153-203.ri.ri.cox.net ([68.99.153.203]:16302 "EHLO
	jaymale.blue-labs.org") by vger.kernel.org with ESMTP
	id S270468AbTGUQCw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 12:02:52 -0400
Message-ID: <3F1C1326.5080804@blue-labs.org>
Date: Mon, 21 Jul 2003 12:21:58 -0400
From: David Ford <david+powerix@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5b) Gecko/20030714
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Ivan Gyurdiev <ivg2@cornell.edu>, linux-kernel@vger.kernel.org,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Hans Reiser <reiser@namesys.com>
Subject: Re: TCQ problems in 2.6.0-test1: the summary
References: <3F19C838.8040301@cornell.edu> <20030721123334.GF10781@suse.de>
In-Reply-To: <20030721123334.GF10781@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 > > 4) Using a tcq-enabled kernel with queue depth of 8 results in

>>massive filesystem corruption for me, verified under reiserfs, and xfs.
>>Elevator choice does not appear to matter, while queue depth is
>>important - I do not appear to get filesystem corruption with queue
>>depth of 32. Reiser refuses to mount with such a kernel, and runs
>>--fix-fixable at boot time. This is reproducible every time.
>>    
>>
>
>This is really strange. The only difference between using 8 or 32 tags
>is when ide-disk stops attempting to queue. Are you getting any errors
>in dmesg when this happens? Reading the start io path for this, it looks
>correct to me. I'll have to try and reproduce when I get back.
>
On my laptop:

Here is the only thing that is similar on my system.  When TCQ is 
enabled, I have filesystem problems (minimal) every time I reboot and it 
nearly always affects the same files every time.  I too am using 
reiserfs.  I usually run reiserfsck and emerge the particular group of 
files.  For a while it was openssl libraries, now it's kde libraries.

Note, reiserfsck never indicates any problems were found or fixed but 
the problems are none-the-less fixed.  (reiser guys: reiserfsck 
--fix-fixable always results in "--fix-fixable ignored")

Also note that there is never any indication ever that something is 
wacky.  Just out of the blue a file or files are corrupt and the bootup 
result is the same every time.

(~) # hdparm -I /dev/hda |head -n10

/dev/hda:

ATA device, with non-removable media
        Model Number:       IC25N030ATCS04-0                       
        Serial Number:      CSL305DAGVK71A
        Firmware Revision:  CA3OA72A


On one of my servers:

TCQ fscks it up bad.  It ran for over a month on .73 with nary an issue 
then all of a sudden it started barfing within hours of boot complaining 
about:

Jul 19 10:55:31 james hdc: invalidating tag queue (0 commands)
Jul 19 10:55:41 james ide_tcq_intr_timeout: timeout waiting for 
completion interrupt

and further disk access causes D state.  I upgraded this machine to 
2.6.0-test1 and now it's having fits with apic or acpi but that's 
another email.  And a side note, if I have TCQ compiled in w/ 
2.6.0-test1, the kernel barfs a long 40+ function OOPS on bootup.  It's 
a 24/7 server so I haven't put a serial cable on it to capture the oops 
yet :/

(~) # hdparm -I /dev/hdc

/dev/hdc:

ATA device, with non-removable media
        Model Number:       IBM-DPTA-372050                        
        Serial Number:      JMYJMFZ1555
        Firmware Revision:  P76OA30A

more if desired.

Other than this, I don't see any filesystem issues.

david


