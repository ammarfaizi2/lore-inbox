Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278237AbRJMBvS>; Fri, 12 Oct 2001 21:51:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278239AbRJMBvI>; Fri, 12 Oct 2001 21:51:08 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:63248 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S278237AbRJMBu7>;
	Fri, 12 Oct 2001 21:50:59 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Matt Domsch <Matt_Domsch@dell.com>, linux-kernel@vger.kernel.org
Subject: Re: crc32 cleanups 
In-Reply-To: Your message of "Fri, 12 Oct 2001 14:37:52 EST."
             <Pine.LNX.3.96.1011012143222.6594D-100000@mandrakesoft.mandrakesoft.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 13 Oct 2001 11:51:17 +1000
Message-ID: <14801.1002937877@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Oct 2001 14:37:52 -0500 (CDT), 
Jeff Garzik <jgarzik@mandrakesoft.com> wrote:
>(linux/lib/Makefile)
>obj-$(CONFIG_TULIP) += crc32.o
>obj-$(CONFIG_NATSEMI) += crc32.o
>obj-$(CONFIG_DMFE) += crc32.o
>obj-$(CONFIG_ANOTHERDRIVER) += crc32.o

It is better to define CONFIG_CRC32 and have the Config.in files set
CONFIG_CRC32 for selected drivers.  That avoids the problem of lots of
drivers wanting to patch the same Makefile, instead the selection of
crc32 is kept with the driver selection.

lib/Makefile
obj-$(CONFIG_CRC32) += crc32.o

drivers/foo/Config.in
if [ "$CONFIG_FOO" = "y" ]; then
  define_bool CONFIG_CRC32 y
fi

It is even cleaner in CML2.
require FOO implies CRC32=y

In general it is a bad idea to handle selections in the Makefile, that
is what CML is for.  Makefiles should just build the code based on CML
output, not try to decide what to build.

