Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261616AbREVB6a>; Mon, 21 May 2001 21:58:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261640AbREVB6V>; Mon, 21 May 2001 21:58:21 -0400
Received: from zeus.kernel.org ([209.10.41.242]:20712 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S261653AbREVB6I>;
	Mon, 21 May 2001 21:58:08 -0400
Date: Tue, 22 May 2001 01:57:14 +0100
From: Matthew Wilcox <matthew@wil.cx>
To: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
Cc: Alexander Viro <viro@math.psu.edu>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Pavel Machek <pavel@suse.cz>, Richard Gooch <rgooch@ras.ucalgary.ca>,
        Matthew Wilcox <matthew@wil.cx>, Andrew Clausen <clausen@gnu.org>,
        Ben LaHaise <bcrl@redhat.com>, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFD w/info-PATCH] device arguments from lookup, partion code
Message-ID: <20010522015714.K23718@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <E151xFO-0000ue-00@the-village.bc.nu> <Pine.GSO.4.21.0105211745490.12245-100000@weyl.math.psu.edu> <20010522022234.T754@nightmaster.csn.tu-chemnitz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010522022234.T754@nightmaster.csn.tu-chemnitz.de>; from ingo.oeser@informatik.tu-chemnitz.de on Tue, May 22, 2001 at 02:22:34AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 22, 2001 at 02:22:34AM +0200, Ingo Oeser wrote:
> ioctl has actually 4 semantics:
> 
> command only
> command + read
> command + write
> command + rw-transaction
> 
> Separating these would be a first step. And yes, I consider each
> of them useful.
> 
> command only: reset drive

echo 'reset' >/dev/sg0ctl

> command + rw-transaction: "dear device please mangle this data"
>    (crypto processors come to mind...)

I can't think of a reasonable tool-based approach to this, but I can
definitely see that a program could use this well.  It simply requires
that you use the filp to store your state.

fd = open(/dev/crypto) -> creates filp
write(fd, "Death to all fanatics!\n"); -> calls crypto device, stores result in
	private data structure
sleep(100);
read(fd, "Qrngu gb nyy snangvpf!\n"); -> frees data structure

[You'll note the advanced design of my crypto processor.]

Clearly, this is open to abuse by persons never calling read() and passing in
far too much to write().  I think this can be alleviated by refusing to accept more than (say) 4k at a time, or bean-counter.

A sick way would be to allow the ->write() call to have its buffer
modified.  But I don't think we want to go down that path.

-- 
Revolutions do not require corporate support.
