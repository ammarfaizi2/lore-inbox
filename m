Return-Path: <linux-kernel-owner+w=401wt.eu-S932296AbWLLUXr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932296AbWLLUXr (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 15:23:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932333AbWLLUXr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 15:23:47 -0500
Received: from pne-smtpout3-sn2.hy.skanova.net ([81.228.8.111]:56519 "EHLO
	pne-smtpout3-sn2.hy.skanova.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932296AbWLLUXq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 15:23:46 -0500
Date: Tue, 12 Dec 2006 22:23:45 +0200
From: Sami Farin <7atbggg02@sneakemail.com>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: PROBLEM: 2.6.19 + highmem = BUG at do_wp_page
Message-ID: <20061212202345.GC3333@m.safari.iki.fi>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@osdl.org>,
	Chuck Ebbert <76306.1226@compuserve.com>
References: <200612121513_MC3-1-D4D1-4A51@compuserve.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200612121513_MC3-1-D4D1-4A51@compuserve.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2006 at 15:10:56 -0500, Chuck Ebbert wrote:
> In-Reply-To: <20061205172512.GA5518@m.safari.iki.fi>
> 
> On Tue, 5 Dec 2006 19:25:13 +0200, Sami Farin wrote:
> 
> > BUG: unable to handle kernel paging request at virtual address fffb9dc0
> 
> > eax: fffb8000   ebx: fffb9000   ecx: 00000090   edx: 00000000
> > esi: fffb9dc0   edi: fffb8dc0   ebp: f6f89f24   esp: f6f89ef0
> 
>   1f:   89 de                     mov    %ebx,%esi
>   21:   b9 00 04 00 00            mov    $0x400,%ecx
>   26:   89 45 cc                  mov    %eax,0xffffffcc(%ebp)
>   29:   89 c7                     mov    %eax,%edi
> 
>    0:   f3 a5                     repz movsl %ds:(%esi),%es:(%edi)   <=====
> 
> Processor started to copy a page, then with 576 bytes left to copy
> the source page got unmapped.  Nice.
> 
> This possibly happened during a device interrupt. What does
> /proc/interrupts say?

           CPU0       CPU1       
  0:    8253316    8272069   IO-APIC-edge      timer
  1:          2          0   IO-APIC-edge      i8042
  7:          0          0   IO-APIC-edge      parport0
  8:       6903          0   IO-APIC-edge      rtc
  9:          0          0   IO-APIC-fasteoi   acpi
 12:          4          0   IO-APIC-edge      i8042
 16:      63512      55991   IO-APIC-fasteoi   ide2, serial
 17:          0          0   IO-APIC-fasteoi   uhci_hcd:usb1
 18:          0          0   IO-APIC-fasteoi   uhci_hcd:usb5, ehci_hcd:usb6
 19:          3          0   IO-APIC-fasteoi   libata, ohci1394, uhci_hcd:usb4
 20:     105615          0   IO-APIC-fasteoi   eth0
 21:          0          0   IO-APIC-fasteoi   uhci_hcd:usb2
 22:      19245      19298   IO-APIC-fasteoi   uhci_hcd:usb3, ehci_hcd:usb7
 23:     148793     148782   IO-APIC-fasteoi   HDA Intel
NMI:          0          0 
LOC:   16200743   16201617 
ERR:          0
MIS:          0

BTW. do you add In-Reply-To line manually or is compuserve buggy?

-- 
