Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288605AbSADLkU>; Fri, 4 Jan 2002 06:40:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288603AbSADLkL>; Fri, 4 Jan 2002 06:40:11 -0500
Received: from navy.csi.cam.ac.uk ([131.111.8.49]:37601 "EHLO
	navy.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S288481AbSADLj4>; Fri, 4 Jan 2002 06:39:56 -0500
Date: Fri, 4 Jan 2002 11:35:44 +0000 (GMT)
From: "Joseph S. Myers" <jsm28@cam.ac.uk>
X-X-Sender: <jsm28@kern.srcf.societies.cam.ac.uk>
To: Florian Weimer <fw@deneb.enyo.de>
cc: <dewar@gnat.com>, <Dautrevaux@microprocess.com>, <paulus@samba.org>,
        <Franz.Sirl-kernel@lauterbach.com>, <benh@kernel.crashing.org>,
        <gcc@gcc.gnu.org>, <jtv@xs4all.nl>, <linux-kernel@vger.kernel.org>,
        <linuxppc-dev@lists.linuxppc.org>, <minyard@acm.org>, <rth@redhat.com>,
        <trini@kernel.crashing.org>, <velco@fadata.bg>
Subject: Re: [PATCH] C undefined behavior fix
In-Reply-To: <87wuyy33zo.fsf@deneb.enyo.de>
Message-ID: <Pine.LNX.4.33.0201041132140.19767-100000@kern.srcf.societies.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Jan 2002, Florian Weimer wrote:

> C99 includes a list of additional guarantees made by many C
> implementations (in an informative index).  I think we really should
> check this list (and the list of implementation-defined behavior) and
> document the choices made by GCC.  In fact, this documentation is
> required by the standard.

The list of implementation-defined behavior is already in the manual (in
extend.texi).  However, the actual documentation isn't yet there, only the
headings - except for the preprocessor, where it is covered in cpp.texi,
and the conversion between pointers and integers:

@item
@cite{The result of converting a pointer to an integer or
vice versa (6.3.2.3).}

A cast from pointer to integer discards most-significant bits if the
pointer representation is larger than the integer type,
sign-extends@footnote{Future versions of GCC may zero-extend, or use
a target-defined @code{ptr_extend} pattern.  Do not rely on sign extension.}
if the pointer representation is smaller than the integer type, otherwise
the bits are unchanged.
@c ??? We've always claimed that pointers were unsigned entities.
@c Shouldn't we therefore be doing zero-extension?  If so, the bug
@c is in convert_to_integer, where we call type_for_size and request
@c a signed integral type.  On the other hand, it might be most useful
@c for the target if we extend according to POINTERS_EXTEND_UNSIGNED.

A cast from integer to pointer discards most-significant bits if the
pointer representation is smaller than the integer type, extends according
to the signedness of the integer type if the pointer representation
is larger than the integer type, otherwise the bits are unchanged.

When casting from pointer to integer and back again, the resulting
pointer must reference the same object as the original pointer, otherwise
the behavior is undefined.  That is, one may not use integer arithmetic to
avoid the undefined behavior of pointer arithmetic as proscribed in 6.5.6/8.

-- 
Joseph S. Myers
jsm28@cam.ac.uk

