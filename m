Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293162AbSBWRHm>; Sat, 23 Feb 2002 12:07:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293161AbSBWRHd>; Sat, 23 Feb 2002 12:07:33 -0500
Received: from outpost.ds9a.nl ([213.244.168.210]:16820 "HELO
	outpost.powerdns.com") by vger.kernel.org with SMTP
	id <S293159AbSBWRH0>; Sat, 23 Feb 2002 12:07:26 -0500
Date: Sat, 23 Feb 2002 18:07:25 +0100
From: bert hubert <ahu@ds9a.nl>
To: Larry McVoy <lm@work.bitmover.com>, Dan Aloni <da-x@gmx.net>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] [PATCH] C exceptions in kernel
Message-ID: <20020223180725.A3030@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Larry McVoy <lm@work.bitmover.com>, Dan Aloni <da-x@gmx.net>,
	linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1014412325.1074.36.camel@callisto.yi.org> <20020223162100.A1952@outpost.ds9a.nl> <1014480355.1844.16.camel@callisto.yi.org> <20020223082211.Z11156@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020223082211.Z11156@work.bitmover.com>; from lm@bitmover.com on Sat, Feb 23, 2002 at 08:22:11AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 23, 2002 at 08:22:11AM -0800, Larry McVoy wrote:
> On Sat, Feb 23, 2002 at 06:05:48PM +0200, Dan Aloni wrote:
> > But, it CAN be used in *local* driver call branches. Writing a new
> > driver? have a lot of local nested calls? Hate goto's? You can use
> > exceptions.
> 
> Is this really anything other than syntactic sugar?  Maybe it's different 
> in drivers, but I find myself doing the following in user space all the time

Exceptions provide implicit handling. You should see tham as an alternate
return path. And because of that implicitness, it is not syntactic sugar.

However, one thing which your example does emphasize, it the risk of
resource leaks. Bjarne Stroustrup, who is no mean architect himself, spends
a lot of pages discussing those leaks.

Basically, an exception may fall through several functions before being
caught. Any resources acquired by those intermediate functions will not be
released unless this is done automatically during stack unwinding, ie,
destroctors or alloca(3).

So while having an alternate return path is cool, it really needs
destructors in order to be useful in a real world. 

This url documents the problem, which is solved by adopting the 'Resource
Acquisition is Initialization' paradigm:
   http://sourceforge.net/docman/display_doc.php?docid=8673&group_id=9028

Regards,

bert

-- 
http://www.tk                              the dot in .tk
Netherlabs BV / Rent-a-Nerd.nl           - Nerd Available -
Linux Advanced Routing & Traffic Control: http://ds9a.nl/lartc
