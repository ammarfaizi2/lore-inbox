Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293071AbSBWBdL>; Fri, 22 Feb 2002 20:33:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293070AbSBWBcw>; Fri, 22 Feb 2002 20:32:52 -0500
Received: from smtp3.hushmail.com ([64.40.111.33]:264 "HELO smtp3.hushmail.com")
	by vger.kernel.org with SMTP id <S293068AbSBWBct>;
	Fri, 22 Feb 2002 20:32:49 -0500
Message-Id: <200202230132.g1N1WYJ27596@mailserver2.hushmail.com>
From: mailerror@hushmail.com
To: linux-kernel@vger.kernel.org
Subject: loop under 2.2.20 - relative block support?
Date: Fri, 22 Feb 2002 17:32:34 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi,

What exactly is the status of the loopback device in 2.2.20 with regards
to relative block support? Is it *really* supported?

The reason I am asking is that I've run into trouble retrieving data off
of a loopback file after I switched to a new machine. I was using loopback
in combination with the kerneli patch to mount an encrypted filesystem
and backup my data to it for safe transport to another machine. The
decryption seems to be largely successful, since I am able to see most of
the data when peering at the decrypted file using a hexeditor.

However, there is very pervasive corruption going on in the decrypted file
and I am unable to even mount it. The first problem was that one of the
groups had completely bogus values for its block and inode bitmaps. E.g.
instead of 131073 (0x20001), the block bitmap for group 16 read 675963312.
This was fairly straightforward to sort out, but unfortunately it was only
one of many such "noise". For many inodes, the first couple of bytes are
corrupted, making some of the directories' inode types invalid and
preventing me from reading them. Another example was my secring.gpg, the
first block for which I found by searching through the image file. While
it was obvious that some of the data in there did, indeed, belong in my
keyring, the first two bytes didn't contain the magic 95 01 but something
random instead. Dumping that block to a file and changing the first two
bytes didn't make GPG too happy either (surprise, surprise...)

This has happened to 3 different backups, on different dates, and in
all cases the corruption follows the same pattern. Unfortunately I only
verified that I was able to read these files back on the original machine,
where everything worked fine. I now find myself in the unenviable
position of having unreadable backups, no originals, and only a limited
understanding of what is wrong.

As I said, I had compiled the kernel with encrypted loopback enabled. I
also specified CONFIG_BLK_DEV_LOOP_USE_REL_BLOCK since I expected to have
to move the backup files around. Now that I am in the process of trying
to understand the loopback code - and, to a large extent, the ext2 code as
well since I'm a complete novice to that - a comment in loop.c attracted
my attention. It said that the block number passed as IV to lower level
transfer functions is still the underlying device's block number instead
of the block within the loopback filesystem. I remember a discussion on
linux-kernel a long time ago
[http://www.uwsg.indiana.edu/hypermail/linux/kernel/0002.1/0923.html]
where it was proposed to pass relative block numbers along everywhere,
leaving it up to the encryption modules to calculate the absolute block
numbers where needed. This discussion centered around the 2.3 kernel,
though, if I remember correctly, and I used the 2.2 kernel.

My old machine was a Pentium II, and the new one is a Pentium III
Mobile. The kernel version was the same on both, since I installed the
kernel packages I compiled on the old machine as soon as I got the new
one. The files were encrypted using Serpent encryption. I burned them
onto CD before losing the old machine, then copied them from CD onto
my new machine.

I first posted on the linux-crypto list to see if somebody might
understand what's my problem, but now I believe it isn't really something
to do with encryption. If, for any reason, it would fail to decrypt
properly, then the result would be utter randomness wouldn't it? I wish I
had more of a clue what could be wrong...

If someone knows what might be wrong I'd very much appreciate any help,
suggestions or even (dare I hope?) outright solutions. I can provide more
data if I know what is needed, so please do ask.

Thanks in advance,
mailerror

p.s. I'd appreciate it if you CC'd me on any replies. I do read the list
but am not subscribed to it (yet).

Hush provide the worlds most secure, easy to use online applications - which solution is right for you?
HushMail Secure Email http://www.hushmail.com/
HushDrive Secure Online Storage http://www.hushmail.com/hushdrive/
Hush Business - security for your Business http://www.hush.com/
Hush Enterprise - Secure Solutions for your Enterprise http://www.hush.com/

-----BEGIN PGP SIGNATURE-----
Version: Hush 2.1
Note: This signature can be verified at https://www.hushtools.com

wl4EARECAB4FAjx28ToXHG1haWxlcnJvckBodXNobWFpbC5jb20ACgkQb539PwJB5JMN
MQCdHHlfwYfqjGNxF1GOXI6BFKURWIgAnA2wFCZp+UkBSw4htDeVGKHLHMQ3
=6wkj
-----END PGP SIGNATURE-----

