Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310494AbSCLJMs>; Tue, 12 Mar 2002 04:12:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310502AbSCLJMn>; Tue, 12 Mar 2002 04:12:43 -0500
Received: from www.deepbluesolutions.co.uk ([212.18.232.186]:38156 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S310494AbSCLJMb>; Tue, 12 Mar 2002 04:12:31 -0500
Date: Tue, 12 Mar 2002 09:11:44 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Ed Vance <EdV@macrolink.com>
Cc: "'linux-serial'" <linux-serial@vger.kernel.org>,
        "'linux-kernel'" <linux-kernel@vger.kernel.org>,
        "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] serial.c procfs 2nd try - discussion
Message-ID: <20020312091144.A11914@flint.arm.linux.org.uk>
In-Reply-To: <11E89240C407D311958800A0C9ACF7D13A76EF@EXCHANGE>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <11E89240C407D311958800A0C9ACF7D13A76EF@EXCHANGE>; from EdV@macrolink.com on Mon, Mar 11, 2002 at 05:41:09PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2002 at 05:41:09PM -0800, Ed Vance wrote:
> 2. Does anybody know of anything that will break because of the leading 
>    zeros that are now present on the address field? 

I'm not overly happy with this idea - there isn't anything that says an
ioport address has 4 digits.  I know of machines where an ioport address
has 8, and I'm sure on the Alpha or Sparc64 its probably 16 digits.

It might be a better solution to leave the 'port:' element as-is if
programs like kudzu rely on that label there, and just fix the missing
statistics for iomem ports.

Then file a bug against kudzu and get them to fix that so it doesn't
SEGV when it finds something it doesn't like, and teach it about the
'mem' tag.

If kudzu ignores the serinfo: line as well, that's also another kudzu
bug.

Then fix the proc interface to report a 'mem' tag for each port.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

