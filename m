Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136771AbREIRdH>; Wed, 9 May 2001 13:33:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136772AbREIRc5>; Wed, 9 May 2001 13:32:57 -0400
Received: from 95-CORU-X9.libre.retevision.es ([62.83.52.95]:15753 "HELO
	trasno.mitica") by vger.kernel.org with SMTP id <S136771AbREIRct>;
	Wed, 9 May 2001 13:32:49 -0400
To: <whitney@math.berkeley.edu>
Cc: LKML <linux-kernel@vger.kernel.org>, <toddroy@softhome.net>
Subject: Re: 2.4.3-p8 pci_fixup_vt8363 + ASUS A7V "Optimal" = IDE disk corruption
In-Reply-To: <Pine.LNX.4.30.0103290931330.12531-100000@mf1.private>
X-Url: http://www.lfcia.org/~quintela
From: Juan Quintela <quintela@mandrakesoft.com>
In-Reply-To: <Pine.LNX.4.30.0103290931330.12531-100000@mf1.private>
Date: 09 May 2001 19:31:51 +0200
Message-ID: <m2eltyo2d4.fsf@trasno.mitica>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi
        sorry for the delay, it is working for your motherboard the
        lastest kernels of Mandrake?  I think that all the problems
        have been solved?

Sorry for the delay, as I was finishing more things.

Later, Juan.


>>>>> "wayne" == Wayne Whitney <whitney@math.berkeley.edu> writes:

wayne> On 29 Mar 2001, Juan Quintela wrote:
>> Hi I have the same motherboard and BIOS version.  I was having
>> filesystem corruption.  There is a bugfix (from Arjan van der Ven) in
>> the ac tree (around ac20 I think), could you test the last ac patch
>> and test if the filesystem corruption persist??

wayne> I took a look at 2.4.2-ac28; rather than test the kernel itself, I used
wayne> setpci to duplicate what the fixup function does.  The upshot is that
wayne> 2.4.2-ac28 does not cause any corruption with the ASUS A7V 1007 "Optimal".
wayne> Its pci_fixup_vt8363 function has a subset of the tests from 2.4.3-pre8,
wayne> namely it omits:

wayne> pci_read_config_byte(d, 0x54, &tmp);
wayne> if(tmp & (1)) {
wayne> printk("PCI: Fast Write to Read turnaround disabled\n");
wayne> pci_write_config_byte(d, 0x54, tmp & ~(1));
wayne> }
wayne> pci_read_config_byte(d, 0x70, &tmp);
wayne> if(tmp & (1<<2)) {
wayne> printk("PCI: Disabled Master Read Caching\n");
wayne> pci_write_config_byte(d, 0x70, tmp & ~(1<<2));
wayne> }

wayne> This second test was part of the 2.4.3-pre8 pci_fixup_vt8363 subset from
wayne> my previous email which causes corruption on the ASUS A7V 1007 for both
wayne> Optimal and Normal settings.  I verified that if I add it back in, I do
wayne> get corruption with ASUS A7V 1007 "Optimal".  By omitting it, I guess
wayne> 2.4.2-ac28 avoids the corruption of 2.4.3-pre8.

wayne> Perhaps 2.4.3-pre9 should adopt the pci_fixup_vt8363 from 2.4.2-ac28?
wayne> Below is a patch.

wayne> Cheers,
wayne> Wayne

wayne> --- linux-2.4.3-pre8/arch/i386/kernel/pci-pc.c	Wed Mar 28 22:56:04 2001
wayne> +++ linux-2.4.2-ac28/arch/i386/kernel/pci-pc.c	Wed Mar 28 22:51:00 2001
wayne> @@ -968,23 +971,13 @@
wayne> printk("PCI: Bus master Pipeline request disabled\n");
wayne> pci_write_config_byte(d, 0x54, tmp & ~(1<<2));
wayne> }
wayne> -	pci_read_config_byte(d, 0x54, &tmp);
wayne> -	if(tmp & (1)) {
wayne> -		printk("PCI: Fast Write to Read turnaround disabled\n");
wayne> -		pci_write_config_byte(d, 0x54, tmp & ~(1));
wayne> -	}
wayne> pci_read_config_byte(d, 0x70, &tmp);
wayne> if(tmp & (1<<3)) {
wayne> printk("PCI: Disabled enhanced CPU to PCI writes\n");
wayne> pci_write_config_byte(d, 0x70, tmp & ~(1<<3));
wayne> }
wayne> -	pci_read_config_byte(d, 0x70, &tmp);
wayne> -	if(tmp & (1<<2)) {
wayne> -		printk("PCI: Disabled Master Read Caching\n");
wayne> -		pci_write_config_byte(d, 0x70, tmp & ~(1<<2));
wayne> -	}
wayne> pci_read_config_byte(d, 0x71, &tmp);
wayne> -	if ((tmp & (1<<3))==0) {
wayne> +	if((tmp & (1<<3)) == 0) {
wayne> printk("PCI: Bursting cornercase bug worked around\n");
wayne> pci_write_config_byte(d, 0x71, tmp | (1<<3));
wayne> }


-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy
