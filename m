Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129428AbRADWuR>; Thu, 4 Jan 2001 17:50:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129523AbRADWuI>; Thu, 4 Jan 2001 17:50:08 -0500
Received: from Cantor.suse.de ([194.112.123.193]:18440 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S129428AbRADWtg>;
	Thu, 4 Jan 2001 17:49:36 -0500
Date: Thu, 4 Jan 2001 23:49:28 +0100
From: Andi Kleen <ak@suse.de>
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: Andi Kleen <ak@suse.de>, Asang K Dani <asang@yahoo.com>,
        linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: generic_file_write code segment in 2.2.18
Message-ID: <20010104234928.A5198@gruyere.muc.suse.de>
In-Reply-To: <20010104052948.12042.qmail@web2303.mail.yahoo.com> <20010104085137.A18532@gruyere.muc.suse.de> <20010104224234.B1290@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010104224234.B1290@redhat.com>; from sct@redhat.com on Thu, Jan 04, 2001 at 10:42:34PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 04, 2001 at 10:42:34PM +0000, Stephen C. Tweedie wrote:
> No, because then you'd be skipping the updatepage() call if we took a
> fault mid-copy after copying some data.  That would imply you had
> dirtied the page cache without an updatepage().
> 
> The current behaviour should just result in a short IO, which should
> be fine.

The problem is that the short write is not reported to the caller, even when only
zero bytes are copied (the page is corrupted anyways though because cfu 
zeros the uncopied rest).  

-Andi
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
