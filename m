Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261735AbUBVTzN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Feb 2004 14:55:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261736AbUBVTzN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Feb 2004 14:55:13 -0500
Received: from gprs144-14.eurotel.cz ([160.218.144.14]:42370 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261735AbUBVTzG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Feb 2004 14:55:06 -0500
Date: Sun, 22 Feb 2004 20:54:44 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>,
       "Amit S. Kale" <akale@users.sourceforge.net>
Subject: Re: [1/3] kgdb-lite for 2.6.3
Message-ID: <20040222195444.GB10857@elf.ucw.cz>
References: <20040222160417.GA9535@elf.ucw.cz> <20040222202211.GA2063@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040222202211.GA2063@mars.ravnborg.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Just some random comments after browsing the code.
> 
> 	Sam
> 
> > +
> > +int kgdb_hexToLong(char **ptr, long *longValue);
> A patch has been posted by Tom Rini to convert this to the
> linux naming: kgdb_hex2long(...).

Yep, and I did the patch originially ;-).

> +static const char hexchars[] = "0123456789abcdef";
> Grepping after 0123456789 in the src tree gives a lot of hits.
> Maybe we should pull in some functionality from klibc, and place it in lib/
> at some point in time.
> 
> +
> +static char remcomInBuffer[BUFMAX];
> +static char remcomOutBuffer[BUFMAX];
> This does not follow usual Linux naming convention.
> Something like: remcom_in_buf, remcom_out_buf?

Yes, and getpacket should also become get_packet...

> > +static void getpacket(char *buffer)
> > +{
> > +	unsigned char checksum;
> > +	unsigned char xmitcsum;
> > +	int i;
> > +	int count;
> > +	char ch;
> > +
> > +	do {
> > +	/* wait around for the start character, ignore all other characters */
> > +		while ((ch = (kgdb_serial->read_char() & 0x7f)) != '$');
> 
> Placing ';' on a seperate line would be good for the readability.

> > +int kgdb_handle_exception(int exVector, int signo, int err_code, 
> > +                     struct pt_regs *linux_regs)
> > +{
> > +	unsigned long length, addr;
> > +	char *ptr;
> > +	unsigned long flags;
> > +	unsigned long gdb_regs[NUMREGBYTES / sizeof (unsigned long)];
> > +	int i;
> > +	long threadid;
> > +	threadref thref;
> > +	struct task_struct *thread = NULL;
> > +	unsigned procid;
> > +	static char tmpstr[256];
> 
> Too? large varriable on the stack.

Whi one?

tmpstr is static....
							Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
