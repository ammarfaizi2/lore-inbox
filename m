Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261310AbVF1LXf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261310AbVF1LXf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 07:23:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261312AbVF1LXf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 07:23:35 -0400
Received: from relay1.wplus.net ([195.131.52.143]:40241 "EHLO relay1.wplus.net")
	by vger.kernel.org with ESMTP id S261310AbVF1LX3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 07:23:29 -0400
From: Vitaly Fertman <vitaly@namesys.com>
To: reiserfs-list@namesys.com
Subject: Re: reiser4 plugins
Date: Tue, 28 Jun 2005 15:14:10 +0400
User-Agent: KMail/1.7.1
Cc: Hans Reiser <reiser@namesys.com>,
       Michael Dreher <michael.dreher@uni-konstanz.de>,
       vitaly@thebsh.namesys.com, linux-kernel@vger.kernel.org,
       Adrian Ulrich <reiser4@blinkenlights.ch>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, ninja@slaphack.com,
       jgarzik@pobox.com, hch@infradead.org, akpm@osdl.org
References: <42BAC304.2060802@slaphack.com> <200506232249.47302.michael.dreher@uni-konstanz.de> <42BB4C81.6070500@namesys.com>
In-Reply-To: <42BB4C81.6070500@namesys.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Message-Id: <200506281514.11995.vitaly@namesys.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 24 June 2005 03:57, Hans Reiser wrote:
> One, you were using V3 not V4.
> 
> Two, this bug you mention is probably not an fs bug.  rm first creates a
> list of names, and then removes them. 

shell creates a list of names, rm simply handles the given set 
of names and tries to remove a file twice if specified twice. 

the problem could be in the shell, or what is more likely in patterns 
that overlap each other, like in the example of 'rm *fu fi*'. 
we should probably investigate a reproducable example.

> reiser@linux:~/scratch> touch fufu
> reiser@linux:~/scratch> touch fifu
> reiser@linux:~/scratch> rm *fu fi*
> rm: cannot remove `fifu': No such file or directory
> 
> Your file either somehow got removed before rm got to it, or rm somehow
> got to it twice.  Vitaly, can you look at the error handling by rm and
> see if it can get to things twice when it hits an error or if you can

once per every given name.

> otherwise figure this out?  If I remember right, I have hit this myself
> for non-reiserfs filesystems, and I never investigated it.
> 
> Michael Dreher wrote:
> 
> >>>>                                                Not everyone will want
> >>>>to reformat at once, but as the reiser4 code matures and proves itself
> >>>>(even more than it already has),
> >>>>        
> >>>>
> >>>I for one have seen mainly people with wild claims that it will make
> >>>their machines much faster, and coming back later asking how they can
> >>>recover their thrashed partitions...
> >>>      
> >>>
> >>Then please show us some Links/Message-IDs to such postings.
> >>I'd like to read them.
> >>    
> >>
> >
> >Here you are....
> >
> >The following happened to me with reiserfs as it was shipped with
> >suse 9.1:
> >
> >------------------------------------------------------------------
> >dreher@euler03:~/mytex/konstanz/wohnung> ls
> >auto          makler2.aux  makler2.log  makler2.tex  makler.aux  makler.log  
> >swk.eps      unilogo.eps
> >briefkpf.tex  makler2.dvi  makler2.ps   makler3.tex  makler.dvi  makler.tex  
> >unikopf.tex
> >dreher@euler03:~/mytex/konstanz/wohnung> rm *.aux *.log
> >rm: cannot remove `makler2.log': No such file or directory
> >dreher@euler03:~/mytex/konstanz/wohnung> ls
> >auto  briefkpf.tex  makler2.dvi  makler2.ps  makler2.tex  makler3.tex  
> >makler.dvi  makler.tex  swk.eps  unikopf.tex  unilogo.eps
> >dreher@euler03:~/mytex/konstanz/wohnung> uname -a
> >Linux euler03 2.6.5-7.108-smp #1 SMP Wed Aug 25 13:34:40 UTC 2004 i686 i686 
> >i386 GNU/Linux
> >dreher@euler03:~/mytex/konstanz/wohnung> date
> >Tue Sep 21 13:15:45 CEST 2004
> >----------------------------------------------------------
> >
> >Note the line "rm: cannot remove `makler2.log': No such file or directory"
> >
> >There was no data loss, but such a bug should not happen.
> >I never had similar experiences with ext3.
> >
> >Unfortunately, I cannot reproduce this behavior. 
> >
> >  
> >
> >> Powerloss, unpluging the Disk while writing, full filesystem,
> >> heavy use : No problems with reiser4.. It *is* stable.
> >>    
> >>
> >
> >My impression: reiser3 is not 100% stable, but quite stable, 
> >written by someone who asks for "review by benchmark".
> >
> >Michael
> >
> >
> >  
> >
> 
> 
> 

-- 
Thanks,
Vitaly Fertman
