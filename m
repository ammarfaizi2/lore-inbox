Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262796AbTCEJZI>; Wed, 5 Mar 2003 04:25:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264797AbTCEJZI>; Wed, 5 Mar 2003 04:25:08 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:62728 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262796AbTCEJZH>; Wed, 5 Mar 2003 04:25:07 -0500
Date: Wed, 5 Mar 2003 09:35:34 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Gerd Knorr <kraxel@bytesex.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: reducing stack usage in v4l?
Message-ID: <20030305093534.A8883@flint.arm.linux.org.uk>
Mail-Followup-To: Gerd Knorr <kraxel@bytesex.org>,
	linux-kernel@vger.kernel.org
References: <32833.4.64.238.61.1046841945.squirrel@www.osdl.org> <87u1eigomv.fsf@bytesex.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <87u1eigomv.fsf@bytesex.org>; from kraxel@bytesex.org on Wed, Mar 05, 2003 at 10:15:52AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 05, 2003 at 10:15:52AM +0100, Gerd Knorr wrote:
> But when looking at the disasm output it is obvious that it isn't true
> (at least with gcc 3.2).  On the other hand it is common practice in
> many drivers, there must be a reason for that, no?  Any chance this
> used to work with older gcc versions?

I don't believe so - I seem to remember looking at gcc 2.95 and finding
the same annoying behaviour.

> Not sure what is the best idea to fix that.  Don't like the kmalloc
> idea that much.  The individual structs are not huge, the real problem
> is that many of them are allocated and only few are needed.  Any
> chance to tell gcc that it should allocate block-local variables at
> the start block not at the start of the function?

Not a particularly clean idea, but maybe creating a union of the
structures and putting that on the stack? (ie, doing what GCC should
be doing in the first place.)

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

