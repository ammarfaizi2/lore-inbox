Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262066AbTKTTtO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Nov 2003 14:49:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262110AbTKTTtO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Nov 2003 14:49:14 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:32898
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S262066AbTKTTtJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Nov 2003 14:49:09 -0500
From: Rob Landley <rob@landley.net>
Reply-To: rob@landley.net
To: Shaheed <srhaque@iee.org>, linux-kernel@vger.kernel.org
Subject: Re: Patrick's Test9 suspend code.
Date: Thu, 20 Nov 2003 13:39:45 -0600
User-Agent: KMail/1.5
References: <200311201726.48097.srhaque@iee.org>
In-Reply-To: <200311201726.48097.srhaque@iee.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311201339.45461.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 20 November 2003 11:26, Shaheed wrote:
> > B) A heuristic that looks at the mounted block devices for things that
> > smell like a resume partition would actually be more robust in that case.
>
> How about a static signature followed by a timestamp? That way, maybe we
> could have a resume menu like this:
>
> /dev/hda3  (kernel 2.7.88, suspended on 01-04-2004 20:00:00)
> /dev/hda4  (kernel 2.8.99, suspended on 31-05-2005 20:00:00) ***
> Resume in 5..4..3..2..1..
>
> with a 5 second countdown before it chooses the most recent? Or in Pavel's
> examples:
>
> Erk! Nowhere to resume from!
>
> :-)

When resuming from a writeable filesystem, the filesystem has to match the 
contents of suspended memory.  If you've TOUCHED the filesystem since 
suspending, the resume is going to shred it, cross-link the heck out of it, 
and generally be evil.  (There are open filehandles saved in there, page 
table entries to maped stuff...  Just don't go there.)

Rob

