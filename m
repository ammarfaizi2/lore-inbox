Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262407AbTEMSb2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 14:31:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262424AbTEMSb2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 14:31:28 -0400
Received: from DELFT.AURA.CS.CMU.EDU ([128.2.206.88]:45208 "EHLO
	delft.aura.cs.cmu.edu") by vger.kernel.org with ESMTP
	id S262407AbTEMSbZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 14:31:25 -0400
Date: Tue, 13 May 2003 14:44:12 -0400
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [OpenAFS-devel] Re: [PATCH] in-core AFS multiplexor and PAG support
Message-ID: <20030513184411.GC30766@delft.aura.cs.cmu.edu>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
References: <B578DAA4FD40684793C953B491D4879174D3B9@umr-mail7.umr.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B578DAA4FD40684793C953B491D4879174D3B9@umr-mail7.umr.edu>
User-Agent: Mutt/1.5.4i
From: Jan Harkes <jaharkes@cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 13, 2003 at 01:25:17PM -0500, Neulinger, Nathan wrote:
> > > If someone obtains my user id on in any way (i.e. weak password/
> > > bufferoverflow/ root exploit), he should not be allowed to use or access
> > > my tokens as he hasn't proven his identity. In this case he would either
> > > still be in his original process authentication group, or a new and
> > > empty PAG. But definitely not in any of my authentication groups.
> > > 
> > > Which is also why joining a PAG should never be allowed.
> > 
> > Someone asked for it, but I suspect if allowed at all it may 
> > be best that this
> > ability is governed by its own capability bit and also that 
> > the security
> > interface should be consulted.
> 
> Definately. This is only allowed for root in any case. (Or the cap as
> you describe.)

I don't care if the local user id is 'root', or 'nobody'. As long as
this session hasn't gone through the steps to prove its identity, it
should not be allowed to hijack an existing session.

What should be allowed is for someone to obtain credentials (tokens) and
explicitly pass them to another PAG. Which is probably the reason you
want to be able to join a PAG in the first place.

situation:
  "Hmm, my AFS tokens on my desktop are about to expire"
  
solution 1 (which I believe is bad):
  "log in remotely, join the existing PAG and refresh the tokens"

solution 2:
  "log in remotely, obtain new tokens and explicitly pass them to
  another PAG"

A really bad reason for joining a PAG would be that you want to log in
remotely, but don't want to pay for the cost of proving your identity in
the new session.

Jan

