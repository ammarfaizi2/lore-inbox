Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262956AbTCKP0r>; Tue, 11 Mar 2003 10:26:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262958AbTCKP0r>; Tue, 11 Mar 2003 10:26:47 -0500
Received: from crack.them.org ([65.125.64.184]:2190 "EHLO crack.them.org")
	by vger.kernel.org with ESMTP id <S262956AbTCKP0q>;
	Tue, 11 Mar 2003 10:26:46 -0500
Date: Tue, 11 Mar 2003 10:36:49 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Gerd Knorr <kraxel@bytesex.org>, "Randy.Dunlap" <rddunlap@osdl.org>,
       rmk@arm.linux.org.uk,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: reducing stack usage in v4l?
Message-ID: <20030311153649.GA13882@nevyn.them.org>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Gerd Knorr <kraxel@bytesex.org>, "Randy.Dunlap" <rddunlap@osdl.org>,
	rmk@arm.linux.org.uk,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <32833.4.64.238.61.1046841945.squirrel@www.osdl.org> <87u1eigomv.fsf@bytesex.org> <20030305093534.A8883@flint.arm.linux.org.uk> <20030305073437.0673458e.rddunlap@osdl.org> <33000.4.64.238.61.1047356833.squirrel@www.osdl.org> <20030311091934.GB20721@bytesex.org> <1047400169.19262.3.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1047400169.19262.3.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 11, 2003 at 04:29:30PM +0000, Alan Cox wrote:
> On Tue, 2003-03-11 at 09:19, Gerd Knorr wrote
> 
> > That is wrong, at least the 2k memset/call mentioned by Andrew.  There
> > are lots of memset() calls, but they all are within the case switches
> > for the ioctls and zero out only the structs which are used in that code
> > path, so it is actually much smaller (~50 -> ~300 bytes maybe, depending
> > on the ioctl).
> 
> gcc sometimes does things like allocate all the objects in case
> statements at entry time. I assume its a performance win to do so.

No, it's more likely a known GCC bug to do so.  See PR middle-end/9997
if you're really curious.

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
