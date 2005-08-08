Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750736AbVHHGQC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750736AbVHHGQC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 02:16:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750737AbVHHGQC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 02:16:02 -0400
Received: from dvhart.com ([64.146.134.43]:8321 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S1750736AbVHHGQC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 02:16:02 -0400
Date: Sun, 07 Aug 2005 23:16:07 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
Reply-To: "Martin J. Bligh" <mbligh@mbligh.org>
To: Nikhil Dharashivkar <nikhildharashivkar@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] remove warning about e1000_suspend
Message-ID: <394740000.1123481766@[10.10.2.4]>
In-Reply-To: <17db6d3a05080723096ec26531@mail.gmail.com>
References: <256850000.1123442258@10.10.2.4> <17db6d3a05080723096ec26531@mail.gmail.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--Nikhil Dharashivkar <nikhildharashivkar@gmail.com> wrote (on Monday, August 08, 2005 11:39:07 +0530):

> Hi Martin,
>     But e1000_notify_reboot () function calls this e1000_suspend()
> function irrespective of  CONFIG_FM is defined or not. So according to
> your soution, what if CONFIG_FM is not defined.

Odd. I wonder why I get a warning then. Hmmmm ....

M.

> On 8/8/05, Martin J. Bligh <mbligh@mbligh.org> wrote:
>> e1000_suspend is only used under #ifdef CONFIG_PM. Move the declaration
>> of it to be the same way, just like e1000_resume, otherwise gcc whines
>> on compile. I offer as evidence:
>> 
>>         static struct pci_driver e1000_driver = {
>>                .name     = e1000_driver_name,
>>               .id_table = e1000_pci_tbl,
>>               .probe    = e1000_probe,
>>               .remove   = __devexit_p(e1000_remove),
>>               /* Power Managment Hooks */
>>         # ifdef CONFIG_PM
>>                .suspend  = e1000_suspend,
>>                .resume   = e1000_resume
>>         # endif
>>         };
>> 
>> 
>> diff -aurpN -X /home/fletch/.diff.exclude virgin/drivers/net/e1000/e1000_main.c e1000_suspend/drivers/net/e1000/e1000_main.c
>> --- virgin/drivers/net/e1000/e1000_main.c       2005-08-07 09:15:36.000000000 -0700
>> +++ e1000_suspend/drivers/net/e1000/e1000_main.c        2005-08-07 12:10:42.000000000 -0700
>> @@ -162,8 +162,8 @@ static void e1000_vlan_rx_add_vid(struct
>>  static void e1000_vlan_rx_kill_vid(struct net_device *netdev, uint16_t vid);
>>  static void e1000_restore_vlan(struct e1000_adapter *adapter);
>> 
>> -static int e1000_suspend(struct pci_dev *pdev, uint32_t state);
>>  # ifdef CONFIG_PM
>> +static int e1000_suspend(struct pci_dev *pdev, uint32_t state);
>>  static int e1000_resume(struct pci_dev *pdev);
>>  # endif
>> 
>> @@ -3641,6 +3641,7 @@ e1000_set_spd_dplx(struct e1000_adapter
>>         return 0;
>>  }
>> 
>> +#ifdef CONFIG_PM
>>  static int
>>  e1000_suspend(struct pci_dev *pdev, uint32_t state)
>>  {
>> @@ -3733,7 +3734,6 @@ e1000_suspend(struct pci_dev *pdev, uint
>>         return 0;
>>  }
>> 
>> -#ifdef CONFIG_PM
>>  static int
>>  e1000_resume(struct pci_dev *pdev)
>>  {
>> 
>> -
>> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> Please read the FAQ at  http://www.tux.org/lkml/
>> 
> 
> 
> -- 
> Thanks and Regards,
>          Nikhil.
> 
> 
> 


