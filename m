Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312261AbSDJASt>; Tue, 9 Apr 2002 20:18:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312269AbSDJASs>; Tue, 9 Apr 2002 20:18:48 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:61103 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S312261AbSDJASq>; Tue, 9 Apr 2002 20:18:46 -0400
Date: Tue, 09 Apr 2002 18:17:16 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Brian Beattie <alchemy@us.ibm.com>
cc: Michel Dagenais <michel.dagenais@polymtl.ca>, linux-kernel@vger.kernel.org,
        Tony.P.Lee@nokia.com, kessler@us.ibm.com, alan@lxorguk.ukuu.org.uk,
        Dave Jones <davej@suse.de>, karym@opersys.com, lmcmpou@lmc.ericsson.se,
        lmcleve@lmc.ericsson.se
Subject: Re: Event logging vs enhancing printk
Message-ID: <2000000.1018401436@flay>
In-Reply-To: <1018391340.7923.40.camel@w-beattie1>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> You want to fix 80000 printks? Be my guest ... I await your patch eagerly.
>> If you mean changing printk with a wrapper to help clean up the existing
>> mess in an automated fashion, that's exactly what's being proposed.
> 
> how nice of you to say so. 

You're welcome ;-)

> As to automating, I don;t believe it can work.  You will be adding volume 
> to the log, making the log processing more complicated, a replay of EES.

OK, I think we both agree there's a problem with the current subsystem.
Larry and I discussed the problem and think we have a low impact way
of improving the current situation, giving the customers that require a 
robust, detailed logging system what they want (by turning on a config
option) whilst having pretty much 0 impact to the rest of the community.

In my mind, this should make everone happy. You obviously have some
issue with this - as far as I can tell, that seems to be tied to your concepts 
of EES (for those that don't know, EES was Dynix/PTX's "error event subsystem" 
or some such name). This is not EES, nor ever will be - EES's major design flaw
was that it pervasively invaded everything throughout the kernel, requiring
every equivalent of printk to be changed to a complex log event. It also took
away the existing subsystem equivalent to what ends up in /var/log/messages,
breaking logging parsing scripts. Nobody (that I know of) is proposing doing any 
such thing to Linux. On the other hand customers liked the new more powerful 
ability to search the error scripts, and automatically generate events from that, 
such as email, paging, etc. FWIW, I was the Sequent customer service rep for EES. 
We are trying to get for Linux the benefits of EES without the associated pain.

In more specific reply to what you said, we'd be adding volume to the evlog
*if* you turned evlog on, making log processing more complex *if* you turned
evlog on, and this is not EES. This gives people who want evlog that functionality,
and people who don't want it no change. If people object to buffering the normal
printk per line, we don't have to do that. That was a side observation, not a critical
part of this - in fact if it's not fixed, it just provides one more reason for people to
use evlog.

>> > Evlog side-by-side with printk adds significat bloat.
>> 
>> To what? A kernel with event logging switch on? Sure. 
>> But if you don't want it, don't turn it on. If it's a config option, I don't
>> see why anyone would care.
> 
> The poor sod who has to maintain this stuff.

Those people are the exact same people who are proposing it. IBM, and the 
large group of customers who want this functionality are unlikely to dissappear 
overnight, I feel. They will maintain this subsystem - we're not asking you 
personally to do it.

>> Indeed. That's because the kernel has more context, and can trivially
>> log the information it has, rather then reverse engineering it from user space.
>> Why munge all the messages to post them through a tiny little formatting
>> hole, and then try to unmunge them all again on the other side with a
>> bunch of hokey scripts?
> 
> Information that only the kernel has is not what I'm talking about, it
> is all the stuff to make it easy to parse and collate, it has to be
> possible, not necessarly easy.

As I've stated before, I don't think it's a good idea to change the current
/var/log/messages format unilaterally - we'd never get agreement from
everyone to do it, and I wouldn't want to even if we did - it'd make an
unreadable mess of a simple text file. I prefer to make things easy, not
just possible. Are you disagreeing with the information that is being 
proposed to log, or just that you want all that stuff dumped into dmesg
and /var/log/messages (via the limitations of syslog)?

>> If we had a more structured log format, it'd be a damned sight easier to
>> write automated tools to parse through them, and actually do something
>> useful with that 99%. Been there, done that.
> 
> What? generate reports that will be munged for statistics that will be
> quoted in endless management meetings.

No, generating useful tools for real customers on critical systems that
alert them when certain errors occur.
  
> But you could get 90% of the advantage for much less effort by fixing
> the problems with printk/klogd without implementing yet another
> subsystem.

I disagree - I think you'll make an unwieldy ugly mess of the existing
subsystem, and piss everybody off. The evlog stuff is self-contained.

>> This is actually very close to what is being proposed. The main reason the
>> we came to the conclusion that end result should be dumped into an evlog
>> file instead of dmesg and /var/log/messages is that changing the format
>> of /var/log/messages breaks the existing log parsing tools that people have.
> 
> And this could be avoided using the "improved printk" by not compiling
> the new features.

see above. Try getting an existing section of a /var/log/messages file, converting 
it to include all the information we're trying to log, and writing tools to parse it.
Then publish the resultant mess back here to see if people like what you've
done to the existing format they're used to.

M.

