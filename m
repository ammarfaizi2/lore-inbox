Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261729AbUBVTVh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Feb 2004 14:21:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261730AbUBVTVh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Feb 2004 14:21:37 -0500
Received: from pfepb.post.tele.dk ([195.41.46.236]:56715 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S261729AbUBVTVf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Feb 2004 14:21:35 -0500
Date: Sun, 22 Feb 2004 21:22:11 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>,
       "Amit S. Kale" <akale@users.sourceforge.net>
Subject: Re: [1/3] kgdb-lite for 2.6.3
Message-ID: <20040222202211.GA2063@mars.ravnborg.org>
Mail-Followup-To: Pavel Machek <pavel@ucw.cz>,
	Andrew Morton <akpm@zip.com.au>,
	kernel list <linux-kernel@vger.kernel.org>,
	"Amit S. Kale" <akale@users.sourceforge.net>
References: <20040222160417.GA9535@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040222160417.GA9535@elf.ucw.cz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just some random comments after browsing the code.

	Sam

> +
> +int kgdb_hexToLong(char **ptr, long *longValue);
A patch has been posted by Tom Rini to convert this to the
linux naming: kgdb_hex2long(...).

+static const char hexchars[] = "0123456789abcdef";
Grepping after 0123456789 in the src tree gives a lot of hits.
Maybe we should pull in some functionality from klibc, and place it in lib/
at some point in time.

+
+static char remcomInBuffer[BUFMAX];
+static char remcomOutBuffer[BUFMAX];
This does not follow usual Linux naming convention.
Something like: remcom_in_buf, remcom_out_buf?

> +static void getpacket(char *buffer)
> +{
> +	unsigned char checksum;
> +	unsigned char xmitcsum;
> +	int i;
> +	int count;
> +	char ch;
> +
> +	do {
> +	/* wait around for the start character, ignore all other characters */
> +		while ((ch = (kgdb_serial->read_char() & 0x7f)) != '$');

Placing ';' on a seperate line would be good for the readability.


> +int kgdb_handle_exception(int exVector, int signo, int err_code, 
> +                     struct pt_regs *linux_regs)
> +{
> +	unsigned long length, addr;
> +	char *ptr;
> +	unsigned long flags;
> +	unsigned long gdb_regs[NUMREGBYTES / sizeof (unsigned long)];
> +	int i;
> +	long threadid;
> +	threadref thref;
> +	struct task_struct *thread = NULL;
> +	unsigned procid;
> +	static char tmpstr[256];

Too? large varriable on the stack.

