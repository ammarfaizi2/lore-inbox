Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751451AbWAKP0U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751451AbWAKP0U (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 10:26:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751459AbWAKP0U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 10:26:20 -0500
Received: from zproxy.gmail.com ([64.233.162.204]:13752 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751451AbWAKP0T convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 10:26:19 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=L5kfQeb/NR78vBL9jVX10XEqDktVgX2p9bMBlpyGoyvVWbZb/YOp1dyZ7rOb9ND0DO1d3rXVD2fxFjyg0hMoLLhSMdAHnXJ3YGWKHA+IhTH+1548UElhZrarp4DCMZEKV6rjBpAGTYwTxV805F0YvFozjHVzRjEGqnDa2djAv4o=
Message-ID: <5a2cf1f60601110726r46805e1dl784f0a0ca20c128@mail.gmail.com>
Date: Wed, 11 Jan 2006 16:26:18 +0100
From: jerome lacoste <jerome.lacoste@gmail.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: ata errors -> read-only root partition. Hardware issue?
Cc: Robert Hancock <hancockr@shaw.ca>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <5a2cf1f60601110552t5e9afa0dr7785b22ae6dbd99b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <5ttip-Xh-13@gated-at.bofh.it> <43C4493A.4010305@shaw.ca>
	 <5a2cf1f60601110030u358c12fcscf79067cbc3eebe0@mail.gmail.com>
	 <1136986688.28616.7.camel@localhost.localdomain>
	 <5a2cf1f60601110552t5e9afa0dr7785b22ae6dbd99b@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/11/06, jerome lacoste <jerome.lacoste@gmail.com> wrote:
> On 1/11/06, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> > On Mer, 2006-01-11 at 09:30 +0100, jerome lacoste wrote:
> > > - scan for bad blocks
> >
> > Read the entire disk (write will hide and clean up errors by
> > reallocating)
>
> something like should be sufficient right?
>
> cat /dev/sdax > /dev/null

I did something slightly different:

root@manies:~# cat /dev/sda > /dev/null
cat: /dev/sda: Input/output error

and in dmesg, problems show again:

ata3: status=0x51 { DriveReady SeekComplete Error }
ata3: error=0x40 { UncorrectableError }
ata3: status=0x51 { DriveReady SeekComplete Error }
ata3: error=0x40 { UncorrectableError }
ata3: status=0x51 { DriveReady SeekComplete Error }
ata3: error=0x40 { UncorrectableError }
ata3: status=0x51 { DriveReady SeekComplete Error }
ata3: error=0x40 { UncorrectableError }
ata3: status=0x51 { DriveReady SeekComplete Error }
ata3: error=0x40 { UncorrectableError }
SCSI error : <2 0 0 0> return code = 0x8000002
sda: Current: sense key: Medium Error
    Additional sense: Unrecovered read error - auto reallocate failed
end_request: I/O error, dev sda, sector 39088832
Buffer I/O error on device sda, logical block 4886104
ata3: status=0x51 { DriveReady SeekComplete Error }
ata3: error=0x40 { UncorrectableError }
....



smartmontools is unfortunately not installed but I probably don't need it.

Could something else (bad cable or disk controller ) trigger these issues?

It would be great if we users had a quick way to decipher these messages.

E.g.

"Buffer I/O error on device xxxx, logical block yyyyyyy"

Usualy a disk failure, may also be caused by....

Etc...

Noone has made an "Identifying Hardware failures HowTo"?

Jerome
