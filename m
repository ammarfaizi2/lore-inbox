Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262687AbTDUXyB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 19:54:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262690AbTDUXyB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 19:54:01 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:12676 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S262687AbTDUXx6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 19:53:58 -0400
Date: Tue, 22 Apr 2003 01:04:40 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andy Kleen <ak@muc.de>
Subject: Re: [PATCH] Runtime memory barrier patching
Message-ID: <20030422000440.GB17793@mail.jlokier.co.uk>
References: <200304211945_MC3-1-355A-F77D@compuserve.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200304211945_MC3-1-355A-F77D@compuserve.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chuck Ebbert wrote:
> > Does anybody have the preferred Intel sequence somewhere?
> 
>   These are in Intel ASM form (i.e. dest first) from the 486 manual:
> 
>  2-bytes            mov reg,reg
>  3-bytes            lea reg, 0[reg]  ; 8-bit displacement

Look in the GAS source code for opcodes.

At least on the 486 and Pentium (I remember that part of GAS in those
days), it makes sense to select a register that is not set in the
preceding few instructions or used in the subsequent few.  Otherwise,
lea's use of a register adds an address generation delay (worse than
just a mov).

Hence use of %esi and %edi in GAS - registers allocated last by the
compiler, so least likely to be used/set in surrounding instructions.

The register selection is probably too difficult to automate, though.

-- Jamie

