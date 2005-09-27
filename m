Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965028AbVI0R3W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965028AbVI0R3W (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 13:29:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965025AbVI0R3W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 13:29:22 -0400
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35]:56707 "HELO
	smtp004.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S965027AbVI0R2w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 13:28:52 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Disposition:Message-Id:Content-Type:Content-Transfer-Encoding;
  b=qxVAAHxXIak6nNEzu6C4+j33HD+EgjrxKtHKr/82+dLJ+eyrUgF/mRVSrosXXIVHsr7GTuJamm/V/XdS0qt8yepvDWc2bLKOoxouseGkYXN7SgwMuCy0iVr8LZqxzVPKBv3PaudGzx+HIUwqVJ1rpXQ2FzumpG0f6eJtwR+/j+M=  ;
From: Blaisorblade <blaisorblade@yahoo.it>
To: Alexander Clouter <alex@digriz.org.uk>, Andrew Morton <akpm@osdl.org>
Subject: [2.6.14] Cpufreq_ondemand sysfs names change (was: Re: CPUFreq_ondemand: misnamed ignore_nice attribute)
Date: Tue, 27 Sep 2005 18:51:36 +0200
User-Agent: KMail/1.8.2
Cc: Dave Jones <davej@redhat.com>, LKML <linux-kernel@vger.kernel.org>
References: <200508232108.26248.blaisorblade@yahoo.it> <200509101536.10307.blaisorblade@yahoo.it> <20050910140148.GC7072@inskipp.digriz.org.uk>
In-Reply-To: <20050910140148.GC7072@inskipp.digriz.org.uk>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200509271851.36706.blaisorblade@yahoo.it>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 10 September 2005 16:01, Alexander Clouter wrote:
> Hi,
Summary for Andrew Morton:

ondemand's ignore_nice attribute has a reversed meaning, and fixing this 
requires changing the API for the user playing with sysfs. Thus, it should be 
fixed ASAP, i.e. 2.6.14.

echo 0 > /sys/devices/system/cpu/cpu0/cpufreq/ondemand/ignore_nice
Then ondemand ignores nice tasks when calculating CPU load.
echo 1 > /sys/devices/system/cpu/cpu0/cpufreq/ondemand/ignore_nice
Then ondemand considers nice tasks when calculating CPU load.

It's the reverse of the expected behaviour, even Alexander Clouter got 
confused on it when I first reported this bug.

So I suggest:
*) to flip the flag's behaviour, as discussed with Alexander

*) to rename the flag to ignore_nice_load or ignore_nice_tasks, to avoid 
burning the user too much. Very few people use it now, but let's help them.

*) Alexander had a piece of doc he wrote about all this and sent me, it'd be 
nice to have this merged too.

Alexander (quoted near the end) said to have rolled the patches, but they're 
lost somewhere, don't know if he forgot or they're in some staging tree 
in-the-middle. I guess I could roll up the patches if needed, but this week 
I'm really busy, so probably not. I've also forwarded the original docco 
patch to Andrew Morton and LKML (which didn't receive them in first place).

> Blaisorblade <blaisorblade@yahoo.it> [20050910 15:36:10 +0200]:
> > On Saturday 10 September 2005 14:59, Alexander Clouter wrote:
> > > Hi,
[About the flag behaviour]
> > > I'm all for this to be changed, its a feature that is ment to be for
> > > Joe Public to be used, it would be silly of us to not make it easier;
> > > it is confusing as it stands.

> > Ok - hope there's no so much people workarounding for the new behaviour,
> > but they're smart enough to fix their scripts up. Just shout a bit on
> > LKML to say this and we should be ok.

> My thinking too, its a relatively new feature and when I have looked around
> very few userland tools even tinker with ondemand so either we do it now or
> not at all...or rather we do it later and listen to everyone complain :)

> > > Flipping the behaviour of the flag gets my vote.  Do you want to roll
> > > the patch and I fix up the documentation or do you want to do both, or
> > > should do both?

> > I think it's better that you do that - I'd already so many patches spread
> > in my trees that I'd lose this patch somewhere.

> Not a problem.  I'll roll them off right now.

> Cheers

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade


	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it
