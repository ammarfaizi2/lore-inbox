Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265708AbSLTVW4>; Fri, 20 Dec 2002 16:22:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265713AbSLTVWz>; Fri, 20 Dec 2002 16:22:55 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:17931 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S265708AbSLTVWz>; Fri, 20 Dec 2002 16:22:55 -0500
Date: Fri, 20 Dec 2002 21:30:56 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: James Simmons <jsimmons@infradead.org>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
       linux-fbdev-devel@lists.sourceforge.net
Subject: Re: [Linux-fbdev-devel] Type confusion in fbcon
Message-ID: <20021220213056.A25155@flint.arm.linux.org.uk>
Mail-Followup-To: James Simmons <jsimmons@infradead.org>,
	Linux Kernel List <linux-kernel@vger.kernel.org>,
	linux-fbdev-devel@lists.sourceforge.net
References: <20021219231415.A25145@flint.arm.linux.org.uk> <Pine.LNX.4.44.0212201808070.6471-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0212201808070.6471-100000@phoenix.infradead.org>; from jsimmons@infradead.org on Fri, Dec 20, 2002 at 06:10:17PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 20, 2002 at 06:10:17PM +0000, James Simmons wrote:
> > I'll get back to bashing the sa1100fb driver to work out why fbcon is
> > producing a _completely_ blank display, despite characters being written
> > to it.
> 
> Did you figure out what was wrong?

Firstly, setting fix.line_length to zero (which the old API didn't care
about) caused one set of problems.

Secondly, the sa1100fb set_par function doesn't set the var RGB elements -
that's left to the check_var function.  Originally, we effectively did
a fb_set_var which took care of that for us.  Now we explicitly call
our check_var implementation prior to registering the framebuffer
driver with the fbcon core.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

