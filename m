Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273976AbRJDOYq>; Thu, 4 Oct 2001 10:24:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273994AbRJDOYg>; Thu, 4 Oct 2001 10:24:36 -0400
Received: from chaos.analogic.com ([204.178.40.224]:52609 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S273976AbRJDOYY>; Thu, 4 Oct 2001 10:24:24 -0400
Date: Thu, 4 Oct 2001 10:24:48 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: "Eric W. Biederman" <ebiederm@xmission.com>
cc: CaT <cat@zip.com.au>, linux-kernel@vger.kernel.org
Subject: Re: Kernel size
In-Reply-To: <m1zo77zh0h.fsf@frodo.biederman.org>
Message-ID: <Pine.LNX.3.95.1011004102214.21964A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4 Oct 2001, Eric W. Biederman wrote:

> CaT <cat@zip.com.au> writes:
>
> > On Thu, Oct 04, 2001 at 12:15:01AM -0600, Eric W. Biederman wrote:
[SNIPPED...]

> 
> I'd like to get a kernel, ramdisk, and some hw initialization code all
> on a 256KB ROM.  I have my ramdisk down to about 14KB compressed.  I
> have my hw initialization code down to 32KB uncompressed (and I might
> be able to reduce that further). So I want something like a 192KB
> (compressed) linux kernel.   
> 
> If I had that some of the hard problems of with linuxBIOS would just
> drop away.
> 


Major size differences seem to depend upon the C compiler being
used.

Here are two different systems with exactly the same kernel
with exactly the same ".config" file.

The kernel on one is compiled with whatever comes with RedHat.
The other is compiled with egcs-2.91.66.

We are looking at the compressed size!  The actual expanded size
difference is about 2:1 !

Script started on Thu Oct  4 10:10:31 2001
[root@blackhole /boot]# ls -la vmlinuz-2.4.1
-rw-r--r--    1 root     root       648638 Mar 12  2001 vmlinuz-2.4.1
[root@blackhole /boot]# gcc --version
2.96
[root@blackhole /boot]# exit
Script done on Thu Oct  4 10:11:11 2001

Script started on Thu Oct  4 10:11:26 2001
# gcc --version
egcs-2.91.66
# ls -la vmlinuz-2.4.1
-rw-r--r--   1 root     root       584959 Oct  1 15:26 vmlinuz-2.4.1
# exit
exit
Script done on Thu Oct  4 10:12:01 2001

It seems that, amongst other ethings, 2.96 aligns every function and
every memory variable on 16-byte boundaries, i.e., the offset address
lowest nibble is always 0. There doesn't seem to be any way to turn it
off.

So, if size counts, use egcs-2.91.66. It works okay with 2.4.x kernels.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


