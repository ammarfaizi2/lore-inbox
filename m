Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751179AbVJaHqr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751179AbVJaHqr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 02:46:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751202AbVJaHqr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 02:46:47 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:2016 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1751179AbVJaHqr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 02:46:47 -0500
From: Junio C Hamano <junkio@cox.net>
To: linux-kernel@vger.kernel.org
Subject: Re: [git patches] 2.6.x libata updates
References: <20051029182228.GA14495@havoc.gtf.org>
	<200510301731.47825.rob@landley.net>
	<Pine.LNX.4.64.0510301654310.27915@g5.osdl.org>
	<200510302035.26523.rob@landley.net>
cc: Rob Landley <rob@landley.net>
Date: Sun, 30 Oct 2005 23:46:45 -0800
In-Reply-To: <200510302035.26523.rob@landley.net> (Rob Landley's message of
	"Sun, 30 Oct 2005 20:35:26 -0600")
Message-ID: <7v7jbujfh6.fsf@assigned-by-dhcp.cox.net>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Landley <rob@landley.net> writes:

> grep -n MARKER bisect.patch | less
> (pick a line number)
> head -n linenumber bisect.patch > test.patch
>
> If that's not it, revert test.patch and then try again.  Tell us the first 
> line number that failed, which is the end of the patch we want...
>
> Hmmm...  The logical place to put the URL to gitweb is at the _end_ of the 
> patch, attached to the marker.  So that's what they see in the grep, and the 
> last thing they test when they cut at that line with head -n...

Well, do people realize that 'git bisect' is *not* a textual
half-way between, but rather is computed every time you feed
new "the patch you told me to test last time was good/bad"
information?  I do not think statically generating a huge text
and telling the user to apply up to halfway and bisect by hand
would not work -- it would be quite different from what git
bisect would give you.

I think public webserver based bisect service David Lang
suggests might work.  The interaction with it would start by the
end user somehow giving it the last known-working commit ID (A)
(pick from gitweb shortlog, perhaps) and a commit ID newer than
that that broke things (B) (again, pick from gitweb shortlog).
Then the service runs bisect on the server side, spit out a diff
against (A).  The end user applies the patch, try it, and then
come back and tell if it worked or not,...  Since we are talking
about the kernel development, I think the cycle might involve
rebooting the machine; so you would probably need two machines
(one guinea-pig machine to reboot, another to keep the browser
open so that your state can be kept somehow).

