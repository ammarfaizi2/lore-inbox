Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129249AbRBBVPb>; Fri, 2 Feb 2001 16:15:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129282AbRBBVPW>; Fri, 2 Feb 2001 16:15:22 -0500
Received: from chaos.analogic.com ([204.178.40.224]:6784 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S129249AbRBBVPQ>; Fri, 2 Feb 2001 16:15:16 -0500
Date: Fri, 2 Feb 2001 16:14:59 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Ken Moffat <ken@kenmoffat.uklinux.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: Every Make option ends in error.
In-Reply-To: <Pine.LNX.4.21.0102022052090.31663-100000@localhost.localdomain>
Message-ID: <Pine.LNX.3.95.1010202160531.692A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Feb 2001, Ken Moffat wrote:

> Hi guys, 
>  I guess I'm doing something stupid, so please can somebody point it out
> and put me out of my misery ?
>  
>  Copied a plain 2.4.0 tree to a new directory, patched it to 2.4.1 without
> any errors. Then I realised it had all the object files from my last
> compile, so I thought "make mrproper" was called for. It did a little,
> then
> 
> rm: include/asm: is a directory
> make: *** [mrproper] Error 1
> 
This link file got changed to a directory, probable because your
new directory was copied! You should have used `tar`. Copy will
follow the sym-links and copy the underlying data, i.e., a whole
directory.

Not to worry. In your new Linux directory tree do:

cd include
mv asm /tmp	# or /usr/src, someplace temporary.

cd ..		# Back to Linux
cp .config ..	# Save your configuration
make mrproper	# Make like a distribution
cp ../.config . # Restore configuration
make oldconfig	# Re-do configuration
make dep	# Re-do dependencies
make bzImage	# Doit toit

After everything works, recursively delete the saved 'asm'
directory that was moved outside the kernel tree.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
