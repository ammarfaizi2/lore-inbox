Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264143AbTDOWx4 (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 18:53:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264144AbTDOWx4 
	(for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 18:53:56 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:21266 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S264143AbTDOWxz (for <rfc822;linux-kernel@vger.kernel.org>); Tue, 15 Apr 2003 18:53:55 -0400
Date: Wed, 16 Apr 2003 00:05:45 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Eli Carter <eli.carter@inet.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: .section ... "ax" vs  #alloc, #execinstr
Message-ID: <20030416000545.H32468@flint.arm.linux.org.uk>
Mail-Followup-To: Eli Carter <eli.carter@inet.com>,
	LKML <linux-kernel@vger.kernel.org>
References: <3E9C664A.503@inet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3E9C664A.503@inet.com>; from eli.carter@inet.com on Tue, Apr 15, 2003 at 03:06:34PM -0500
X-Message-Flag: Your copy of Microsoft Outlook is vurnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 15, 2003 at 03:06:34PM -0500, Eli Carter wrote:
> Some of the assembly files use
> .section        ".start", "ax"
> and others use
> .section ".start", #alloc, #execinstr
> (and not just for .start, try
> find -name \*.S | xargs grep -e '\.section'
> )
> 
> These appear to be equivelent, if not somebody clue me in please. :) 
> Which is the prefered form?  The latter seems to provide a bit more for 
> the human, so I'd vote that direction... ;)

I guess you're asking about the IOP3xx stuff.

info as
mp<tab>
msec<tab>

gives all the details.  To summarise though:

	"a" or "#alloc" - the section is allocatable
	"x" or "#execinstr" - the section is executable

"ax" seems to be what Linus uses.  I used to use the long versions, but
changed to the shorter version - less characters to type, but still
fairly readable.  After all, you don't catch people trying to make ls
report stuff like:

file, user read write execute, group read execute, other read execute,
2 links, owner root, group root, 44 kibytes, modified xxxx, name "foo"

(or I hope you don't! 8))

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

