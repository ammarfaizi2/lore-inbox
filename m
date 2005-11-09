Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030380AbVKICPA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030380AbVKICPA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 21:15:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965227AbVKICPA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 21:15:00 -0500
Received: from smtp103.sbc.mail.re2.yahoo.com ([68.142.229.102]:36001 "HELO
	smtp103.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S965156AbVKICO7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 21:14:59 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Douglas McNaught <doug@mcnaught.org>
Subject: Re: typedefs and structs
Date: Tue, 8 Nov 2005 21:14:51 -0500
User-Agent: KMail/1.8.3
Cc: linas <linas@austin.ibm.com>, Kyle Moffett <mrmacman_g4@mac.com>,
       Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
       bluesmoke-devel@lists.sourceforge.net,
       linux-pci@atrey.karlin.mff.cuni.cz, linuxppc64-dev@ozlabs.org
References: <20051107185621.GD19593@austin.ibm.com> <20051109004808.GM19593@austin.ibm.com> <m21x1qhbzn.fsf@Douglas-McNaughts-Powerbook.local>
In-Reply-To: <m21x1qhbzn.fsf@Douglas-McNaughts-Powerbook.local>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511082114.52159.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 08 November 2005 19:59, Douglas McNaught wrote:
> linas <linas@austin.ibm.com> writes:
> 
> > On Tue, Nov 08, 2005 at 07:37:20PM -0500, Douglas McNaught was heard to remark:
> >> 
> >> Yeah, but if you're trying to read that code, you have to go look up
> >> the declaration to figure out whether it might affect 'foo' or not.
> >> And if you get it wrong, you get silent data corruption.
> >
> > No, that is not what "pass by reference" means. You are thinking of
> > "const", maybe, or "pass by value"; this is neither.  The arg is not 
> > declared const, the subroutine can (and usually will) modify the contents 
> > of the structure, and so the caller will be holding a modified structure
> > when the callee returns (just like it would if a pointer was passed).
> 
> Right.  My point is only that it's not clear from looking at the call
> site whether a struct passed by reference will be modified by the
> callee (some people pass by reference just for "efficiency").  And if
> the called function modifies the data without the caller's knowledge,
> it leads to obscure bugs.  Whereas if you pass a pointer, it's
> immediately clear that the called function can modify the pointed-to
> object.
>

A structure is almost never passed by value, no matter whether it is C
or C++. So both languages require you either use descriptive naming or
look up declaration/implementation:

C:
	struct str {
		char buf[1024];
		int count;
	};
	struct str s;

	do_something_with_s(&s);
	do_something_else_with_s(&s);

Which one modufies s?

-- 
Dmitry
