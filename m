Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261482AbUCAXeY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Mar 2004 18:34:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261485AbUCAXeY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Mar 2004 18:34:24 -0500
Received: from hal-4.inet.it ([213.92.5.23]:56802 "EHLO hal-4.inet.it")
	by vger.kernel.org with ESMTP id S261482AbUCAXeV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Mar 2004 18:34:21 -0500
From: Fabio Coatti <cova@ferrara.linux.it>
Organization: FerraraLUG
To: "Brown, Len" <len.brown@intel.com>
Subject: Re: 2.6.3-mm1 and aic7xxx
Date: Tue, 2 Mar 2004 00:33:43 +0100
User-Agent: KMail/1.6
Cc: "Andrew Morton" <akpm@osdl.org>, <linux-kernel@vger.kernel.org>
References: <BF1FE1855350A0479097B3A0D2A80EE0028B41D7@hdsmsx402.hd.intel.com> <200403010139.28956.cova@ferrara.linux.it>
In-Reply-To: <200403010139.28956.cova@ferrara.linux.it>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Message-Id: <200403020033.43356.cova@ferrara.linux.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alle 01:39, lunedì 1 marzo 2004, Fabio Coatti ha scritto:
> Alle 00:45, lunedì 1 marzo 2004, Brown, Len ha scritto:
> > To verify with the latest software, please apply the latest ACPI patch
> > to 2.6.4-rc1:
> >
> > http://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/release/
> > 2.6.4/acpi-20040220-2.6.4.diff.gz
> >
> > If it works, then something else in -mm is causing your problem.  If it
> > fails, then something in the latest ACPI patch (which is included in
> > -mm1) is causing the failure.
>
> Tried, and with the patch all works just fine. So it can be something else,
> applied in -mm tree after 2.6.3-rc3-mm1, tha causes the failure; i'll try
> to have a look at changes, trying to find which one causes the problem.

I've just tried, as suggested by john stultz <johnstul@us.ibm.com> in  thread 
"2.6.3-mm3 hangs on  boot x440 (scsi?)":

>> Index: arch/i386/kernel/acpi/boot.c
>> ===================================================================
>> RCS file: /var/cvs/linux-2.6/arch/i386/kernel/acpi/boot.c,v
>> retrieving revision 1.10
>> diff -u -p -r1.10 boot.c
>> --- a/arch/i386/kernel/acpi/boot.c    17 Feb 2004 12:51:46 -0000      1.10
>> +++ b/arch/i386/kernel/acpi/boot.c    26 Feb 2004 16:34:12 -0000
>> @@ -506,24 +461,17 @@ acpi_boot_init (void)
>>
>>       acpi_lapic = 1;
>>
>> -#endif /*CONFIG_X86_LOCAL_APIC*/
>> +#endif /* CONFIG_X86_LOCAL_APIC */
>>
>>  #if defined(CONFIG_X86_IO_APIC) && defined(CONFIG_ACPI_INTERPRETER)
>>
>>       /*
>>        * I/O APIC
>> -      * --------
>>        */
>>
>> -     /*
>> -      * ACPI interpreter is required to complete interrupt setup,
>> -      * so if it is off, don't enumerate the io-apics with ACPI.
>> -      * If MPS is present, it will handle them,
>> -      * otherwise the system will stay in PIC mode
>> -      */
>> -     if (acpi_disabled || acpi_noirq) {
>> +     if (acpi_noirq) {
>>               return 1;
>> -        }
>> +     }
>>
>>       /*
>>        * if "noapic" boot option, don't look for IO-APICs
>
>
>That chunk shouldn't drop the "if (acpi_disabled ..." bit.
>Adding that check back in fixes it for me.

In fact, this fixes 2.6.4-rc1-mm1 and now I'm writing using that kernel. I 
don't knoe w if this is a quick hack or a definitive solution, but now mmX 
series works again for me, and scsi devices seems to be correctly handled.




-- 
Fabio Coatti       http://www.ferrara.linux.it/members/cova     
Ferrara Linux Users Group           http://ferrara.linux.it
GnuPG fp:9765 A5B6 6843 17BC A646  BE8C FA56 373A 5374 C703
Old SysOps never die... they simply forget their password.
