Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262161AbTLCVrV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 16:47:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262153AbTLCVrV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 16:47:21 -0500
Received: from chaos.analogic.com ([204.178.40.224]:11904 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262139AbTLCVrO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 16:47:14 -0500
Date: Wed, 3 Dec 2003 16:44:42 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Kallol Biswas <kbiswas@neoscale.com>
cc: linux-kernel@vger.kernel.org,
       "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: partially encrypted filesystem
In-Reply-To: <1070485676.4855.16.camel@nucleon>
Message-ID: <Pine.LNX.4.53.0312031627440.3725@chaos>
References: <1070485676.4855.16.camel@nucleon>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Dec 2003, Kallol Biswas wrote:

>
> Hello,
>       We have a requirement that a filesystem has to support
> encryption based on some policy. The filesystem also should be able
> to store data in non-encrypted form. A search on web shows a few
> encrypted filesystems like "Crypto" from Suse Linux, but we need a
> system  where encryption will be a choice per file. We have a hardware
> controller to apply encryption algorithm. If a filesystem provides hooks
> to use a hardware controller to do the encryption work then the cpu can
> be freed from doing the extra work.
>
> Any comment on this?
>
> Kallol
> NucleoDyne Systems.
> nucleon@nucleodyne.com
> 408-718-8164

I think you just need your application to encrypt data where needed.
Or to read/write to an encrypted file-system which always encrypts.
You really don't want policy inside the kernel.

Let's say you decided to ignore me and do it anyway. The file-systems
are a bunch of inodes. Every time you want to read or write one, something
has to decide if it's encrypted and, if it is, how to encrypt or
decrypt it. Even the length of the required read or write becomes
dependent upon the type of encryption being used. Surely you don't
want to use an algorithm where a N-byte string gets encoded into a
N-byte string because to do so gives away the length, from which
one can derive other aspects, resulting in discovering the true content.
So, you need variable-length inodes --- what a mess. The result
would be one of the slowest file-systems you could devise.

Encrypted file-systems, where you encrypt everything that goes
on the media work. Making something that could be either/or,
while possible, is not likely going to be very satisfying.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.22 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


