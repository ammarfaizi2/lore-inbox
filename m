Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261734AbVDENoG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261734AbVDENoG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 09:44:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261742AbVDENoF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 09:44:05 -0400
Received: from rproxy.gmail.com ([64.233.170.202]:6421 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261734AbVDENnd convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 09:43:33 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=GeNB2XS0m8Kqh8gLxUXtk4MZ4GNNqiz3R3Ut29v6Z5HFm+GvUilr7Qg8TC2GLjr5Wi7Y8tlyWtRvsQnp7vqeD4vvTl4l+Ww2d1M4Oras89ghwHyKwehu7rtGO/mo0ujfMSRM67ZvGHo/mOEx3JRDCpf1+E09U2Jl1cpKN3EiuyE=
Message-ID: <6f6293f10504050643e50a1f9@mail.gmail.com>
Date: Tue, 5 Apr 2005 14:43:30 +0100
From: Felipe Alfaro Solana <felipe.alfaro@gmail.com>
Reply-To: Felipe Alfaro Solana <felipe.alfaro@gmail.com>
To: Wiktor <victorjan@poczta.onet.pl>
Subject: Re: crypting filesystems
Cc: Andreas Hartmann <andihartmann@freenet.de>, linux-kernel@vger.kernel.org
In-Reply-To: <4251A8C4.60007@poczta.onet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
References: <42511AE5.1060603@pD9F8754D.dip0.t-ipconnect.de>
	 <4251A8C4.60007@poczta.onet.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Apr 4, 2005 9:51 PM, Wiktor <victorjan@poczta.onet.pl> wrote:
> Hi,
> 
> I'm using the following method and it seems to be working fine
> (involving crypto-loop):
> 
> i have normal ext3 /boot partition, where i store kernel image & initrd.
> after lilo boots the kernel, initrd sets up /dev/loop0 to be
> crypto-loop/blowfish for /dev/hda1 (losetup /dev/loop0 /dev/hda1 -e
> blowfish). losetup asks for passphrase, and (if entered correctly),
> /dev/loop0 is mounted as root filesystem (it can be done also by simple
> mount call: mount /dev/hda1 /some-place -o rw,encryption=blowfish). for
> encrypting more filesystems with one passphrase, you can read it in
> shell script in non-echo-mode (if such exists, i'm not sure), and pass
> it to mount or losetup. crypto-loop makes possible to switch encryption
> type without modifying whole initrd.
> 
> Regarding your questions:
> 
>  > 1. In order to put in the passphrase just once a time at booting, I
> put the passphrase in a gpg-crypted file (cipher AES256 and 256Bit key
> size), which is decrypted at boot-time to /tmp (-> tmpfs) and
> immediately removed with shred, after activating the three partitions.
> Is it possible to see the cleartext password after this action in tmpfs?
> 
> Disk encryption usually protects from hardware-attacks (when hacker has
> physical access to the hardware). if you keep passphrase
> reversible-encrypted, attacker can read it and run brute-force attack
> using some huge-computing-capacity. is this what you want?
> 
>  > 2. Is it possible to gain the passphrase from the active encrypted
> partitions (because the passphrase is somewhere held in the RAM)?
> 
> Only when attacker has root privileges. But i'm not sure if it is
> possible to extract passphrase knowing both encrypted and not encrypted
> data. What i mean is that usually each filesystem begins with
> filesystem-specyfic-header, which is constant or similar to each other.
> so, if attacker has encrypted form of this header and can estimate
> unencryptes form, it can possibly gain the passphrase. (but therse are
> only my ideas, i don't know how the encryptino-algorithm works).

What´s kept in RAM is the AES key used to decrypt disk blocks.
However, the passphrase from which the AES key is derived (usually by
using a hash function) is not kept in memory.
