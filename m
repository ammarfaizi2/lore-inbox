Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751085AbWGBRAs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751085AbWGBRAs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jul 2006 13:00:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751191AbWGBRAs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jul 2006 13:00:48 -0400
Received: from smtpout07-01.prod.mesa1.secureserver.net ([64.202.165.230]:16620
	"HELO smtpout07-04.prod.mesa1.secureserver.net") by vger.kernel.org
	with SMTP id S1751085AbWGBRAs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jul 2006 13:00:48 -0400
Message-ID: <44A7FBBE.9070809@seclark.us>
Date: Sun, 02 Jul 2006 13:00:46 -0400
From: Stephen Clark <Stephen.Clark@seclark.us>
Reply-To: Stephen.Clark@seclark.us
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.16-22smp i686; en-US; m18) Gecko/20010110 Netscape6/6.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Randy.Dunlap" <rdunlap@xenotime.net>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: isa_memcpy_fromio
References: <44A732E3.10202@seclark.us>	<1151834671.14346.5.camel@localhost.localdomain> <20060702090713.bd3a2e68.rdunlap@xenotime.net>
In-Reply-To: <20060702090713.bd3a2e68.rdunlap@xenotime.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy.Dunlap wrote:

>On Sun, 02 Jul 2006 11:04:31 +0100 Alan Cox wrote:
>
>  
>
>>Ar Sad, 2006-07-01 am 22:43 -0400, ysgrifennodd Stephen Clark:
>>    
>>
>>>Hello,
>>>
>>>what has isa_memcpy_fromio() changed to in kernel 2.6.17 from 2.6.16
>>>      
>>>
>>It was always meant as a transition interface (although it survived
>>incredibly long). All code that uses the ioremap is unaffected: ie
>>
>>	foo = ioremap(isa_addr, len);
>>	memcpy_fromio(foo + bar, buf, len2)
>>    
>>
>
>Stephen,
>There were only 3 drivers in 2.6.16 that used isa_memcpy_fromio().
>You can look at how they were changed for 2.6.17.
>
>drivers/net/hp100.c and hp-plus.c
>drivers/scsi/g_NCR5380.c
>
>---
>~Randy
>
>  
>
Thanks to everyone who replied - I am using a module from source forge, 
on my hp laptop,
called omnibook. It allows me to turn off the back light on my n5430. 
Below is the
function that uses isa_memcpy_fromio().

static int __init dmi_iterate(void (*decode)(struct dmi_header *))
{
    u8 buf[15];
    u32 fp=0xF0000;

#ifdef CONFIG_SIMNOW
    /*
     *      Skip on x86/64 with simnow. Will eventually go away
     *      If you see this ifdef in 2.6pre mail me !
     */
    return -1;
#endif

    while( fp < 0xFFFFF)
    {
        isa_memcpy_fromio(buf, fp, 15);
        if(memcmp(buf, "_DMI_", 5)==0 && dmi_checksum(buf))
        {
            u16 num=buf[13]<<8|buf[12];
            u16 len=buf[7]<<8|buf[6];
            u32 base=buf[11]<<24|buf[10]<<16|buf[9]<<8|buf[8];

            if(dmi_table(base,len,num,decode)==0)
                return 0;
        }
        fp+=16;
    }
    return -1;
}

Would someone recommend how this should be changed?

Thanks,
Steve

-- 

"They that give up essential liberty to obtain temporary safety, 
deserve neither liberty nor safety."  (Ben Franklin)

"The course of history shows that as a government grows, liberty 
decreases."  (Thomas Jefferson)



