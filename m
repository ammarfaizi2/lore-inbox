Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261748AbTCaSF1>; Mon, 31 Mar 2003 13:05:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261749AbTCaSF1>; Mon, 31 Mar 2003 13:05:27 -0500
Received: from ip-161-71-171-238.corp-eur.3com.com ([161.71.171.238]:17092
	"EHLO columba.www.eur.3com.com") by vger.kernel.org with ESMTP
	id <S261748AbTCaSF0>; Mon, 31 Mar 2003 13:05:26 -0500
Message-ID: <3E88862C.10205@uklinux.net>
Date: Mon, 31 Mar 2003 19:17:16 +0100
From: Jon Burgess <jburgess@uklinux.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.3) Gecko/20030312
X-Accept-Language: en-gb, en-us
MIME-Version: 1.0
To: mmurray@deepthought.org
CC: linux-kernel@vger.kernel.org
Subject: Re: accessing ROM on Rage 128 chips in aty128fb
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Martin Murray (mmurray@deepthought.org) wrote:

 > Why does the linux PCI code not set up a mapping for the ROM
 > automatically?

It expects the BIOS to do it. You can force it to try with the option 
"pci=rom"

Assuming this is the active grahpics card, then you should be able to 
access the rom via the legacy VGA address range 0xc0000...0xc7fff which 
should be shown in /proc/iomem.

Try:
dd if=/dev/mem skip=768 bs=1k | od -x | more

In these days of integrated peripherals the graphics bios might not even 
be attached to the VGA controller. The VGA device in my i810 system 
doesn't even report an expansion rom.

 > and found that the X driver maps the ROM through configuration
 > space.

I'm fairly sure the XFree code falls back to the VGA region as well if 
it can't find anything else. I think this is true on my machine, the X 
log says:
... Primary V_BIOS Segment is 0xc000

	Jon



