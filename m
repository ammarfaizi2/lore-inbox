Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129759AbRADW7S>; Thu, 4 Jan 2001 17:59:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130000AbRADW7H>; Thu, 4 Jan 2001 17:59:07 -0500
Received: from web2301.mail.yahoo.com ([128.11.68.52]:60421 "HELO
	web2301.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S129759AbRADW7A>; Thu, 4 Jan 2001 17:59:00 -0500
Message-ID: <20010104225858.14771.qmail@web2301.mail.yahoo.com>
Date: Thu, 4 Jan 2001 14:58:58 -0800 (PST)
From: Asang K Dani <asang@yahoo.com>
Subject: Re: generic_file_write code segment in 2.2.18
To: Andi Kleen <ak@suse.de>
Cc: "Stephen C. Tweedie" <sct@redhat.com>, linux-kernel@vger.kernel.org,
        alan@lxorguk.ukuu.org.uk
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Andi Kleen <ak@suse.de> wrote:
> On Thu, Jan 04, 2001 at 10:42:34PM +0000, Stephen C. Tweedie wrote:
> > No, because then you'd be skipping the updatepage() call if we
> took a
> > fault mid-copy after copying some data.  That would imply you had
> > dirtied the page cache without an updatepage().
> > 
> > The current behaviour should just result in a short IO, which
> should
> > be fine.
> 
> The problem is that the short write is not reported to the caller,
> even when only zero bytes are copied (the page is corrupted anyways
> though because cfu  zeros the uncopied rest).  

I think it will be reported to caller, because when cfu copies 0
bytes,

   bytes -= copy_from_user(dest, buf, bytes);

will make 'bytes' zero. Since 'bytes' is 'zero' updatepage will not
be called and status retains value '-EFAULT' and it breaks out of
the while loop immediately.

> 
> -Andi

asang..

__________________________________________________
Do You Yahoo!?
Yahoo! Photos - Share your holiday photos online!
http://photos.yahoo.com/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
