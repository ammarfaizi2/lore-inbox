Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310150AbSCFTxr>; Wed, 6 Mar 2002 14:53:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310149AbSCFTx2>; Wed, 6 Mar 2002 14:53:28 -0500
Received: from exchange.macrolink.com ([64.173.88.99]:34054 "EHLO
	exchange.macrolink.com") by vger.kernel.org with ESMTP
	id <S310139AbSCFTxK>; Wed, 6 Mar 2002 14:53:10 -0500
Message-ID: <11E89240C407D311958800A0C9ACF7D13A76D9@EXCHANGE>
From: Ed Vance <EdV@macrolink.com>
To: "'fabrizio.gennari@philips.com'" <fabrizio.gennari@philips.com>
Cc: "'linux-kernel'" <linux-kernel@vger.kernel.org>,
        "'linux-serial'" <linux-serial@vger.kernel.org>
Subject: RE: Oxford Semiconductor's OXCB950 UART not recognized by serial.
		c
Date: Wed, 6 Mar 2002 11:53:07 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 06, 2002, fabrizio.gennari@philips.com wrote:
> As you probably have noticed, the last two entries of 
> serial_pci_tbl[] match PCI_ANY_ID for both vendor and device, 
> respectively for serial ports and modems. Therefore, any 
> serial or modem PCI card is in serial_pci_tbl[]! 

Yes I saw that, but it would not probe my ST16C654 based 
card unless there was a specific table entry for it. That's 
why I thought something in there was broken. I will try again 
with an OX16C954 based card. Maybe my 654 card is weird. 

> The associated entry in pci_boards[] is pbn_default (=0). 
> So, all "pbn_default" entries that match 
> serial_pci_guess_board() are marked as redundant!

Yes. Assuming an unknown card can get probed, the code that 
calls serial_pci_guess_board is definitely broken. At least,
the test for "no matching specific list entry" is broken. 
Do you know of any valid reason for the driver to message 
about devices that were found in the specific list entries, 
regardless of what the guess function detects?

> Probably, the right way could be to replace the message 
> "Redundant entry" with something like:
> "The settings of your serial card (vendor_id:dev_id) have 
> been successfully guessed. In order to help developers add 
> a proper entry for your card, send this message along with 
 
If the settings were successfully guessed, why do we need a 
proper entry? Shouldn't the specific id portion of the list 
contain only devices that cannot be successfully guessed? 
In essence, shouldn't all "single bare UART interface" 
serial and modem cards work *without* an id table entry? 
That's what the older driver version does. 

> the output of lspci -vv to an_address_where_somebody_reads_
> your_messages@unlike_serial_pci_info_where_nobody_cares_
> about_you". 

If we must log a message, shouldn't it be PCI id and class 
info about cards that did not match and could not be guessed. 
I think we are not supposed to do that because another driver 
may yet attach the device. (Somebody please correct me if 
that's not right.) 

> By the way, here is a patch that adds OXCB950 properly to 
> serial_pci_tbl[]. pbn_b0_bt_1_115200 has been used instead 
> of pbn_b0_1_115200, because the latter is identical to 
> pbn_default, and the effect should be the same since 
> OXCB950 is single-port. 
> 
> Another proposed change: why not create separate entries in 
> pci_boards[] for pbn_b0_1_115200 and pbn_default?

I already have your patch. Thanks. Yes, the "no matching 
specific list entry" test is broken. 

I have been porting the known patches to 2.4.19-pre2 and 
breaking them down to single ideas, and will start submitting 
them shortly. Everything will be on linux-serial for comment. 

Best regards,
Ed Vance

