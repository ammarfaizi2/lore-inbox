Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266106AbTLIRrP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 12:47:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266107AbTLIRrP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 12:47:15 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:35574 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S266106AbTLIRrG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 12:47:06 -0500
From: Kevin Corry <kevcorry@us.ibm.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Joe Thornber <thornber@sistina.com>
Subject: Re: Device-mapper submission for 2.4
Date: Tue, 9 Dec 2003 11:45:04 -0600
User-Agent: KMail/1.5
Cc: Linux Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0312091206490.1289-100000@logos.cnet>
In-Reply-To: <Pine.LNX.4.44.0312091206490.1289-100000@logos.cnet>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312091145.04511.kevcorry@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 09 December 2003 08:10, Marcelo Tosatti wrote:
> On Tue, 9 Dec 2003, Joe Thornber wrote:
> > On Tue, Dec 09, 2003 at 11:15:08AM -0200, Marcelo Tosatti wrote:
> > > I believe 2.6 is the right place for the device mapper.
> >
> > So what's the difference between a new filesystem like XFS and a new
> > device driver like dm ?
>
> Expected question...
>
> XFS is a totally different filesystem from the ones present in 2.4.
>
> As far as I know, we already have the similar functionality in 2.4 with
> LVM. Device mapper provides the same functionality but in a much cleaner
> way. Is that right?

Hi Marcelo,

With all due respect, I don't really agree with this assessment.

To the casual observer, XFS is just another filesystem. It's used to manage 
files, just like with ext3, Reiser, or JFS. However, XFS provides certain 
features and performance characteristics that may not be found in the other 
filesystems. For this reason, many people prefer XFS over the other 
filesystems, and have pushed for its inclusion in the 2.4 kernel. Of course, 
I'd argue that just as many (if not more) people have very little preference 
as to which filesystem they use. They're happy as long as their data doesn't 
get corrupted if their system crashes.

The situation with Device-Mapper is *very* similar. There are plenty of people 
that are happy using LVM1, and probably don't care much about Device-Mapper 
at this point. But there are also many people who prefer the improved 
features offered by using Device-Mapper. The two new volume management tools, 
LVM2 and EVMS, provide significant improvements over LVM1, such as improved 
metadata formats, more reliable metadata updates, better user interfaces, in 
addition to features that aren't available with LVM1, such as asynchronous 
snapshots. Device-Mapper also provides a modular interface for adding new 
functionality. For example, the EVMS project includes a module for performing 
block-level bad-block-relocation, and another developer has contributed a 
module for block-level encryption based on the crypto API. These new volume 
management tools only work with Device-Mapper, because LVM1 simply doesn't 
have the flexibility necessary to provide these capabilities. Again, this 
situation seems to closely mirror the situation with XFS vs. the existing 
filesystems.

Another compelling reason in my mind is that unlike the variety of filesystems 
that exist both in 2.4 and in 2.6, LVM1 is no longer available in 2.6. Many 
LVM1 users have been eager to try out 2.6 (and I certainly agree with you 
that we need to convince more people to make this switch) but the fact that 
their current tools are useless on 2.6 makes the transition far more painful. 
It would be a huge benefit if these folks were able to first transition to 
the new volume management tools while remaining on a 2.4 kernel. Then after 
they're comfortable with this first switch, they can begin transitioning to a 
2.6 kernel, where the new tools will work seemlessly.

I certainly understand your apprehension about accepting new drivers that 
modify common kernel code. As with XFS, nearly all of the submitted code sits 
in its own directory, and is only enabled if a user decides he needs it. And 
the common changes really are incredibly minimal.

Joe's first patch changes all of 8 lines in the JBD code, which is done to 
prevent JBD and Device-Mapper from stepping on each other's private data. The 
second patch (mempool) only adds new functionality that won't affect any 
existing code. (I'm actually suprised the mempool code hasn't been merged 
yet, since it would be quite useful for any number of drivers and/or 
filesystems besides Device-Mapper. It has certainly come in quite handy in 
2.6.) And the changes in arch/ are simply to support the Device-Mapper 
interface on 64-bit architectures.

I'd be happy to answer any questions or provide any other information that 
would help you with this decision. If you'd like additional review of the 
common code changes, I'll gladly look for volunteers to help with what should 
be a very simple review.

I truly believe that including Device-Mapper will not only benefit users who 
wish to continue on the 2.4 platform, but also those who are looking for an 
easier path to migrate to 2.6.

Thanks very much for your time, Marcelo!

-- 
Kevin Corry
kevcorry@us.ibm.com
http://evms.sourceforge.net/

