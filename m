Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262699AbSJGUEx>; Mon, 7 Oct 2002 16:04:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262710AbSJGUEI>; Mon, 7 Oct 2002 16:04:08 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:37252 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S262699AbSJGUCx>;
	Mon, 7 Oct 2002 16:02:53 -0400
Date: Mon, 7 Oct 2002 22:08:29 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: jbradford@dial.pipex.com
Cc: Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.X breaks PS/2 mouse
Message-ID: <20021007220829.A1773@ucw.cz>
References: <20021007162318.A758@ucw.cz> <200210072015.g97KFjch003948@darkstar.example.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200210072015.g97KFjch003948@darkstar.example.net>; from jbradford@dial.pipex.com on Mon, Oct 07, 2002 at 09:15:45PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 07, 2002 at 09:15:45PM +0100, jbradford@dial.pipex.com wrote:
> Finally re-assembled the laptop :-)
> 
> > > I didn't, but I've compiled a new kernel with it in.  Unfortunately,
> > > it doesn't seem to do anything useful :-(.
> > > 
> > > cat /dev/input/eventX | hexdump
> > > 
> > > returns nothing, not even for keyboard events, which makes me think
> > > I've gone wrong somewhere :-/
> > 
> > Have you tried all of them (0, 1, 2 ...)? Btw, you can compile evbug in
> > also.
> 
> Whoops, me being silly again, I actually created a single device node
> called /dev/input/eventX instead of event1, event2, etc.  :-)
> 
> > > mouse
> > > 
> > >  Left button - 09 00 00 08 00 00
> > > Right button - 0a 00 00 08 00 00
> > > 
> > > trackball
> > > 
> > >  Left button - 01 00 00 00 00 00
> > > Right button - 02 00 00 00 00 00
> > 
> > Hmm, interesting ... let's see what that means ...
> > 
> > Indeed the 0x08 byte indicates the beginning of a packet. The driver
> > synchronizes on that, and when it's missing, it ignores the packets.
> > Thus, it ignores all the packets from the trackball.
> > 
> > This patch should fix that:
> 
> It does.  Cool!
> 
> GPM and X work perfectly.
> 
> Cheers!

And yet another case closed. :)

-- 
Vojtech Pavlik
SuSE Labs
