Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261378AbVDDUyo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261378AbVDDUyo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 16:54:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261388AbVDDUw1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 16:52:27 -0400
Received: from smtp6.poczta.onet.pl ([213.180.130.36]:12953 "EHLO
	smtp6.poczta.onet.pl") by vger.kernel.org with ESMTP
	id S261400AbVDDUsj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 16:48:39 -0400
Message-ID: <4251A8C4.60007@poczta.onet.pl>
Date: Mon, 04 Apr 2005 22:51:16 +0200
From: Wiktor <victorjan@poczta.onet.pl>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050329)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andreas Hartmann <andihartmann@freenet.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: crypting filesystems
References: <42511AE5.1060603@pD9F8754D.dip0.t-ipconnect.de>
In-Reply-To: <42511AE5.1060603@pD9F8754D.dip0.t-ipconnect.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm using the following method and it seems to be working fine 
(involving crypto-loop):

i have normal ext3 /boot partition, where i store kernel image & initrd. 
after lilo boots the kernel, initrd sets up /dev/loop0 to be 
crypto-loop/blowfish for /dev/hda1 (losetup /dev/loop0 /dev/hda1 -e 
blowfish). losetup asks for passphrase, and (if entered correctly), 
/dev/loop0 is mounted as root filesystem (it can be done also by simple 
mount call: mount /dev/hda1 /some-place -o rw,encryption=blowfish). for 
encrypting more filesystems with one passphrase, you can read it in 
shell script in non-echo-mode (if such exists, i'm not sure), and pass 
it to mount or losetup. crypto-loop makes possible to switch encryption 
type without modifying whole initrd.

Regarding your questions:

 > 1. In order to put in the passphrase just once a time at booting, I 
put the passphrase in a gpg-crypted file (cipher AES256 and 256Bit key 
size), which is decrypted at boot-time to /tmp (-> tmpfs) and 
immediately removed with shred, after activating the three partitions. 
Is it possible to see the cleartext password after this action in tmpfs?

Disk encryption usually protects from hardware-attacks (when hacker has 
physical access to the hardware). if you keep passphrase 
reversible-encrypted, attacker can read it and run brute-force attack 
using some huge-computing-capacity. is this what you want?

 > 2. Is it possible to gain the passphrase from the active encrypted 
partitions (because the passphrase is somewhere held in the RAM)?

Only when attacker has root privileges. But i'm not sure if it is 
possible to extract passphrase knowing both encrypted and not encrypted 
data. What i mean is that usually each filesystem begins with 
filesystem-specyfic-header, which is constant or similar to each other. 
so, if attacker has encrypted form of this header and can estimate 
unencryptes form, it can possibly gain the passphrase. (but therse are 
only my ideas, i don't know how the encryptino-algorithm works).

 > 4. Are there any master keys existing, which could be used to open 
every encrypted filesystem?

We all wish they are no such 'features'.

--
wixor
May the Source be with you.
