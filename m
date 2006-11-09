Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966034AbWKIOj4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966034AbWKIOj4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 09:39:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966035AbWKIOj4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 09:39:56 -0500
Received: from smtpout04-04.prod.mesa1.secureserver.net ([64.202.165.199]:32460
	"HELO smtpout04-04.prod.mesa1.secureserver.net") by vger.kernel.org
	with SMTP id S966034AbWKIOjz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 09:39:55 -0500
Message-ID: <45533DB9.4000405@seclark.us>
Date: Thu, 09 Nov 2006 09:39:53 -0500
From: Stephen Clark <Stephen.Clark@seclark.us>
Reply-To: Stephen.Clark@seclark.us
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.16-22smp i686; en-US; m18) Gecko/20010110 Netscape6/6.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: =?ISO-8859-1?Q?=22=5C=22J=2EA=2E=5C=22_Magall=F3n=22?= 
	<jamagallon@ono.com>,
       =?ISO-8859-1?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>,
       Mark Lord <lkml@rtr.ca>, linux-kernel <linux-kernel@vger.kernel.org>,
       alan@lxorguk.ukuu.org.uk
Subject: Re: Abysmal PATA IDE performance
References: <455206E7.2050104@seclark.us> <45526D50.5020105@rtr.ca>	 <455277E1.3040803@seclark.us> <20061109020758.GA21537@atjola.homenet>	 <4552A638.4010207@seclark.us>  <20061109094014.1c8b6bed@werewolf-wl> <1163062700.3138.467.camel@laptopd505.fenrus.org>
In-Reply-To: <1163062700.3138.467.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:

>>Probably your drives are renamed.
>>Before you had (wild guess, look at your boot log messages):
>>- ata bus -> hdc,hdd
>>- sata -> sda (if you really have any sata bus...)
>>
>>Now all hdX become sdX, and PATA is detected _before_ SATA, so you names
>>probaly became:
>>- ata via libata -> sda (HD), sr0 (CDROM)
>>- sata -> sdb.
>>    
>>
>
>on fedora this doesn't matter (due to mount-by-label)
>
>the bigger problem I suspect is that the sata modules aren't part of the
>initrd!
>
>you can force the issue by adding
>
>alias scsi_hostadapter1 ata_piix
>
>to the /etc/modprobe.conf file, and then recreating the initrd
>(see the mkinitrd tool, or just install the kernel rpm)
>
>
>
>
>  
>
Thanks all.

Arjan, using combined_mode=libata and making a new ramdisk increased my 
xfer rate from 1.xx mb/sec to 28.xx mb/sec.

I am curious as to why my friends dell inspiron 8200 with a 1.8ghz p4 
and the same drive using the same drive with FC6 and the standard ide 
module gets 44 to 45 mb/sec.

Steve

-- 

"They that give up essential liberty to obtain temporary safety, 
deserve neither liberty nor safety."  (Ben Franklin)

"The course of history shows that as a government grows, liberty 
decreases."  (Thomas Jefferson)



