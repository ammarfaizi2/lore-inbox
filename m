Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274744AbRJCL7r>; Wed, 3 Oct 2001 07:59:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275567AbRJCL7h>; Wed, 3 Oct 2001 07:59:37 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:64774 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S274744AbRJCL7Y>;
	Wed, 3 Oct 2001 07:59:24 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Russell King <rmk@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Modutils 2.5 change, start running this command now 
In-Reply-To: Your message of "Wed, 03 Oct 2001 09:17:02 +0100."
             <20011003091702.B1175@flint.arm.linux.org.uk> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 03 Oct 2001 21:59:39 +1000
Message-ID: <1538.1002110379@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Oct 2001 09:17:02 +0100, 
Russell King <rmk@arm.linux.org.uk> wrote:
>On Wed, Oct 03, 2001 at 02:36:24PM +1000, Keith Owens wrote:
>> Either export the required symbols
>> (remember to add the .o file to export-objs in the Makefile) or add
>> EXPORT_NO_SYMBOLS; somewhere in the module (no change to Makefile).
>> 
>>  objdump -h `modprobe -l` | \
>>  awk '/file format/{file = $1}/__ksymtab/{file = ""}/\.comment/ && file != "" {print file}'
>
>Sorry, your awk script is buggy - it doesn't take note of __ksymtab
>after .comment:

Foo, I was assuming that .comment always came last.  Oh well, do it the
hard way.

objdump -h `modprobe -l` | sed -ne '/__ksym/h;$b1;\:^/:!d;:1;x;s/:.*//p;'

Gotta love those sed hieroglyphics :-)

