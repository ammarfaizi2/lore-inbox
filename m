Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266730AbSKKRwn>; Mon, 11 Nov 2002 12:52:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266732AbSKKRwn>; Mon, 11 Nov 2002 12:52:43 -0500
Received: from air-2.osdl.org ([65.172.181.6]:50384 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S266730AbSKKRwm>;
	Mon, 11 Nov 2002 12:52:42 -0500
Subject: Re: kexec (was: [lkcd-devel] Re: What's left over.)
From: Andy Pfiffer <andyp@osdl.org>
To: landley@trommello.org
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Werner Almesberger <wa@almesberger.net>,
       Suparna Bhattacharya <suparna@in.ibm.com>,
       Jeff Garzik <jgarzik@pobox.com>,
       "Matt D. Robinson" <yakker@aparity.com>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lkcd-general@lists.sourceforge.net, lkcd-devel@lists.sourceforge.net
In-Reply-To: <200211080536.31287.landley@trommello.org>
References: <Pine.LNX.4.44.0211052203150.1416-100000@home.transmeta.com>
	<m14ratepbf.fsf@frodo.biederman.org> <1036697556.10457.254.camel@andyp> 
	<200211080536.31287.landley@trommello.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 11 Nov 2002 09:58:27 -0800
Message-Id: <1037037508.13280.11.camel@andyp>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-11-07 at 21:36, Rob Landley wrote:

> It strikes me that "load a blob of data into physical memory and keep it there 
> until further notice" is actually relatively generic mechanism, and something 
> there might be other reasons for root or various devices to do.  (DSPs that 
> want their firmware in system ram?  3D models and textures for an onboard 
> video card?)  If I'm wrong, would somebody be kind enough to tell me why?
> 
> Rob


Yes, that is rather generic -- somewhat like a variable-sized ramdisk.  

I think the key difference is that the ramdisk wants to hold blobs of
data that will be accessed from user-mode by read & write.

A "blob of bytes" for kexec, and maybe for a few other uses, wants to be
accessed (perhaps a page at a time) by pointers while in kernel space.

I'm not so sure of the generality, though.  It's my guess that there
many special-case requirements that might make it difficult to become
useful infrastructure (eg, maybe the DSP on a soundcard needs it to be
4M aligned and contiguous, or the texture memory for the video card
wants to be able to walk a data structure that only it knows about).

Andy




