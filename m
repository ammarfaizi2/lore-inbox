Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751394AbWJMRcT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751394AbWJMRcT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 13:32:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751401AbWJMRcT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 13:32:19 -0400
Received: from wx-out-0506.google.com ([66.249.82.234]:35666 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751394AbWJMRcS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 13:32:18 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Q2P8SJnlYTsHf9VGKjr7HdE9LJUaVmjVLdkJrnIScMHqJDrKQTGoIoAdDV45uUqPvbGX4guq26kUQGYcucbZSZPKK39xtKq3wXfHyQjRN2nOmeZdo9VYcoZvpzqcW+Gkh8SJ2AkYGSTJzlYEN9LepfgcosJXIHctzvLDbAVRa0U=
Message-ID: <600c22710610131032u17a76999x403cab1c23f252af@mail.gmail.com>
Date: Fri, 13 Oct 2006 19:32:17 +0200
From: "Marko Vrh" <marko.vrh@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Bug: <NULL>-edge in /proc/interrupts
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On x86_64, kernel 2.6.19-rc1-git11 (but it's been like that since -rc1,
i think), /proc/interrupts shows:

  0:   25980801    <NULL>-edge     timer

It used to be Local-APIC-edge. The local APIC is used due to a chipset bug
(ATI RS480/SB400).

Regards.
--Marko

(Please cc: me in replies, i'm not on the list)

/proc/interrupts in full:
           CPU0
  0:   25980801    <NULL>-edge     timer
  1:      32668   IO-APIC-edge     i8042
  8:          0   IO-APIC-edge     rtc
 12:      27763   IO-APIC-edge     i8042
 14:     640128   IO-APIC-edge     libata
 15:         23   IO-APIC-edge     libata
 17:       8761   IO-APIC-fasteoi  ATI IXP
 19:      74283   IO-APIC-fasteoi  ehci_hcd:usb1, ohci_hcd:usb2, ohci_hcd:usb3
 20:          1   IO-APIC-fasteoi  yenta
 21:      96860   IO-APIC-fasteoi  acpi
 23:    7966724   IO-APIC-fasteoi  eth0
NMI:       1823
LOC:   25976459
ERR:        234

Reason for using local APIC:

..MP-BIOS bug: 8254 timer not connected to IO-APIC
Using local APIC timer interrupts.
result 12469249
Detected 12.469 MHz APIC timer.
