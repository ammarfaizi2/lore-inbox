Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965136AbWIEPkX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965136AbWIEPkX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 11:40:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965141AbWIEPkW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 11:40:22 -0400
Received: from xenotime.net ([66.160.160.81]:61402 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S965136AbWIEPkU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 11:40:20 -0400
Date: Tue, 5 Sep 2006 08:43:52 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Pavel Machek <pavel@ucw.cz>
Cc: Takashi Iwai <tiwai@suse.de>, Andrew Morton <akpm@osdl.org>,
       kernel list <linux-kernel@vger.kernel.org>, perex@suse.cz,
       alsa-devel@alsa-project.org, pshou@realtek.com.tw
Subject: Re: CodingStyle (was: Re: sound/pci/hda/intel_hda: small cleanups)
Message-Id: <20060905084352.1ced999e.rdunlap@xenotime.net>
In-Reply-To: <20060905080813.GE1958@elf.ucw.cz>
References: <20060831123706.GC3923@elf.ucw.cz>
	<s5h8xl52h52.wl%tiwai@suse.de>
	<20060831110436.995bdf93.rdunlap@xenotime.net>
	<20060902231509.GC13031@elf.ucw.cz>
	<20060902213046.dd9bf569.rdunlap@xenotime.net>
	<20060905080813.GE1958@elf.ucw.cz>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Sep 2006 10:08:14 +0200 Pavel Machek wrote:

> Hi!
> 
> > > > So, just this morning I have seen questions and opinions about
> > > > the following that could (or could not) use more documentation
> > > > or codification and I'm sure that we could easily find more,
> > > > but do we want to codify Everything??
> > > > 
> > > > 
> > > > 1.  Kconfig help text should be indented (it's not indented in the
> > > > 	GFS2 patches)
> 
> Chapter 10 speaks about that alread?

OK, good.
I had only looked in Documentation/kbuild/kconfig-language.txt.


> > > > 2.  if (!condition1)	/* no space between ! and condition1
> */
> > > > 3.  don't use C99-style // comments
> > > > 4.  unsigned int bitfield :<nr_bits>;
> 
> Ok.
> 
> > > Looks reasonable to me. Will you do the patch or should I ?
> > 
> > Please (you) go ahead with it.
> 
> Does it look okay?
> 
> Signed-off-by: Pavel Machek <pavel@suse.cz>
> 
> diff --git a/Documentation/CodingStyle b/Documentation/CodingStyle
> index 6d2412e..d8e51a6 100644
> --- a/Documentation/CodingStyle
> +++ b/Documentation/CodingStyle
> @@ -46,6 +46,16 @@ used for indentation, and the above exam
>  
>  Get a decent editor and don't leave whitespace at the end of lines.
>  
> +Bitfield variables should be indented like this:
> +
> +	unsigned int foo :1;
> +
> +Avoid extra spaces around ! operator, and do not place spaces around (s.

I would spell out "parentheses".

> +	if (!buffer)
> +
> +is okay, if ( ! buffer ) is just ugly.	
> +
>  
>  		Chapter 2: Breaking long lines and strings
>  
> @@ -280,7 +290,7 @@ int fun(int a)
>  	int result = 0;
>  	char *buffer = kmalloc(SIZE);
>  
> -	if (buffer == NULL)
> +	if (!buffer)
>  		return -ENOMEM;
>  
>  	if (condition1) {
> @@ -316,6 +326,9 @@ When commenting the kernel API functions
>  See the files Documentation/kernel-doc-nano-HOWTO.txt and scripts/kernel-doc
>  for details.
>  
> +Please do not use C99-style comments, and do not use comments to
                              ^
I would insert:               "// "

> +comment out unused code.
> +

Is there an acceptable way to leave source code in a file but
render it unused?  Like #if 0/#endif or #if BOGUS_SYMBOL/#endif ?


>  		Chapter 9: You've made a mess of it
>  
>  That's OK, we all do.  You've probably been told by your long-time Unix


---
~Randy
