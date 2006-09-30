Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750817AbWI3M1F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750817AbWI3M1F (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Sep 2006 08:27:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750836AbWI3M1F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Sep 2006 08:27:05 -0400
Received: from wx-out-0506.google.com ([66.249.82.234]:46667 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750817AbWI3M1C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Sep 2006 08:27:02 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=eTmG70sXsnVgruB3ijx+bpLv97LIWnBVxQg4zmlVA/h1ZjS9kkEiS4Dlh0nQtYGqwbaFdjL5MGvh8XVOXYcd8iED0G7B2AE+qSuTtRypET4p78IeFfAl88e4Zb+7FNZnIQM5UQZYvffbtrhRI1XuMlF6r9yuUkIvup+c6Z5tpKQ=
Message-ID: <5a4c581d0609300527m1654f2cha56517e1c85f4606@mail.gmail.com>
Date: Sat, 30 Sep 2006 14:27:01 +0200
From: "Alessandro Suardi" <alessandro.suardi@gmail.com>
To: jt@hpl.hp.com
Subject: Re: 2.6.18-git9 wireless fixes break ipw2200 association to AP with WPA
Cc: "John W. Linville" <linville@tuxdriver.com>,
       "Linux Kernel" <linux-kernel@vger.kernel.org>,
       "Dave Jones" <davej@redhat.com>
In-Reply-To: <5a4c581d0609291552k7dc39685t15188bb5c881d3bd@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <5a4c581d0609291225r4a2cbaacr35e5ef73d69f8718@mail.gmail.com>
	 <20060929202928.GA14000@tuxdriver.com>
	 <5a4c581d0609291340q835571bg9657ac0a68bab20e@mail.gmail.com>
	 <20060929212748.GA10288@bougret.hpl.hp.com>
	 <5a4c581d0609291504r40bc1796q715c5ffa41aa7b1b@mail.gmail.com>
	 <20060929224316.GA10423@bougret.hpl.hp.com>
	 <5a4c581d0609291552k7dc39685t15188bb5c881d3bd@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/30/06, Alessandro Suardi <alessandro.suardi@gmail.com> wrote:
> On 9/30/06, Jean Tourrilhes <jt@hpl.hp.com> wrote:
> > On Sat, Sep 30, 2006 at 12:04:31AM +0200, Alessandro Suardi wrote:
> > > On 9/29/06, Jean Tourrilhes <jt@hpl.hp.com> wrote:
> > > >>
> > > >> [asuardi@sandman ~]$ rpm -q wireless-tools
> > > >> wireless-tools-28-0.pre13.5.1
> > > >
> > > >        That's too old, the cutoff is 27-pre15.
> > >
> > > Are you sure ? For how I read it, 28-0.pre13.5.1 is more recent
> > > than 27-pre15, not older.
> >
> >         Sorry, I'm mixing up my numbers.
> >         The cutoff for the ESSID fix is 28-pre15, so your version is
> > just a little bit older. I'm mixing up with the iwpoint cutoff which
> > was 27-pre25.
>
> OK.
>
> > > So I guess there's an actual bug that doesn't depend on the
> > > wireless-tools. Or maybe it's wpa_supplicant that has to be
> > > upgraded ?
> >
> >         I don't have the start of the thread, so I don't know the
> > exact failure mode. If you are using wpa_supplicant, it bypasses the
> > wireless tools so it would have to be updated.
> >         Note that I've been pestering Jouni about the fact that he had
> > to update wpa_supplicant for that since last May, when Jouni himself
> > asked me to change the ESSID API. Ironic, isn't it ?
> >         The epitest.fi site seems unfortunately down...
>
> Yup, same from here. I was about to go downloading and rebuilding
>  wpa_supplicant from the 0.4.9 (stable) and failing that from the
>  0.5.5 (dev) tarball, but epitest.fi isn't reachable.
>
> > > >        On the other hand, FC6, which is in beta, contains already the
> > > >proper version of the tools. I have been monitoring the various distro
> > > >in the last few months before sending those WE-21 patches, and all
> > > >major distro have WT-28 in the pipeline.
> > >
> > > Even if so, wireless-tools would be the only package I have to
> > > build out of the FC5 distribution to keep up with the latest -git
> > > snapshot of the Torvalds kernel... I'm not especially troubled
> > > with this anyway. Perhaps you could push the Fedora folks to
> > > be a bit more up-to-date with wireless-tools in their current
> > > main version ?
> >
> >         The FC people are busy.
>
> In any case, cc'ing Dave who chipped in earlier in the thread -
>  if wpa_supplicant needs to be rebuilt, then it's very likely that
>  even FC6 which has 0.4.8-something (just checked ;) will not
>  work with the current kernel changes.
>
> I will post an update when I can get hold of the newer sources
>  for wpa_supplicant...

Good news, WPA association is back to work for me using
 wireless_tools.29.pre10 and wpa_supplicant-0.4.9 with

 2.6.18-git11 vanilla
 2.6.18-git11 with reverted wireless fixes
 2.6.18-git13

 which appears to mean that backward compatibility of the
 new tools with older kernel features has also been tested :)

Dave, do you want me to file a request for updated FC5 RPMs
 for wireless-tools and wpa_supplicant in bugzilla or is it
  - already happening
  - never going to happen
 ?


Thanks, ciao,

--alessandro

"Well a man has two reasons for things that he does
  the first one is pride and the second one is love
  all understandings must come by this way"

     (Husker Du, 'She Floated Away')
