Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129325AbRADXJi>; Thu, 4 Jan 2001 18:09:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129267AbRADXJ2>; Thu, 4 Jan 2001 18:09:28 -0500
Received: from web2301.mail.yahoo.com ([128.11.68.52]:7697 "HELO
	web2301.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S129325AbRADXJN>; Thu, 4 Jan 2001 18:09:13 -0500
Message-ID: <20010104230911.16104.qmail@web2301.mail.yahoo.com>
Date: Thu, 4 Jan 2001 15:09:11 -0800 (PST)
From: Asang K Dani <asang@yahoo.com>
Subject: Re: generic_file_write code segment in 2.2.18
To: Andi Kleen <ak@suse.de>
Cc: Andi Kleen <ak@suse.de>, "Stephen C. Tweedie" <sct@redhat.com>,
        linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- Andi Kleen <ak@suse.de> wrote:
> On Thu, Jan 04, 2001 at 02:58:58PM -0800, Asang K Dani wrote:
> > --- Andi Kleen <ak@suse.de> wrote:
> > > On Thu, Jan 04, 2001 at 10:42:34PM +0000, Stephen C. Tweedie
> wrote:
> > > > No, because then you'd be skipping the updatepage() call if
> we
> > > took a
> > > > fault mid-copy after copying some data.  That would imply you
> had
> > > > dirtied the page cache without an updatepage().
> > > > 
> > > > The current behaviour should just result in a short IO, which
> > > should
> > > > be fine.
> > > 
> > > The problem is that the short write is not reported to the
> caller,
> > > even when only zero bytes are copied (the page is corrupted
> anyways
> > > though because cfu  zeros the uncopied rest).  
> > 
> > I think it will be reported to caller, because when cfu copies 0
> > bytes,
> > 
> >    bytes -= copy_from_user(dest, buf, bytes);
> > 
> > will make 'bytes' zero. Since 'bytes' is 'zero' updatepage will
> not
> > be called and status retains value '-EFAULT' and it breaks out of
> > the while loop immediately.
> 
> Right for zero it is handled, but not for 1 byte copied but the
> rest zeroed
> (which is a severe IO error) 
>

For all those cases (when bytes != 0 after cfu), 'status' will be
overwritten by the return value of 'updatepage'.
 
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
