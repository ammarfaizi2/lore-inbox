Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265974AbUAEW5Y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 17:57:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265993AbUAEW5X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 17:57:23 -0500
Received: from ip-213-226-226-138.ji.cz ([213.226.226.138]:32249 "HELO
	machine.sinus.cz") by vger.kernel.org with SMTP id S265974AbUAEWzP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 17:55:15 -0500
Date: Mon, 5 Jan 2004 23:55:08 +0100
From: Petr Baudis <pasky@ucw.cz>
To: Diego Calleja <grundig@teleline.es>, Robert.L.Harris@rdlg.net,
       vherva@niksula.hut.fi, ihaquer@isec.pl, cliph@isec.pl
Cc: linux-kernel@vger.kernel.org
Subject: mremap() bug IMHO not in 2.2
Message-ID: <20040105225508.GM2093@pasky.ji.cz>
Mail-Followup-To: Diego Calleja <grundig@teleline.es>,
	Robert.L.Harris@rdlg.net, vherva@niksula.hut.fi, ihaquer@isec.pl,
	cliph@isec.pl, linux-kernel@vger.kernel.org
References: <20040105145421.GC2247@rdlg.net> <Pine.LNX.4.58L.0401051323520.1188@logos.cnet> <20040105181053.6560e1e3.grundig@teleline.es> <20040105182607.GB2093@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040105182607.GB2093@pasky.ji.cz>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear diary, on Mon, Jan 05, 2004 at 07:26:07PM CET, I got a letter,
where Petr Baudis <pasky@ucw.cz> told me, that...
> Dear diary, on Mon, Jan 05, 2004 at 06:10:53PM CET, I got a letter,
> where Diego Calleja <grundig@teleline.es> told me, that...
> > El Mon, 5 Jan 2004 13:26:23 -0200 (BRST) Marcelo Tosatti <marcelo.tosatti@cyclades.com> escribió:
> > 
> > > On Mon, 5 Jan 2004, Robert L. Harris wrote:
> > > > Just read this on full disclosure:
> > > >
> > > > http://isec.pl/vulnerabilities/isec-0013-mremap.txt
> > [...]
> > > It is possible that the problem is exploitable. There is no known public
> > > exploit yet, however.
> > > 
> > > 2.4.24 includes a fix for this (mm/mremap.c diff)
> > 
> > It names 2.2 too. Is there a fix for 2.2?
> 
> I'm trying to investigate that right now. In 2.2, mremap() doesn't yet
> take yet the new_addr argument, therefore the "official" 2.4 fix
> wouldn't apply at all to it. There are four possibilities:
> 
> * The isec.pl guys just made a mistake.
> 
> * 2.2's get_unmapped_area() can return dangerous pages for len == 0,
> whilst the 2.4's get_unmapped_area() cannot. (I'm not sure, looking into
> that code right now.)
> 
> * 2.4's fix is incorrect.
> 
> * I'm missing something obvious.

Actually, after looking at the code again, I'm now quite convinced 2.2
has not this particular vulnerability. In order for the exploit to work,
you'd need mremap() to relocate you.

But mremap() won't take newaddr argument, so you can't get yourself
relocated explicitly. And mremap() will not relocate yourself implicitly
to some random spot neither, because since newlen is zero, it will
always trigger the shrinking code, which will just munmap() and bail
out.

ihaquer, any comments? Is there something we don't know about? If not,
please correct your announcement.

Kind regards,

-- 
 
				Petr "Pasky" Baudis
.
The brain is a wonderful organ; it starts working the moment you get up
in the morning, and does not stop until you get to work.
.
Stuff: http://pasky.or.cz/
