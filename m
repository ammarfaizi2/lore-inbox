Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261834AbVBXJZu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261834AbVBXJZu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 04:25:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262113AbVBXJZu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 04:25:50 -0500
Received: from kunet.com ([69.26.169.26]:23300 "EHLO kunet.com")
	by vger.kernel.org with ESMTP id S261834AbVBXJZi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 04:25:38 -0500
Message-ID: <004501c51a52$c4200380$7101a8c0@shrugy>
From: "Ammar T. Al-Sayegh" <ammar@kunet.com>
To: "Arjan van de Ven" <arjan@infradead.org>
Cc: <linux-kernel@vger.kernel.org>
References: <009d01c519e8$166768b0$7101a8c0@shrugy> <1109192040.6290.108.camel@laptopd505.fenrus.org> <003001c519f1$031afc00$7101a8c0@shrugy> <1109196074.6290.116.camel@laptopd505.fenrus.org> <007d01c519f9$7c9a5f50$7101a8c0@shrugy> <1109234333.6530.19.camel@laptopd505.fenrus.org>
Subject: Re: kernel BUG at mm/rmap.c:483!
Date: Thu, 24 Feb 2005 04:25:09 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="Windows-1252";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2180
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>  really; it was supposed to do that already
>> > 
>> >> i2c_dev                13249  0 
>> >> i2c_core               24513  1 i2c_dev
>> > 
>> > try for fun to not use i2c for a while
>> > 
>> >> microcode              11489  0 
>> > same for microcode... try removing that so that the microcode of your
>> > system doesn't get updated at boot
>> 
>> What do these two modules do in particular? and how can I disable
>> them so that they don't get reloaded during boot time? do I need
>> to disable both i2c_dev and i2c_core or just one of them?
> 
> i2c is used to directly talk to motherboard hardware such as temperature
> sensors. I've seen cases of certain chipset bugs leading to cacheline
> corruption when stuff talked to the slow i2c bus and did other stuff in
> parallel. 
> 
> microcode changes the microcode of the cpu (a part of your cpu is
> actually written in "software" that can be updated); however updating
> this behind the back of the bios might not always be a good idea. (but I
> have no hard proof of any failures due to this)
> 
> As for how to disable these.. you could just rename the respective .ko
> files to .notko or something....

Done. Following is my new loaded module list:

[root ~]# lsmod 
Module                  Size  Used by
ip_conntrack_ftp       76145  0 
md5                     8001  1 
ipv6                  236769  38 
autofs4                21829  0 
sunrpc                135077  1 
ipt_REJECT             10561  2 
ipt_state               5825  79 
ip_conntrack           45317  2 ip_conntrack_ftp,ipt_state
iptable_filter          7489  1 
ip_tables              20929  3 ipt_REJECT,ipt_state,iptable_filter
dm_mod                 57925  0 
video                  19653  0 
button                 10577  0 
battery                13253  0 
ac                      8773  0 
uhci_hcd               33497  0 
ehci_hcd               33737  0 
e1000                  84629  0 
floppy                 56913  0 
ext3                  117961  6 
jbd                    57177  1 ext3
3w_xxxx                30561  0 
ata_piix               12485  7 
libata                 44101  1 ata_piix
sd_mod                 20545  9 
scsi_mod              116033  3 3w_xxxx,libata,sd_mod

Looks better now?

I guess I can no longer monitor the processor temperature and
such after preventing i2c from loading, but what what's the
penalty of preventing microcode from loading? a performance
hit?

I will be testing memory as suggested by Hugh Dickins as well.
Hopefully, your trick or Hugh's suggestion will help revealing
the source of the problem, if not the kernel itself.


-ammar
