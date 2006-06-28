Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751524AbWF1Uut@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751524AbWF1Uut (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 16:50:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751525AbWF1Uut
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 16:50:49 -0400
Received: from wr-out-0506.google.com ([64.233.184.224]:58252 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751523AbWF1Uus (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 16:50:48 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=L12tqOLElTjDNyoYXInrOAUnZTHc+3E/LnK+cho/SebE+V2xmPJ/LDbv8Kw39QT4hW65pFLyZGMxS19fRHO0tMsf45L02ZU1qjqA0My0Bz1t+QwKmik1ksPuSW2ND4u+5SROzactttCTB/19B+N/IQvQB8cNRTbrap0/59M10zU=
Message-ID: <38b19aa60606281350s21b0355oe0a743fba995af50@mail.gmail.com>
Date: Wed, 28 Jun 2006 13:50:47 -0700
From: "Hareesh Nagarajan" <hnagar2@gmail.com>
To: "Joshua Hudson" <joshudson@gmail.com>
Subject: Re: losetup behavior
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <bda6d13a0606281313y733d6b63i80f672e233f9aeea@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <38b19aa60606281254v43a7639dl4c74a57503c65dec@mail.gmail.com>
	 <bda6d13a0606281313y733d6b63i80f672e233f9aeea@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/28/06, Joshua Hudson <joshudson@gmail.com> wrote:
> On 6/28/06, Hareesh Nagarajan <hnagar2@gmail.com> wrote:
> > In my example below I have an image of an entire disk /dev/sda created
> > using the dd command. The name of the file is foo.img. There are
> > (internally) 3 partitions. ext2 (root), swap, ext2 (data). I will
> > extract the third partition, first with dd and show that it works and
> > then with losetup and show that it doesn't work.
> >
> > With dd:
> > root: / # dd if=foo.img of=part3 bs=512 skip=12402180 count=21141540
> > (Partition 3 begins at: 12402180 * 512 = 6349916160 bytes from start)
> >
> > root: / # mount -o loop=/dev/loop0 part3 mypart3/
> > root: microv3/ # cd mypart3/; ls
> > blah/ blah-blah/
> >
> > *works*
> >
> > With losetup:
> > root: # losetup -o6349916160 /dev/loop0 foo.img
> > root: # mount /dev/loop0 mypart3/
> > mount: you must specify the filesystem type
> > root: / # mount -t ext2 /dev/loop0 mypart3
> > mount: wrong fs type, bad option, bad superblock on /dev/loop5,
> > or too many mounted file systems
> >
> > *doesn't work*
> >
> If I had to guess, I would say you have an old version of losetup and
> this is an integer overflow problem. Maybe post an strace of the
> losetup command that doesn't work. Probably it won't help.

[ CCing: linux-kernel ]

Yeah, upgrading losetup fixed it. apt-get install loop-aes-utils

Thanks,
-- 
./hareesh
