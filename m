Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129655AbRADXDJ>; Thu, 4 Jan 2001 18:03:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129745AbRADXC5>; Thu, 4 Jan 2001 18:02:57 -0500
Received: from Cantor.suse.de ([194.112.123.193]:26889 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S129655AbRADXCq>;
	Thu, 4 Jan 2001 18:02:46 -0500
Date: Fri, 5 Jan 2001 00:02:43 +0100
From: Andi Kleen <ak@suse.de>
To: Asang K Dani <asang@yahoo.com>
Cc: Andi Kleen <ak@suse.de>, "Stephen C. Tweedie" <sct@redhat.com>,
        linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
Subject: Re: generic_file_write code segment in 2.2.18
Message-ID: <20010105000243.B5317@gruyere.muc.suse.de>
In-Reply-To: <20010104225858.14771.qmail@web2301.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010104225858.14771.qmail@web2301.mail.yahoo.com>; from asang@yahoo.com on Thu, Jan 04, 2001 at 02:58:58PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 04, 2001 at 02:58:58PM -0800, Asang K Dani wrote:
> --- Andi Kleen <ak@suse.de> wrote:
> > On Thu, Jan 04, 2001 at 10:42:34PM +0000, Stephen C. Tweedie wrote:
> > > No, because then you'd be skipping the updatepage() call if we
> > took a
> > > fault mid-copy after copying some data.  That would imply you had
> > > dirtied the page cache without an updatepage().
> > > 
> > > The current behaviour should just result in a short IO, which
> > should
> > > be fine.
> > 
> > The problem is that the short write is not reported to the caller,
> > even when only zero bytes are copied (the page is corrupted anyways
> > though because cfu  zeros the uncopied rest).  
> 
> I think it will be reported to caller, because when cfu copies 0
> bytes,
> 
>    bytes -= copy_from_user(dest, buf, bytes);
> 
> will make 'bytes' zero. Since 'bytes' is 'zero' updatepage will not
> be called and status retains value '-EFAULT' and it breaks out of
> the while loop immediately.

Right for zero it is handled, but not for 1 byte copied but the rest zeroed
(which is a severe IO error) 


-Andi
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
