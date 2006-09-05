Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964960AbWIEIIe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964960AbWIEIIe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 04:08:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964992AbWIEIId
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 04:08:33 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:29421 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S964960AbWIEIIc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 04:08:32 -0400
Date: Tue, 5 Sep 2006 10:08:14 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: Takashi Iwai <tiwai@suse.de>, Andrew Morton <akpm@osdl.org>,
       kernel list <linux-kernel@vger.kernel.org>, perex@suse.cz,
       alsa-devel@alsa-project.org, pshou@realtek.com.tw
Subject: Re: CodingStyle (was: Re: sound/pci/hda/intel_hda: small cleanups)
Message-ID: <20060905080813.GE1958@elf.ucw.cz>
References: <20060831123706.GC3923@elf.ucw.cz> <s5h8xl52h52.wl%tiwai@suse.de> <20060831110436.995bdf93.rdunlap@xenotime.net> <20060902231509.GC13031@elf.ucw.cz> <20060902213046.dd9bf569.rdunlap@xenotime.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060902213046.dd9bf569.rdunlap@xenotime.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > So, just this morning I have seen questions and opinions about
> > > the following that could (or could not) use more documentation
> > > or codification and I'm sure that we could easily find more,
> > > but do we want to codify Everything??
> > > 
> > > 
> > > 1.  Kconfig help text should be indented (it's not indented in the
> > > 	GFS2 patches)

Chapter 10 speaks about that alread?

                Chapter 10: Configuration-files

For configuration options (arch/xxx/Kconfig, and all the Kconfig
files),
somewhat different indentation is used.

Help text is indented with 2 spaces.

if CONFIG_EXPERIMENTAL
        tristate CONFIG_BOOM
        default n
        help
          Apply nitroglycerine inside the keyboard (DANGEROUS)
        bool CONFIG_CHEER
        depends on CONFIG_BOOM
        default y
        help
          Output nice messages when you explode
endif

> > > 2.  if (!condition1)	/* no space between ! and condition1
*/
> > > 3.  don't use C99-style // comments
> > > 4.  unsigned int bitfield :<nr_bits>;

Ok.

> > Looks reasonable to me. Will you do the patch or should I ?
> 
> Please (you) go ahead with it.

Does it look okay?

Signed-off-by: Pavel Machek <pavel@suse.cz>

diff --git a/Documentation/CodingStyle b/Documentation/CodingStyle
index 6d2412e..d8e51a6 100644
--- a/Documentation/CodingStyle
+++ b/Documentation/CodingStyle
@@ -46,6 +46,16 @@ used for indentation, and the above exam
 
 Get a decent editor and don't leave whitespace at the end of lines.
 
+Bitfield variables should be indented like this:
+
+	unsigned int foo :1;
+
+Avoid extra spaces around ! operator, and do not place spaces around (s.
+
+	if (!buffer)
+
+is okay, if ( ! buffer ) is just ugly.	
+
 
 		Chapter 2: Breaking long lines and strings
 
@@ -280,7 +290,7 @@ int fun(int a)
 	int result = 0;
 	char *buffer = kmalloc(SIZE);
 
-	if (buffer == NULL)
+	if (!buffer)
 		return -ENOMEM;
 
 	if (condition1) {
@@ -316,6 +326,9 @@ When commenting the kernel API functions
 See the files Documentation/kernel-doc-nano-HOWTO.txt and scripts/kernel-doc
 for details.
 
+Please do not use C99-style comments, and do not use comments to
+comment out unused code.
+
 		Chapter 9: You've made a mess of it
 
 That's OK, we all do.  You've probably been told by your long-time Unix

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
