Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135885AbRDTMPZ>; Fri, 20 Apr 2001 08:15:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135886AbRDTMPP>; Fri, 20 Apr 2001 08:15:15 -0400
Received: from snark.tuxedo.org ([207.106.50.26]:61199 "EHLO snark.thyrsus.com")
	by vger.kernel.org with ESMTP id <S135885AbRDTMPA>;
	Fri, 20 Apr 2001 08:15:00 -0400
Date: Fri, 20 Apr 2001 08:15:49 -0400
From: "Eric S. Raymond" <esr@thyrsus.com>
To: CML2 <linux-kernel@vger.kernel.org>, kbuild-devel@lists.sourceforge.net
Subject: Plans for Configure.help
Message-ID: <20010420081549.A4263@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	CML2 <linux-kernel@vger.kernel.org>,
	kbuild-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since Axel Boldt just handed me the maintainer's baton for Configure.help,
now would probably be a good time for me to explain why I took the job,
what my plans for it are, and how they fit into the CML2 work and other
things I'm doing.

Once Linus put the imprimatur on CML2 for 2.5, it looked pretty
inevitable to me that I would end up with de facto reponsibility for
the help file.  The configuration system is that file's only user,
and there are good reasons to re-engineer the interface between
them.  

A major one is that CML2's question prompts are separated into symbol
files in order to support internationalization -- and it's silly for
that information to be separate from the help file.  Right now, the
prompts associated with each symbol are stored twice and the copy
in Configure.help is unused.

So after CML2 goes in, I plan to merge CML2's symbol files with
Configure.help.  That file will move to a new format, perhaps some 
simple flavor of XML markup, and contain all internationalizable
text elements of the configurator.

Something else I plan to do is change the convention for handing 
radiobutton symbols like processor-type choices.  At present, if you
request help for one of these, CML1 looks up the help for the 
first entry in the containing choice menu.  This was a kluge to get
around the fact that menus are not named entities in CML1 and can't
have help in them.  In CML2, the menu names and banners will be in
the help file, and will have their own help texts.


In preparation for these changes, I have been writing help entries
(65 of them so far) and taking a  hard look at the CONFIG_ symbol
namespace.  I really have a couple of overlapping agendas here:

1. Clean up and update the Configure.help file.  There are too many
orphans and duplicates in there and too many symbols missing entries.
I'd like to have this in shape before the 2.5 fork, as it will affect
the user's CML1 configuration experience in the stable 2.4 branch.

Steven Cole (who has asked to be listed as co-maintainer, and IMO has
earned it) is very interested in tackling this.  I think it will be a
good division of labor for him to do most of the content editing and
updating while I take care of the format and interface redesign.

2. Develop better auditing and consistency-checking tools.  Steven's
ach script was a good start, but it only cross-checks Configure.help
with [Cc]onfig.in files.  My kxref can do a better job by checking
against the C code as well.  Again, this is not a CML2-specific issue.

3. Once I wrote kxref and looked at the reports from it, I realized 
that the CONFIG_ namespace is a mess.  More about this in a separate 
thread, since it has implications beyond the help system.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

"Extremism in the defense of liberty is no vice; moderation in the
pursuit of justice is no virtue."
	-- Barry Goldwater (actually written by Karl Hess)
