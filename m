Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265894AbSKKSVK>; Mon, 11 Nov 2002 13:21:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265900AbSKKSVK>; Mon, 11 Nov 2002 13:21:10 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:58698 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S265894AbSKKSVI>; Mon, 11 Nov 2002 13:21:08 -0500
To: Andy Pfiffer <andyp@osdl.org>
Cc: landley@trommello.org, Linus Torvalds <torvalds@transmeta.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Werner Almesberger <wa@almesberger.net>,
       Suparna Bhattacharya <suparna@in.ibm.com>,
       Jeff Garzik <jgarzik@pobox.com>,
       "Matt D. Robinson" <yakker@aparity.com>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lkcd-general@lists.sourceforge.net, lkcd-devel@lists.sourceforge.net
Subject: Re: kexec (was: [lkcd-devel] Re: What's left over.)
References: <Pine.LNX.4.44.0211052203150.1416-100000@home.transmeta.com>
	<m14ratepbf.fsf@frodo.biederman.org>
	<1036697556.10457.254.camel@andyp>
	<200211080536.31287.landley@trommello.org>
	<1037037508.13280.11.camel@andyp>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 11 Nov 2002 11:25:06 -0700
In-Reply-To: <1037037508.13280.11.camel@andyp>
Message-ID: <m1r8ds9d6l.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Pfiffer <andyp@osdl.org> writes:

> On Thu, 2002-11-07 at 21:36, Rob Landley wrote:
> 
> > It strikes me that "load a blob of data into physical memory and keep it there
> 
> > until further notice" is actually relatively generic mechanism, and something
> 
> > there might be other reasons for root or various devices to do.  (DSPs that 
> > want their firmware in system ram?  3D models and textures for an onboard 
> > video card?)  If I'm wrong, would somebody be kind enough to tell me why?
> > 
> > Rob
> 
> 
> Yes, that is rather generic -- somewhat like a variable-sized ramdisk.  
>
> I think the key difference is that the ramdisk wants to hold blobs of
> data that will be accessed from user-mode by read & write.

kexec at least at the end, and probably for earlier for handling
panics wants code to be in a very specific location in ram. 

If you want to hook the functionality behind in behind kexec_load,
when say KEXEC_FIXED is passed as a flag, go ahead.  There is enough
other setup to jump to the code loaded into memory that "load a blob
of data into physical memory and keep it there" is not a sufficient
interface.

In the general case I using some kind of scatter gather list seems
the most polite way to go.

Eric
