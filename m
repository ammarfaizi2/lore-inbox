Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262499AbVCJAou@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262499AbVCJAou (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 19:44:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262192AbVCJAkt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 19:40:49 -0500
Received: from vms048pub.verizon.net ([206.46.252.48]:19170 "EHLO
	vms048pub.verizon.net") by vger.kernel.org with ESMTP
	id S262536AbVCJAht (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 19:37:49 -0500
Date: Wed, 09 Mar 2005 19:37:47 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: 2.6.11-mm2 vs audio for kino and tvtime
In-reply-to: <20050309203317.64916119.khali@linux-fr.org>
To: linux-kernel@vger.kernel.org
Cc: Jean Delvare <khali@linux-fr.org>, Andrew Morton <akpm@osdl.org>,
       linux1394-devel@lists.sourceforge.net, video4linux-list@redhat.com,
       sensors@stimpy.netroedge.com
Reply-to: gene.heskett@verizon.net
Message-id: <200503091937.47733.gene.heskett@verizon.net>
Organization: None, usuallly detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <200503082326.28737.gene.heskett@verizon.net>
 <200503090243.06270.gene.heskett@verizon.net>
 <20050309203317.64916119.khali@linux-fr.org>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 09 March 2005 14:33, Jean Delvare wrote:
>Hi Gene, Andrew, all,
>[Gene Heskett]
>
>> /usr/pcHDTV3000/linux/pcHDTV-1.6/kernel-2.6.x/driver/bttv-i2c.c:36
>>2: error: unknown field `id' specified in initializer
>
>I've dropped the "id" member of struct i2c_client, as it were
> useless. Third-party driver authors now need to do the same.
>
>Patches to pcHDTV 1.6 and 2.0 attached (untested). Feel free to push
> the latter to the author of hdPCTV. Note that the removed struct
> member was really not used before, so the driver will still work
> with earlier kernels.

I unpacked and patched the pcHDTV-2.0 driver kit, but the make bails 
out with this:

/usr/src/pcHDTV-2.0/cx88-cards.c: In function `hauppauge_eeprom_dvb':
/usr/src/pcHDTV-2.0/cx88-cards.c:772: warning: control reaches end of 
non-void function
[...]

That one I may be able to fix, probably a braces error.
Then 10 lines or so later:

 CC [M]  /usr/src/pcHDTV-2.0/saa7134-tvaudio.o
/usr/src/pcHDTV-2.0/saa7134-tvaudio.c: In function 
`saa7134_tvaudio_init2':
/usr/src/pcHDTV-2.0/saa7134-tvaudio.c:988: warning: implicit 
declaration of function `DECLARE_MUTEX_LOCKED'
/usr/src/pcHDTV-2.0/saa7134-tvaudio.c:988: error: `sem' undeclared 
(first use in this function)
/usr/src/pcHDTV-2.0/saa7134-tvaudio.c:988: error: (Each undeclared 
identifier is reported only once
/usr/src/pcHDTV-2.0/saa7134-tvaudio.c:988: error: for each function it 
appears in.)
/usr/src/pcHDTV-2.0/saa7134-tvaudio.c:989: warning: ISO C90 forbids 
mixed declarations and code
make[2]: *** [/usr/src/pcHDTV-2.0/saa7134-tvaudio.o] Error 1
make[1]: *** [_module_/usr/src/pcHDTV-2.0] Error 2
make[1]: Leaving directory `/usr/src/linux-2.6.11.2-RT-V0.7.39-02'
make: *** [default] Error 2

Header file error?

I'll go try the 1.6 patch now.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.34% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.
