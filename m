Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262703AbUCWQik (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Mar 2004 11:38:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262697AbUCWQih
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Mar 2004 11:38:37 -0500
Received: from matrix.roma2.infn.it ([141.108.255.2]:17590 "EHLO
	matrix.roma2.infn.it") by vger.kernel.org with ESMTP
	id S262678AbUCWQi3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Mar 2004 11:38:29 -0500
From: "Emiliano 'AlberT' Gabrielli" <AlberT@agilemovement.it>
Reply-To: AlberT@agilemovement.it
Organization: SuperAlberT.it
To: linux-kernel@vger.kernel.org
Subject: Re: Hidden PIDs in /proc
Date: Tue, 23 Mar 2004 17:40:14 +0100
User-Agent: KMail/1.6.1
References: <200403231708.15812.AlberT@agilemovement.it> <c3pnr5$29f$1@news.cistron.nl>
In-Reply-To: <c3pnr5$29f$1@news.cistron.nl>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200403231740.14351.AlberT@agilemovement.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 23 March 2004 17:15, Miquel van Smoorenburg wrote:
> In article <200403231708.15812.AlberT@agilemovement.it>,
>
> Emiliano 'AlberT' Gabrielli <AlberT@agilemovement.it> wrote:
> >Hi all,
> >
> >   I discovered some "hidden" pid dirs in /proc :
> >
> >root@emc2:# ls -lha /proc/ | grep 4673
> >root@emc2:# ls -lha /proc/4673/
> >totale 0
> >dr-xr-xr-x    3 albert   albert          0 2004-03-23 17:02 .
> >dr-xr-xr-x  108 root     root            0 2004-03-23 16:10 ..
>
> It's just a thread. For a threaded process, only the thread group
> leader is listed in /proc directly. The other threads are visible
> under /proc/<tgid>/task  (try it).
>

I allready did it ... infact the second test I posted correctly shows the 
thread ... but, why ps ax -m does *not* show it ??  

uhmm ok under task I can see all the threads correcly... the question now 
is .. why to show also the secondary threads directly in /proc, even if not 
visible by readdir ? It is a confusing issue for chkrootkit and similar... 
creating only the /proc/<tgid> in /proc shoud suffice and be cleaner ... 
IMHO.

> >After 2 days of headhake searching for possible rootkits, reinstalling all
> > the basic system, libs and so on (from a clean live-CD boot) ...
> >I noticed that these process seem all to use pthreads ... so, the question
> > is:
> >
> >is my problem related/solved by the
> > initramfs-search-for-init-zombie-fix.patch in the -mm1 tree ??
>
> No, by upgrading to a more recent procps.
>
> # ps ax | grep mozilla
> 16252 ?        S     10:21 /usr/lib/mozilla-firefox/firefox-bin
> $ ps ax -T | grep moz
> 16252 16252 ?        S     10:21 /usr/lib/mozilla-firefox/firefox-bin
> 16252 16264 ?        S      0:01 /usr/lib/mozilla-firefox/firefox-bin
> 16252 16266 ?        S      0:03 /usr/lib/mozilla-firefox/firefox-bin
> 16252 21530 ?        S      0:00 /usr/lib/mozilla-firefox/firefox-bin
>
> Also note:
>
> # ls /proc/16252/task
> 16252/  16264/  16266/  21530/
>
> Mike.


uh oh .. my bad ...  but .. my ignorance now ask what is the real diff between 
-m and -T option for ps ...

thanks
-- 
                       Emiliano `AlberT` Gabrielli  

E-Mail: AlberT@SuperAlberT.it  -  Web:    http://SuperAlberT.it
Membro dell'Italian Agile Movement - AlberT@agilemovement.it
