Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129047AbRBFIdc>; Tue, 6 Feb 2001 03:33:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129739AbRBFIdJ>; Tue, 6 Feb 2001 03:33:09 -0500
Received: from h179-210-243-135.iii.org.tw ([210.243.135.179]:31684 "EHLO
	mta0.iii.org.tw") by vger.kernel.org with ESMTP id <S129041AbRBFIdD>;
	Tue, 6 Feb 2001 03:33:03 -0500
Message-ID: <000f01c09017$847854e0$4c0c5c8c@trd.iii.org.tw>
From: "Greeen-III" <greeen@iii.org.tw>
To: <linux-mips-request@fnet.fr>,
        "LinuxEmbeddedMailList" <linux-embedded@waste.org>,
        "LinuxKernelMailList" <linux-kernel@vger.kernel.org>
Subject: Linux/MIPS high_memory!!
Date: Tue, 6 Feb 2001 16:33:42 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="big5"
Content-Transfer-Encoding: 8bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2314.1300
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2314.1300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All experts,

I am trying to port mips to my target board.
The board has two pieces of ram. One is addressed at 0x80000000(bank0).
The other is addressed at 0x82000000(bank1).
The loader will load the kernel and ramdisk to the bank0.
The ramdisk seems too small. The system will halt at gunzip() function.

So I modify the file "/linux-vr/arch/mips/ld.script".
>From the address ". = 0x80020000" to ". = 0x82020000 "
But the situation still exist.

I want to kernel to know how much memory he own?
How can I configure the kernel?
Where is the codes I should modify?

The following is the file "/linux-vr/arch/mips/ld.script"

+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
OUTPUT_FORMAT("elf32-littlemips")
OUTPUT_ARCH(mips)
ENTRY(kernel_entry)
SECTIONS
{
  /* Read-only sections, merged into text segment: */
  /******** Edit by Green ***********/
  /*. = 0x80020000; *//*. = 0x82800000; */
  . = 0x82020000;
  .init          : { *(.init)  } =0
  .text      :
  {
    _ftext = . ;
    *(.text)
    ......
    ......
}
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


************************************
* It's Green!! (萬林明)
* TEL: 886-2-23776100  ext.620
* mailto:greeen@iii.org.tw
* Working at III(資策會)
* 台北市大安區敦化南路二段216號12F
************************************



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
