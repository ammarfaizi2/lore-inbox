Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261230AbREVKe6>; Tue, 22 May 2001 06:34:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261242AbREVKei>; Tue, 22 May 2001 06:34:38 -0400
Received: from bsd.ite.com.tw ([210.208.198.222]:7442 "EHLO bsd.ite.com.tw")
	by vger.kernel.org with ESMTP id <S261230AbREVKeY>;
	Tue, 22 May 2001 06:34:24 -0400
From: Rich.Liu@ite.com.tw
Message-ID: <412C066DD818D3118D4300805FD4667902090B88@ITEMAIL>
To: linux-kernel@vger.kernel.org
Subject: [newbie] some problem in my new hardware (serial)
Date: Tue, 22 May 2001 18:32:24 +0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="Big5"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I went to port a new hardware into linux kernel.

this is a generic SuperIO chip . have 2serial port 1parallel

in serial.c 's struct
static struct pci_board pci_boards[] __devinitdata = {

add my code 

	{	PCI_VENDOR_ID_ITE, PCI_DEVICE_ID_ITE_8872,
		PCI_ANY_ID, PCI_ANY_ID,
		SPCI_FL_BASE1| SPCI_FL_BASE_TABLE, 2, 115200,
		0, 0, pci_ite8872_fn, 0 },

pci_ite8872_fn don't have code ... it's a null function

after this , I load my kernel modules
this function will clean hardware's Interrupt Request Register.

void ite8872_requestirq(int irq,void *dev_id,struct pt_regs *regs){
	u8 itmp;
	itmp = inb(ITE8872_INTC+2);
    outb(itmp,ITE8872_INTC); // Clean Interrupt
}

when I configure hardware , i reload serial.o , I can get those message
May 22 18:21:43 sddlinux kernel: PCI: Found IRQ 10 for device 00:0b.0
May 22 18:21:43 sddlinux kernel: Setup PCI/PNP port: port b400, irq 10, type
0
May 22 18:21:43 sddlinux kernel: Testing ttyS4 (0xb400, 0x0000)...
May 22 18:21:43 sddlinux kernel: ttyS04 at port 0xb400 (irq = 10) is a
16550A
May 22 18:21:43 sddlinux kernel: Setup PCI/PNP port: port b000, irq 10, type
0
May 22 18:21:43 sddlinux kernel: Testing ttyS5 (0xb000, 0x0000)...
May 22 18:21:43 sddlinux kernel: ttyS05 at port 0xb000 (irq = 10) is a
16550A
I think this is would setup my hardware correct ....

but if I use minicom to access this comport .  will give me a message
"starting up ttys5 (irq 10)...rs_open ttys0 success"

and repeat this message 
"rs_interrupt_single(10)... status = 60 ...IIR = c1 ...end.
many times, and kernel hangs .
I must use hardware restart to reboot my computer .

I have no idea to programming next step , could anyone can help me to
program it ?


--                                                      
Integrated Technology Express, INC.
Rich Liu
E-mail : rich.liu@ite.com.tw
Tel : +886 (3) 579-8658 Ext : 28221            

