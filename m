Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290694AbSAYOaC>; Fri, 25 Jan 2002 09:30:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290680AbSAYO3w>; Fri, 25 Jan 2002 09:29:52 -0500
Received: from ns.suse.de ([213.95.15.193]:55561 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S290695AbSAYO3g> convert rfc822-to-8bit;
	Fri, 25 Jan 2002 09:29:36 -0500
To: Thomas Hood <jdthood@mail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: proc_file_read bug?
In-Reply-To: <1011965794.1338.6.camel@thanatos>
X-Yow: America!!  I saw it all!!  Vomiting!  Waving!  JERRY FALWELLING into
 your void tube of UHF oblivion!!  SAFEWAY of the mind --
From: Andreas Schwab <schwab@suse.de>
Date: Fri, 25 Jan 2002 15:29:35 +0100
In-Reply-To: <1011965794.1338.6.camel@thanatos> (Thomas Hood's message of
 "25 Jan 2002 08:36:32 -0500")
Message-ID: <jer8oesdv4.fsf@sykes.suse.de>
User-Agent: Gnus/5.090005 (Oort Gnus v0.05) Emacs/21.2.50 (ia64-suse-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Hood <jdthood@mail.com> writes:

|> I don't understand this part of proc_file_read() in 
|> fs/proc/generic.c:
|> 
|>                 /* This is a hack to allow mangling of file pos independent
|>                  * of actual bytes read.  Simply place the data at page,
|>                  * return the bytes, and set `start' to the desired offset
|>                  * as an unsigned int. - Paul.Russell@rustcorp.com.au
|>                  */
|>                 n -= copy_to_user(buf, start < page ? page : start, n);
|>                 if (n == 0) {
|>                         if (retval == 0)
|>                                 retval = -EFAULT;
|>                         break;
|>                 }
|> 
|>                 *ppos += start < page ? (long)start : n; /* Move down the file */
|>                 nbytes -= n;
|>                 buf += n;
|>                 retval += n;
|> 
|> When start >= page, we copy n bytes beginning at start and
|> increase *ppos by n.  Makes sense.  But what happens when
|> start < page?  We will copy n bytes starting at page, then
|> increase *ppos by start!!  What sense does that make?  If
|> there's cleverness happening here, someone please document it.

It is documented, RTFC.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE GmbH, Deutschherrnstr. 15-19, D-90429 Nürnberg
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
