Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135170AbRD3RjP>; Mon, 30 Apr 2001 13:39:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136486AbRD3RjG>; Mon, 30 Apr 2001 13:39:06 -0400
Received: from snark.tuxedo.org ([207.106.50.26]:29708 "EHLO snark.thyrsus.com")
	by vger.kernel.org with ESMTP id <S135170AbRD3Riy>;
	Mon, 30 Apr 2001 13:38:54 -0400
Date: Mon, 30 Apr 2001 13:39:32 -0400
From: "Eric S. Raymond" <esr@thyrsus.com>
To: John Stoffel <stoffel@casc.com>
Cc: CML2 <linux-kernel@vger.kernel.org>, kbuild-devel@lists.sourceforge.net
Subject: Re: CML2 1.3.1, aka "I stick my neck out a mile..."
Message-ID: <20010430133932.B28849@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	John Stoffel <stoffel@casc.com>,
	CML2 <linux-kernel@vger.kernel.org>,
	kbuild-devel@lists.sourceforge.net
In-Reply-To: <20010427193501.A9805@thyrsus.com> <15084.12152.956561.490805@gargle.gargle.HOWL> <20010429183526.B32748@thyrsus.com> <15085.37569.205459.898540@gargle.gargle.HOWL>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <15085.37569.205459.898540@gargle.gargle.HOWL>; from stoffel@casc.com on Mon, Apr 30, 2001 at 12:28:49PM -0400
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Stoffel <stoffel@casc.com>:
> It should then highlight *all* of the potential problem config
> setting(s) and let the user deal.  But they should never be forced to
> hand edit their config file because a dependency is broken somewhere.
> CML2 should enforce the *writing* of compliant files, but should deal
> gracefully with non-compliant ones.  Within reason of course.  

The "within reason" is the problem.  It's very easy to construct
simple cases of invalid configs that blow the number of `tainted'
symbols up much larger than the number of violated constraints.  An
interface of the kind you suggest would deluge the user with possible
things to be corrected without actually revealing the nature of the
problem.

Besides, right now the configurator has a simple invariant.  It will
only accept consistent configurations and it will only write
consistent configurations -- in fact, your configuration is guaranteed
correct after ever attempt to change a symbol with the configurator
itself.  I'm very, very reluctant to do anything that will go near
breaking that invariant.

I believe the the right fix is to go through the one-time transition
necessary to be in a world where inconsistent configurations never get
written, rather than to be overly accomodating to yesterday's bugs.

> Eric> USB and SCSI are both enabled/disabled in the system buses menu.
> Eric> The apparent confusion
> 
> Then they should be pushed down a level to be under those buses.  They
> don't belong on the top level.

That doesn't work either.  See the "Good style in rulebase design"
section in the CML2 paper for discussion.  The last paragraph is
especially relevant.
 
> More correctly, *any* configuration setting on an upper level should
> not depend on a lower level setting.

Sorry, that's dreadfully bad advice and is not going to happen.  If I did
as you suggest, I'd be throwing out the ability to do consistency
checks and deduce side effects.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

"Those who make peaceful revolution impossible 
will make violent revolution inevitable."
	-- John F. Kennedy
