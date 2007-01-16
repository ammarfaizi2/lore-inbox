Return-Path: <linux-kernel-owner+w=401wt.eu-S1751551AbXAPSIj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751551AbXAPSIj (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 13:08:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751541AbXAPSIi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 13:08:38 -0500
Received: from smtp102.sbc.mail.re2.yahoo.com ([68.142.229.103]:31414 "HELO
	smtp102.sbc.mail.re2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751299AbXAPSIi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 13:08:38 -0500
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Tue, 16 Jan 2007 13:08:37 EST
Date: Tue, 16 Jan 2007 10:01:54 -0800
From: Chris Wedgwood <cw@f00f.org>
To: Robert Hancock <hancockr@shaw.ca>
Cc: Christoph Anton Mitterer <calestyo@scientia.net>,
       linux-kernel@vger.kernel.org, knweiss@gmx.de, ak@suse.de,
       andersen@codepoet.org, krader@us.ibm.com, lfriedman@nvidia.com,
       linux-nforce-bugs@nvidia.com
Subject: Re: data corruption with nvidia chipsets and IDE/SATA drives (k8 cpu errata needed?)
Message-ID: <20070116180154.GA1335@tuatara.stupidest.org>
References: <fa.E9jVXDLMKzMZNCbslzUxjMhsInE@ifi.uio.no> <459C3F29.2@shaw.ca> <45AC06B2.3060806@scientia.net> <45AC08B9.5020007@scientia.net> <45AC1AEB.60805@shaw.ca> <45ACD918.2040204@scientia.net> <45ACE07D.3050207@shaw.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45ACE07D.3050207@shaw.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 16, 2007 at 08:26:05AM -0600, Robert Hancock wrote:

> >If one use iommu=soft the sata_nv will continue to use the new code
> >for the ADMA, right?
>
> Right, that shouldn't affect it.

right now i'm thinking if we can't figure out which cpu/bios
combinations are safe we might almost be better off doing iommu=soft
for *all* k8 stuff except for those that are whitelisted; though this
seems extremely drastic

it's not clear if this only affect nvidia based chipsets, the nature
of the corruption makes me think it's not an iommu software bug (we
see a few bytes not entire pages corrupted, it's not even clear if
it's entire cachelines trashed) --- perhaps other vendors have more
recent bios errata or maybe it's just that nvidia has sold a lot of
these so they are more visible? (i'm assuming at this point it might
be some kind of cpu errata that some bioses deal with because some
mainboards don't ever seem to see this whilst others do)

in some ways the problem is worse with recent kernels --- because the
ethernet and sata can address over 4GB and don't use the iommu anymore
the problem is going to be *much* harder to hit, but still here
lurking to cause problems for people.  with ethernet you'll probably
end up getting the odd trashed tcp frame and dropping it, so those
will go mostly unnoticed, so this is why sata seems to be the easier
way to show it
