Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964887AbWHWLPD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964887AbWHWLPD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 07:15:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964885AbWHWLPC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 07:15:02 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:33631 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S964883AbWHWLPA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 07:15:00 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:to:subject:cc:content-type:mime-version:in-reply-to:references:content-transfer-encoding:date:message-id:user-agent:from;
        b=BTYAIB+vEigNhSdSdEwa4avyNOozwvI1nnTlHruyjxSQM0i/H2pNpVgLfEq4FX+8S8aCnB1wLRuo90f85i49WuM7xESnBSyXTW/F7EDS8XANvMirYCAH3IEu8jQcptp6GXProOHgXFas0ydqI44EgKfg2snUiQ6ofoQO5aB46vw=
To: "Denis Vlasenko" <vda.linux@googlemail.com>
Subject: Re: Specify devices manually in exotic environment
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=US-ASCII;
	format=flowed	delsp=yes
MIME-Version: 1.0
In-Reply-To: <200608231210.27700.vda.linux@googlemail.com>
References: <op.teo9mqjlepq0rv@localhost> <200608231031.07024.vda.linux@googlemail.com> <op.teqd10ztepq0rv@localhost> <200608231210.27700.vda.linux@googlemail.com>
Content-Transfer-Encoding: 7BIT
Date: Wed, 23 Aug 2006 13:15:14 +0200
Message-ID: <op.teqhjoxhepq0rv@localhost>
User-Agent: Opera Mail/9.00 (Linux)
From: Milan Hauth <milahu@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Aug 2006 12:10:27 +0200, Denis Vlasenko
<vda.linux@googlemail.com> wrote:

>> > mknod /dev/root b "$ROOTMAJ" "$ROOTMIN"
>>
>> This also did not help -- 'cat: /dev/root: No such device or address'.
>> Major/minor is 4/0, as recommended in the kernel docs for /dev/root.
>
> What cat? Where did I say to cat anything? I said "create new node,
> namely, 'root', in the /dev, with the following major/minor#".

I did create the root node (b4/0). Just used cat for testing, since I
didn't have dd available yet on the initrd. But obviously it did not
work.. :-\


> If it doesn't work, maybe your initrd is mounted ro.
> Remount it rw first. Or mount a ramfs somewhere,
> it will give you writable place to play.
>
>> So where can I find my flash memory..? Again, with GRUB I just had to
>> specify the device address (0x80) and the kernel/initrd positions in
>> sector syntax, which works fine. Maybe I can do the same in Linux with  
>> my
>> ext2 partition, to specify the start and end sectors ('Specify drives
>> manually..'). But where to start?
>
> Start by reading boot messages. They ought to say
> what devices are found.

Ah, excellent: A IDE controller is found:

CS5530: IDE controller at PCI slot 0000:00:12.2

The according line in lspci:

00:12.2 0101: 1078:0102

And there are also two IDE interfaces:

PCI: Setting latency timer iof devvice 0000:00:12.0 to 64
      ide0: BM-DMA at 0xfb00-0xfb07, BIOS settings: hda: pio, hdb: pio
      ide1: BM-DMA at 0xfb08-0xfb0f, BIOS settings: hdc: pio, hdd: pio
Probing IDE interface ide0...
Probing IDE interface ide1...

..but no devices, which is logical: If there would be devices, I could use
them via /dev/hd*.

But why is the IDE controller being recognized, while no devices are
found..?


> Try hexdump'ing your sd devices:
>
> # dd if=/dev/sda bs=1024 count=1 | hexdump
>
> and see whether they give something like boot sector.

'No such device or address'.. I already tried special devices before,
forgot to mention.


Maybe I just gonna try to get some more information about my hardware and
recheck my Kernel configuration..

Cheers, milahu
