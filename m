Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262826AbVCPWiT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262826AbVCPWiT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 17:38:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261759AbVCPWiS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 17:38:18 -0500
Received: from mirapoint1.TIS.CWRU.Edu ([129.22.104.46]:47643 "EHLO
	mirapoint1.tis.cwru.edu") by vger.kernel.org with ESMTP
	id S262826AbVCPWiD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 17:38:03 -0500
From: prj@po.cwru.edu (Paul Jarc)
To: linux-kernel@vger.kernel.org
Cc: supervision@list.skarnet.org
Subject: Re: a problem with linux 2.6.11 and sa
In-Reply-To: <20050316031814.GB1315@ixeon.local> (George Georgalis's message
	of "Tue, 15 Mar 2005 22:18:14 -0500")
Organization: What did you have in mind?  A short, blunt, human pyramid?
References: <20050303214023.GD1251@ixeon.local>
	<6.2.1.2.0.20050303165334.038f32a0@192.168.50.2>
	<20050303224616.GA1428@ixeon.local>
	<871xaqb6o0.fsf@amaterasu.srvr.nix>
	<20050308165814.GA1936@ixeon.local>
	<871xap9dfg.fsf@amaterasu.srvr.nix>
	<20050309152958.GB4042@ixeon.local> <m3is40z9dy.fsf@multivac.cwru.edu>
	<20050316031814.GB1315@ixeon.local>
Mail-Copies-To: nobody
Mail-Followup-To: linux-kernel@vger.kernel.org, supervision@list.skarnet.org
Date: Wed, 16 Mar 2005 17:37:59 -0500
Message-ID: <m3r7if6wte.fsf@multivac.cwru.edu>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"George Georgalis" <george@galis.org> wrote:
> On Wed, Mar 09, 2005 at 06:28:35PM -0500, Paul Jarc wrote:
>> To simplify, what about these two:
>> mplayer foo.mpg
>> mplayer foo.mpg < mediafiles.txt
>
> The particular host does not have X support so mpg is out.

Well, use any one of the files listed in mediafiles.txt.  I expect the
first one would behave the same as your for loop, and the second would
behave the same as your while loop.

> I'm not sure that that test would work as mplayer requires filenames
> as command arguments not stdin (exclusivly, I think);

Note that I said to redirect input from mediafiles.txt, not from any
of the filenames listed in it, but one of the files listed in it
should also be passed ion the command line in both cases.

Your test also had mplayer's stdin connected to mediafiles.txt.  It
was just less explicit - mplayer inherits stdin from surrounding loop.
So I'm suggesting simplifying the test so that stdin is the *only*
difference between the two cases, and that will show whether it's
relevant.  OTOH, if you can't reproduce the problem with the
simplified pair of tests, then some interaction with the shell loops
must be involved.

> this works fine
> mplayer `cat zz.mtest `
>
> Then I tried
> mplayer /dev/stdin <zz.mtest

In the first case, mplayer is processing the files listed in
zz.mtest.  In the second case, it's processing zz.mtest itself.  So
it's not surprising that you get different results here.

> Then I tried
> while read file; do mplayer "$file" ; done <zz.mtest

What's in zz.mtest?  E.g., if it contains a line "-", then that will
tell mplayer to play the file on stdin, which in this case is
zz.mtest.  Choosing one of the listed files and testing with that, as
I suggested above, will eliminate this possibility.


paul
