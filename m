Return-Path: <linux-kernel-owner+w=401wt.eu-S1423006AbWLUSM3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423006AbWLUSM3 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 13:12:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422999AbWLUSM3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 13:12:29 -0500
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:53855 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1423004AbWLUSM1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 13:12:27 -0500
X-Greylist: delayed 1583 seconds by postgrey-1.27 at vger.kernel.org; Thu, 21 Dec 2006 13:12:27 EST
Message-Id: <1166723157.29546.281560884@webmail.messagingengine.com>
X-Sasl-Enc: wkFqiNA2HnaY78KnZ4yegfVvkepnEpXgzn5ch6+DvBl1 1166723157
From: "Alexander van Heukelum" <heukelum@fastmail.fm>
To: "Jean Delvare" <khali@linux-fr.org>, "Vivek Goyal" <vgoyal@in.ibm.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, "Andi Kleen" <ak@suse.de>,
       "LKML" <linux-kernel@vger.kernel.org>
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="ISO-8859-1"
MIME-Version: 1.0
X-Mailer: MessagingEngine.com Webmail Interface
References: <20061220141808.e4b8c0ea.khali@linux-fr.org>
   <m1tzzqpt04.fsf@ebiederm.dsl.xmission.com>
   <20061220214340.f6b037b1.khali@linux-fr.org>
   <m1mz5ip5r7.fsf@ebiederm.dsl.xmission.com>
   <20061221101240.f7e8f107.khali@linux-fr.org>
   <20061221102232.5a10bece.khali@li
   <20061221145922.16ee8dd7.khali@linux-fr.org>
Subject: Re: Patch "i386: Relocatable kernel support" causes instant reboot
In-Reply-To: <20061221145922.16ee8dd7.khali@linux-fr.org>
Date: Thu, 21 Dec 2006 18:45:57 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Dec 2006 14:59:22 +0100, "Jean Delvare" <khali@linux-fr.org>
said:
> Hi Vivek,
> 
> On Thu, 21 Dec 2006 08:43:26 +0530, Vivek Goyal wrote:
> > On Thu, Dec 21, 2006 at 02:13:54PM +0100, Jean Delvare wrote:
> > > On Thu, 21 Dec 2006 06:38:14 +0530, Vivek Goyal wrote:
> > > > Looks like it might be a tool chain issue. I took Jean's config file and
> > > > built my own kernel and I am able to boot the kernel. But I can't boot
> > > > his bzImage. I observed the same behaviour as jean is experiencing. It jumps
> > > > back to BIOS.
> > > 
> > > I can only confirm that. I installed a more recent system on the same
> > > hardware, rebuilt a kernel from the same config file, and now it boots
> > > OK. So it's not related to the hardware. It has to be a compilation-time
> > > issue.
> > 
> > Looks like you have already trashed your setup. If not, is it possible to
> 
> No, of course I didn't. I installed the new system on a different hard
> disk drive.
> 
> > upload the output of "objdump -D arch/i386/boot/setup.o"? This will give
> > some info regarding what assembler is doing.
> 
> Here you go:
> http://jdelvare.pck.nerim.net/linux/relocatable-bug/setup.asm

Hi,

Hmm. taking a peek at the bzImage there...

00001d80  41 00 56 45 53 41 00 56  69 64 65 6f 20 61 64 61 
|A.VESA.Video ada|
00001d90  70 74 65 72 3a 20 00 00  00 b8 00 00 55 aa 5a 5a  |pter:
......U.ZZ|
00001da0  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00 
|................|
*
00001e00  4e 35 13 00 1f 8b 08 00  23 a4 89 45 02 03 b4 fd 
|N5......#..E....|
          -- -- -- -- ^^ ^^ ^^

This is the end of the realmode kernel, and it should be followed by the
32-bit code that is to be executed at (normally) 0x100000, right? This
is however not the case here. Where did arch/i386/boot/compressed/head.S
go then? What is the significance of this value 0x0013354e? It is in
fact
exactly the size of the compressed kernel image.

I have no idea what went wrong, but it went wrong in the build process
of the bzImage.

Hope this helps,
    Alexander

> -- 
> Jean Delvare
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
  Alexander van Heukelum
  heukelum@fastmail.fm

-- 
http://www.fastmail.fm - Send your email first class

