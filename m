Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273443AbRINSob>; Fri, 14 Sep 2001 14:44:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273441AbRINSoW>; Fri, 14 Sep 2001 14:44:22 -0400
Received: from [195.66.192.167] ([195.66.192.167]:58893 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S272985AbRINSoI>; Fri, 14 Sep 2001 14:44:08 -0400
Date: Fri, 14 Sep 2001 21:43:03 +0300
From: VDA <VDA@port.imtp.ilyichevsk.odessa.ua>
X-Mailer: The Bat! (v1.44)
Reply-To: VDA <VDA@port.imtp.ilyichevsk.odessa.ua>
Organization: IMTP
X-Priority: 3 (Normal)
Message-ID: <1292125035.20010914214303@port.imtp.ilyichevsk.odessa.ua>
To: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
CC: linux-kernel@vger.kernel.org
Subject: Re: Athlon: Try this (was: Re: Athlon bug stomping #2)
In-Reply-To: <372BFCD7961@vcnet.vc.cvut.cz>
In-Reply-To: <372BFCD7961@vcnet.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Petr,
Saturday, September 15, 2001, 10:16:59 AM, you wrote:
PV> Hi,
PV>   I'll sleep much better with ...

>> +static void __init pci_fixup_athlon_bug(struct pci_dev *d)
>> +{ 
>> +       u8 v; 
>> +       printk("Trying to stomp on Athlon bug...\n");
>> +       pci_read_config_byte(d, 0x55, &v);
PV>+       if (v & 0x80) {
>> +           v &= 0x7f; /* clear bit 55.7 */
>> +           pci_write_config_byte(d, 0x55, v);
PV>+       }

How about this:

+static void __init pci_fixup_athlon_bug(struct pci_dev *d)
+{ 
+       u8 v; 
+       pci_read_config_byte(d, 0x55, &v);
+       if(v & 0x80) {
+               printk(KERN_NOTICE "Stomping on Athlon bug.\n");
+               v &= 0x7f; /* clear bit 55.7 */
+               pci_write_config_byte(d, 0x55, v);
+       }
+}

Well, these are cosmetic changes anyway...
What is more important now:
1) Do we have people who still see Athlon bug with the patch?
2) Do Alan read these messages? ;-)
-- 
Best regards, VDA
mailto:VDA@port.imtp.ilyichevsk.odessa.ua
http://port.imtp.ilyichevsk.odessa.ua/vda/


