Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270255AbTGWNFe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 09:05:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270262AbTGWNFd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 09:05:33 -0400
Received: from dsl2.external.hp.com ([192.25.206.7]:59399 "EHLO
	dsl2.external.hp.com") by vger.kernel.org with ESMTP
	id S270255AbTGWNFc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 09:05:32 -0400
Date: Wed, 23 Jul 2003 07:20:37 -0600
From: Grant Grundler <grundler@parisc-linux.org>
To: "David S. Miller" <davem@redhat.com>
Cc: grundler@parisc-linux.org, ak@suse.de, alan@lxorguk.ukuu.org.uk,
       James.Bottomley@SteelEye.com, axboe@suse.de, suparna@in.ibm.com,
       linux-kernel@vger.kernel.org, alex_williamson@hp.com,
       bjorn_helgaas@hp.com
Subject: Re: [RFC] block layer support for DMA IOMMU bypass mode II
Message-ID: <20030723132037.GA30550@dsl2.external.hp.com>
References: <20030708213427.39de0195.ak@suse.de> <20030708.150433.104048841.davem@redhat.com> <20030708222545.GC6787@dsl2.external.hp.com> <20030708.152314.115928676.davem@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="2B/JsCI69OhZNC5r"
Content-Disposition: inline
In-Reply-To: <20030708.152314.115928676.davem@redhat.com>
User-Agent: Mutt/1.3.28i
X-Home-Page: http://www.parisc-linux.org/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--2B/JsCI69OhZNC5r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 08, 2003 at 03:23:14PM -0700, David S. Miller wrote:
> dbench type stuff,

realizing dbench is blissfully ignorant of the system (2GB RAM),
for grins I ran "dbench 500" to see what would happen. The throughput
rate dbench reported continued to decline to ~20MB/s. This is about what
I would expect for one disk a 40MB/s SCSI bus.

Then dbench started spewing errors:
...
(7) ERROR: handle 13781 was not found
(6) open clients/client428 failed for handle 13781 (No such file or
directory)
(7) ERROR: handle 13781 was not found
(6) open clients/client423 failed for handle 13781 (No such file or directory)
(7) ERROR: handle 13781 was not found
(6) open clients/client48 failed for handle 13781 (No such file or directory)
(7) ERROR: handle 13781 was not found
(6) open clients/client55 failed for handle 13781 (No such file or directory)
(7) ERROR: handle 13781 was not found
(6) open clients/client419 failed for handle 13781 (No such file or directory)
(7) ERROR: handle 13781 was not found
(6) open clients/client415 failed for handle 13781 (No such file or directory)
...
write failed on handle 13783
write failed on handle 13707
write failed on handle 13808
write failed on handle 13117
write failed on handle 13850
write failed on handle 14000
write failed on handle 13767
write failed on handle 13787
...

NFC what that's all about. sorry - I have to punt on digging deeper.
I really need more guidance on
	(a) how much memory I should be testing with
	(b) how many spindles would be useful (I've got ~15 on each box)
	(c) how to tell dbench to use the FS mounted on the target disks.

I've attached the iommu stats in case anyone finds that useful.

grant

--2B/JsCI69OhZNC5r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=dbench-zx1-01

Hewlett Packard zx1 IOC rev 2.2
IO PDIR size    : 524288 bytes (65536 entries)
IO PDIR entries : 65224 free  312 used (0%)
Resource bitmap : 8192 bytes (65536 pages)
  Bitmap search : 63/106/605 (min/avg/max CPU Cycles)
pci_map_single():       139846 calls        139881 pages (avg 1000/1000)
pci_unmap_single:       473108 calls        736788 pages (avg 1557/1000)
pci_map_sg()    :        51256 calls        597211 pages (avg 11651/1000)
pci_map_sg()    : 734319 entries 333551 filled
pci_unmap_sg()  :       189496 calls        735471 pages (avg 3881/1000)

--2B/JsCI69OhZNC5r--
