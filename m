Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291948AbSCMBrs>; Tue, 12 Mar 2002 20:47:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291780AbSCMBrj>; Tue, 12 Mar 2002 20:47:39 -0500
Received: from exchange.macrolink.com ([64.173.88.99]:61703 "EHLO
	exchange.macrolink.com") by vger.kernel.org with ESMTP
	id <S291745AbSCMBrW>; Tue, 12 Mar 2002 20:47:22 -0500
Message-ID: <11E89240C407D311958800A0C9ACF7D13A76F7@EXCHANGE>
From: Ed Vance <EdV@macrolink.com>
To: "'Jeff Garzik'" <jgarzik@mandrakesoft.com>,
        Russell King <rmk@arm.linux.org.uk>
Cc: "'linux-serial'" <linux-serial@vger.kernel.org>,
        "'linux-kernel'" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] serial.c procfs kudzu 2nd try - discussion
Date: Tue, 12 Mar 2002 17:47:20 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> 
> Russell King wrote:
> 
> >On Mon, Mar 11, 2002 at 05:41:09PM -0800, Ed Vance wrote:
> >
> >>2. Does anybody know of anything that will break because of the leading 
> >>   zeros that are now present on the address field? 
> >>
> >
> >I'm not overly happy with this idea - there isn't anything that says an
> >ioport address has 4 digits.  I know of machines where an ioport address
> >has 8, and I'm sure on the Alpha or Sparc64 its probably 16 digits.
> >
> Agreed.  Standard portability convention seems to say that one treats io 
> ports and io mem both as unsigned long, including when printing...

Yeah. It was pretty ugly. My brain was caught in an x86-think well. I will
resubmit with serinfo back to 1.0, all addresses in free form as they were
before, proper lines for memory mapped ports (tagged "port:"), and no lines
generated for nonexistent ports. 

Russell King wrote:
> 
> Then file a bug against kudzu and get them to fix that so it doesn't
> SEGV when it finds something it doesn't like, and teach it about the
> 'mem' tag.
> 
> If kudzu ignores the serinfo: line as well, that's also another kudzu
> bug.

Kudzu ignores all lines that do not contain "uart", including the serinfo
line. I will ask Red Hat to change pciserial.c to look for "mem" if "port"
is not found and handle them interchangeably, so we can use the "mem" tag
later, and to check the returned values of the string functions before
attempting a de-reference.

Thanks for the good input.

Ed

---------------------------------------------------------------- 
Ed Vance              serial24@macrolink.com
Macrolink, Inc.       1500 N. Kellogg Dr  Anaheim, CA  92807
----------------------------------------------------------------

