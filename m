Return-Path: <linux-kernel-owner+w=401wt.eu-S1161166AbWLPQet@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161166AbWLPQet (ORCPT <rfc822;w@1wt.eu>);
	Sat, 16 Dec 2006 11:34:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161168AbWLPQet
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Dec 2006 11:34:49 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:34767 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161166AbWLPQes (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Dec 2006 11:34:48 -0500
Message-ID: <45842025.5090906@garzik.org>
Date: Sat, 16 Dec 2006 11:34:45 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Alexey Dobriyan <adobriyan@gmail.com>
CC: andersen@codepoet.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] support HDIO_GET_IDENTITY in libata
References: <Pine.LNX.4.64.0612131744290.5718@woody.osdl.org> <200612141930.19797.s0348365@sms.ed.ac.uk> <Pine.LNX.4.64.0612141150480.5718@woody.osdl.org> <4581AEA0.3040708@garzik.org> <20061214202608.GA2313@codepoet.org> <20061215184543.GA6626@martell.zuzino.mipt.ru>
In-Reply-To: <20061215184543.GA6626@martell.zuzino.mipt.ru>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexey Dobriyan wrote:
> On Thu, Dec 14, 2006 at 01:26:08PM -0700, Erik Andersen wrote:
>> On Thu Dec 14, 2006 at 03:05:52PM -0500, Jeff Garzik wrote:
>>> FWIW, libata generally follows a "implement it, if enough people care
>>> about it" policy for the old HDIO_xxx ioctls.
>> I personally care about HDIO_GET_IDENTITY and find it terribly
>> useful to quickly find out about a drive.  Perhaps enough other
>> people care about this ioctl that it might make it into the official
>> libata tree.  Well tested with a number of months of use.
> 
>> --- orig/drivers/ata/libata-scsi.c
>> +++ linux-2.6.18/drivers/ata/libata-scsi.c
>> @@ -303,6 +303,172 @@
>>  	return rc;
>>  }
>>
>> +static void ide_fixstring (u8 *s, const int bytecount)
>> +{
>> +	u8 *p = s, *end = &s[bytecount & ~1]; /* bytecount must be even */
>> +
>> +#ifndef __BIG_ENDIAN
>> +# ifdef __LITTLE_ENDIAN
>> +	/* convert from big-endian to host byte order */
>> +	for (p = end ; p != s;) {
>> +		unsigned short *pp = (unsigned short *) (p -= 2);
>> +		*pp = ntohs(*pp);
>> +	}
>> +# else
>> +#  error "Please fix <asm/byteorder.h>"
>> +# endif
>> +#endif
> 
> Ugly. ntohs() will work on BE arches also.
> 
>> +static void ide_fix_driveid (struct hd_driveid *id)
>> +{
>> +#ifndef __LITTLE_ENDIAN
>> +# ifdef __BIG_ENDIAN
> 
> Ditto.

Agreed...

	Jeff



