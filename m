Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261983AbTCZTYf>; Wed, 26 Mar 2003 14:24:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261987AbTCZTYf>; Wed, 26 Mar 2003 14:24:35 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:62981 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261983AbTCZTYQ>;
	Wed, 26 Mar 2003 14:24:16 -0500
Date: Wed, 26 Mar 2003 11:34:37 -0800
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Subject: Re: kernel BUG at sched.c:564! (2.4.20, 2.4.21-pre5-ac3)
Message-ID: <20030326193437.GI24689@kroah.com>
References: <20030326162538.GG2695@spackhandychoptubes.co.uk> <20030326185236.GE24689@kroah.com> <20030326192520.GH2695@spackhandychoptubes.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030326192520.GH2695@spackhandychoptubes.co.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 26, 2003 at 07:25:20PM +0000, Chris Sykes wrote:
> 
> I seem to have worked around it for now.  I've jumpered the hardware
> to stop it from echoing what you transmit back locally and all seems
> OK now.

Good.

> > Can you test 2.5 to see if this is fixed there for you or not?
> 
> I can test it yes, but 2.5 may be a bit too unstable for our
> production use ATM.

I understand.

> Anyway I'll test out a 2.5 kernel when I'm back in the office
> tomorrow, I can devote some time to tracking down the problem if you
> can give me some pointers on where to start.  I'd like to be able to
> feel confident that this will work reliably under 2.4, otherwise I
> guess I need to look for alternate solutions.

The problem is in the race on close() in the usb-serial.c code.  In 2.5
that logic has been rewritten to (hopefully) get rid of the race.  That
is what will need to be backported, once people test that this fixes the
issue.

thanks,

greg k-h
