Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315251AbSEQA1y>; Thu, 16 May 2002 20:27:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315259AbSEQA1x>; Thu, 16 May 2002 20:27:53 -0400
Received: from mail.myrio.com ([63.109.146.2]:50423 "HELO mail.myrio.com")
	by vger.kernel.org with SMTP id <S315251AbSEQA1w> convert rfc822-to-8bit;
	Thu, 16 May 2002 20:27:52 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.5762.3
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: boot logo size patch
Date: Thu, 16 May 2002 17:27:03 -0700
Message-ID: <A015F722AB845E4B8458CBABDFFE63420FE3EF@mail0.myrio.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: boot logo size patch
Thread-Index: AcH86IykCLdNFupUTKGOQ0bEZPzMYgATlkFQ
From: "Torrey Hoffman" <Torrey.Hoffman@myrio.com>
To: "Rolland Dudemaine" <rolland.dudemaine@msg-software.com>, <mj@ucw.cz>,
        <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 17 May 2002 00:26:18.0590 (UTC) FILETIME=[767C37E0:01C1FD39]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rolland Dudemaine wrote:

> For a *long* time, the boot logo has stayed in the kernel at many 
> places. Recently, it has been cleaned up to reduce the number of 
> identical logos. 

[...]

If you are interested in cleaning up the boot logo, you may want to
check out the patch set at www.arnor.net/linuxlogo

That sequence of six patches begins as you have, moving LOGO_H and 
LOGO_W into the individual logo files where they belong.

The second patch introduces a C program "tologo" to the scripts 
directory.  It converts arbitrary .ppm files to the linux_logo.h 
format, but is not 100% done (works correctly for 256 color images
but not the 16 color or black & white ones)

The third patch adds the generic 80x80 pixel penguin logo as 
arch/i386/linux_logo.ppm, but other arch-specific logos are missing.

The forth patch modifies the makefiles to generate linux_logo.h at 
compile time.

The fifth patch removes all 15 (!) now redundant linux_logo.h files,
removing 360K of headers from the kernel source.

The sixth patch is somewhat unrelated, and adds options and controls
for turning off or adjusting the blink rate of the framebuffer cursor.

Obviously, these patches make it trivial to put any graphic you want
in as your boot logo.  Just save your image from the Gimp as 
arch/$(ARCH)/linux_logo.ppm,  and recompile... voila!

I am nominally the maintainer of this set of patches.  I do plan to
forward port it from 2.4.x to 2.5 after James Simmon's big console
rewrite has been merged, as well as updating it for 2.4.19 when 
that comes out.

Comments appreciated...

Torrey Hoffman

thoffman@arnor.net
torrey.hoffman@myrio.com

