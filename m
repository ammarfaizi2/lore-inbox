Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317028AbSEWWCK>; Thu, 23 May 2002 18:02:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317029AbSEWWCJ>; Thu, 23 May 2002 18:02:09 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:62218 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S317028AbSEWWCJ>; Thu, 23 May 2002 18:02:09 -0400
Date: Fri, 24 May 2002 00:02:11 +0200
From: Pavel Machek <pavel@suse.cz>
To: "Gross, Mark" <mark.gross@intel.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, "'Erich Focht'" <focht@ess.nec.de>,
        mgross@unix-os.sc.intel.com,
        "Vamsi Krishna S." <vamsi_krishna@in.ibm.com>,
        linux-kernel@vger.kernel.org, r1vamsi@in.ibm.com
Subject: swsusp and Multithreaded core dumps for the 2.5.17 kernel  was ... .RE:    PATCH Multithreaded...
Message-ID: <20020523220211.GC11615@atrey.karlin.mff.cuni.cz>
In-Reply-To: <59885C5E3098D511AD690002A5072D3C057B48AE@orsmsx111.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I don't understand what lock problems software suspend has to worry about so
> I cannot comment.
> 
> However; your design has ALL the processes getting suspended.  To use the
> phantom run queue and migrate them all to it, even with semaphore locks,
> makes good sense to me.

That can not be done, because I'll need to do write-to-swapspace with those
processes frozen, and if they hold some semaphores, that may not be
possible.

> This would allow the software suspend to work with RT processes and SMP
> systems as well.  Further such a feature "could" enable a type of
> warm-swapping of hardware to a large system.  

I believe it should work with RT as-is. SMP is another issue, I'll
probably wait for hotplug-cpu patches for that. (I do not want to save
state of secondary cpu's). 
								Pavel
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
