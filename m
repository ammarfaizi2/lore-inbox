Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750987AbWDXRD4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750987AbWDXRD4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 13:03:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750979AbWDXRDz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 13:03:55 -0400
Received: from stanford.columbia.tresys.com ([209.60.7.66]:25634 "EHLO
	gotham.columbia.tresys.com") by vger.kernel.org with ESMTP
	id S1750976AbWDXRDy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 13:03:54 -0400
Message-ID: <444D04EA.5030003@gentoo.org>
Date: Mon, 24 Apr 2006 13:03:38 -0400
From: Joshua Brindle <method@gentoo.org>
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
MIME-Version: 1.0
To: Tony Jones <tonyj@suse.de>
CC: Andi Kleen <ak@suse.de>, Neil Brown <neilb@suse.de>,
       Stephen Smalley <sds@tycho.nsa.gov>, Chris Wright <chrisw@sous-sol.org>,
       James Morris <jmorris@namei.org>,
       Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       linux-security-module@vger.kernel.org
Subject: Re: [RFC][PATCH 0/11] security: AppArmor - Overview
References: <20060419174905.29149.67649.sendpatchset@ermintrude.int.wirex.com> <17484.20906.122444.964025@cse.unsw.edu.au> <444CCE83.90704@gentoo.org> <200604241526.03127.ak@suse.de> <444CD507.70004@gentoo.org> <444CEBC9.5030802@gentoo.org> <20060424155003.GC25238@suse.de>
In-Reply-To: <20060424155003.GC25238@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Antivirus: avast! (VPS 0616-4, 04/21/2006), Outbound message
X-Antivirus-Status: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tony Jones wrote:
> On Mon, Apr 24, 2006 at 11:16:25AM -0400, Joshua Brindle wrote:
>   
>> To make this much more real, the /usr/sbin/named policy that ships with 
>> apparmor has the following line:
>>     
>
> Ships with AppArmor where?  On SuSE?
>   
apparmor-profiles-2.0.tar.gz  available on the novell forge.
>   
>> /** r,
>> Thats right, named can read any file on the system, I suppose this is 
>> because the policy relies on named being chrooted. So if for any reason 
>> named doesn't chroot its been granted read access on the entire 
>> filesystem. If I'm misunderstanding this policy please correct me but I 
>> believe this shows the problem very loudly and clearly.
>>     
>
> The d_path changes for absolute path mediation for chroot are not yet in any 
> SuSE release. Nor are they reflected in any developed profiles (yet).
>
>   
So you are currently not protecting this access vector and it was said 
pretty clearly that this patch wouldn't make it into mainline. I don't 
understand how you intend to address this. Are people running different 
distros out of luck with regard to Apparmor?

> Another direction is a new security_chroot hook together with appropriate 
> CLONE_FS tracking (inside AppArmor) to force chrooting confined tasks into a 
> subprofile (similar to change hat). We are evaluating the options based on 
> feedback here and from other places.  Hence the RFC.
>
> I hope this helps
Thats fine, what about private namespaces, which are better than chroots 
anyway in terms of flexibility. Are you going to be able to specify the 
precise namespace that an app may use in order to use these policies?

By the way, the fact that there is such a rule in the policy isn't the 
problem, its a symptom of the problem. All of these 'fixes' seem to be 
band-aiding the symptoms. Aren't these alot of hoops to jump through for 
the sake of using paths?
