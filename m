Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290937AbSAaFXH>; Thu, 31 Jan 2002 00:23:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290938AbSAaFW5>; Thu, 31 Jan 2002 00:22:57 -0500
Received: from adsl-63-194-232-126.dsl.lsan03.pacbell.net ([63.194.232.126]:28676
	"HELO alpha.dyndns.org") by vger.kernel.org with SMTP
	id <S290937AbSAaFWm>; Thu, 31 Jan 2002 00:22:42 -0500
Message-ID: <3C58D69B.6000205@alpha.dyndns.org>
Date: Wed, 30 Jan 2002 21:31:07 -0800
From: Mark McClelland <mark@alpha.dyndns.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20011226
X-Accept-Language: en-us
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Dave Jones <davej@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>,
        linux-usb-devel@lists.sourceforge.net
Subject: Re: ov511 verbose startup.
In-Reply-To: <20020131023457.D31313@suse.de> <20020131035936.GD31006@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:

>On Thu, Jan 31, 2002 at 02:34:57AM +0100, Dave Jones wrote:
>
>>The changes to ov511 in 2.5.3 seem to generate excessive
>>amounts of blurb on boot up for me..
>>
>>ov511.c: USB OV511+ camera found
>>ov511.c: model: Creative Labs WebCam 3
>>ov511.c: Sensor is an OV7620
>>ov511.c: Device registered on minor 0
>>usbdevfs: USBDEVFS_CONTROL failed dev 2 rqt 128 rq 6 len 137 ret -75
>>usb_control/bulk_msg: timeout
>>usbdevfs: USBDEVFS_CONTROL failed dev 2 rqt 128 rq 6 len 18 ret -110
>>usb_control/bulk_msg: timeout
>>usbdevfs: USBDEVFS_CONTROL failed dev 2 rqt 128 rq 6 len 18 ret -110
>>...
>>repeat last two lines another dozen or so times...
>>
>
>What userspace program are you using that is talking to the usb device
>through usbfs?  Or is this usbutils trying to determine what driver to
>load?
>
I have been getting reports of -75 (babble?) and -110 errors with both 
control and iso transfers. The problematic kernels seem to be 2.4.17+, 
with uhci HCD. IIRC, nearly all of the reports mentioned a Via chipset. 
There are sporadic reports of corrupted iso packets (blocks of zeros 
inserted randomly) with uhci under 2.4.17 as well.

This is the first case of a usbfs-related ov511 error that I have seen. 
Very strange.

Greg (if you know): usbfs is not allowed to access claimed interfaces, 
correct? (ie. ones that are implicitly claimed because of a successful 
return from probe()). Are interfaces treated as claimed while probe() is 
active, so that user-space "probes" cannot interfere with driver probes()?

I use usb-uhci, uhci, and usb-ohci regularly with ov511, and I have 
never seen any of these problems. There are clearly a number of factors 
involved here.

-- 
Mark McClelland
mmcclell@bigfoot.com



