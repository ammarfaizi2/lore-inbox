Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129103AbQJaI1T>; Tue, 31 Oct 2000 03:27:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129353AbQJaI1L>; Tue, 31 Oct 2000 03:27:11 -0500
Received: from oe71.law11.hotmail.com ([64.4.16.206]:56846 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S129103AbQJaI07>;
	Tue, 31 Oct 2000 03:26:59 -0500
X-Originating-IP: [24.164.154.68]
From: "Linux Kernel Developer" <linux_developer@hotmail.com>
To: <linux-kernel@vger.kernel.org>
Cc: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <E13qEbg-0006rE-00@the-village.bc.nu>
Subject: Re: Need info on the use of certain datastructures and the first C++ keyword patch for 2.2.17
Date: Tue, 31 Oct 2000 03:13:54 -0500
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Message-ID: <OE71gE8Peski0RKGhXc000008a7@hotmail.com>
X-OriginalArrivalTime: 31 Oct 2000 08:26:54.0062 (UTC) FILETIME=[5332D0E0:01C04314]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

----- Original Message -----
From: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
To: "Linux Kernel Developer" <linux_developer@hotmail.com>
Cc: <linux-kernel@vger.kernel.org>
Sent: Monday, October 30, 2000 8:04 AM
Subject: Re: Need info on the use of certain datastructures and the first
C++ keyword patch for 2.2.17


> > js_dev::new.  My questions are basically this.  If I update these data
> > structure members' names along with the references to them in various C
> > files in the kernel will all be happy in Linuxland.  Can any external
>
> That may well be a problem. Also the use of private.
>
> You may find that creating your own wrappers for these files that do
>
> extern "C" {
> #define new new_
> #define private private_
> #include <linux/foo.h>
> #undef new
> #undef private
> }
>
> safer, since you won't break anything

    That was one of the two possible solutions I was looking at initially.
Having for example a module.hpp header file alongside module.h which did the
extern "C" {} wrapper along with the #define new lk_new, etc.  Actually that
would be an easier task for me as I could easily write a Perl script which
automatically built that for any kernel.  However from the responses I
gathered at the time it was mostly recommended against.  I am also leary at
that option as some variable (and function?) names would differ when used in
either a C or C++ program and also after having seeing the horror Palm did
with defines in their SDK.

    Perhaps this is what I should do.  Continue making the straitforward
fixes that will not break anything and incorporate that into my main patch.
Fixes for situations such as the one I encountered in those 3 data
structures I will put into a separate patch for testing to see if the change
affects anybody.  If those modifications happen prove unwise then for those
rare cases do the .hpp option on those header files.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
