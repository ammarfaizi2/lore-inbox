Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264759AbUD1MLU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264759AbUD1MLU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 08:11:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264767AbUD1MLT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 08:11:19 -0400
Received: from thunk.org ([140.239.227.29]:48825 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S264759AbUD1MLR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 08:11:17 -0400
Date: Wed, 28 Apr 2004 08:10:09 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: Chris Friesen <cfriesen@nortelnetworks.com>, Jurriaan <thunder7@xs4all.nl>,
       linux-kernel@vger.kernel.org
Subject: Re: What does tainting actually mean?
Message-ID: <20040428121009.GA2844@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Nigel Cunningham <ncunningham@linuxmail.org>,
	Chris Friesen <cfriesen@nortelnetworks.com>,
	Jurriaan <thunder7@xs4all.nl>, linux-kernel@vger.kernel.org
References: <opr65eq9ncshwjtr@laptop-linux.wpcb.org.au> <20040428042742.GA1177@middle.of.nowhere> <opr65f48sfshwjtr@laptop-linux.wpcb.org.au> <408F3EE4.1080603@nortelnetworks.com> <opr65ic90vshwjtr@laptop-linux.wpcb.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <opr65ic90vshwjtr@laptop-linux.wpcb.org.au>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 28, 2004 at 03:18:35PM +1000, Nigel Cunningham wrote:
> On Wed, 28 Apr 2004 01:19:32 -0400, Chris Friesen <cfriesen@nortelnetworks.com wrote:
> >
> >There has already been a case mentioned of a binary module that messed  
> >up something that was only visible once that module was unloaded and  
> >another one loaded.  It all depends totally on usage patterns.
> 
> I don't know what module you're talking about, but surely there must be  
> something that could be done kernel-side to protect against such problems.  
> Reference counting or such like? I guess if it was a hardware issue, but  
> then again that might be an issue with too many assumptions being made  
> about prior state? Maybe I am being too naive :>

The problem is with corrupted data structures, pointers, etc.  An
evil/incompetently written driver can screw up data structures long
after it has been unloaded.  Historically, there was a time when a
certain set of propeitary six-letter video company beginning with 'N'
and ending with 'a' had serious bugs which would corrupt the kernel
and create random kernel panics far removed from the actual source of
the problems.

Stack overflows in a badly written device driver can overwrite task
structures and cause apparent filesystem problems which are blamed on
the hapless filesystem authors instead of where the blame properly
lies, namely the device driver author.

The thing we could do kernel-side is to implement full VM protections.
This is the microkernel approach; the problem though is the
performance overhead of having to go through protection boundaries,
setting up kernel-module-specific VM page tables, etc., etc.  At some
level, if people could implement these propeitary code bases in
userspace, then there would be no need to risk corrupting internal
data structures, and no need to "taint" the kernel.  But usually there
are performance reasons why the driver authors choose not to go down
that path.

						- Ted
