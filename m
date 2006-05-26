Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750919AbWEZPfd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750919AbWEZPfd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 11:35:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750920AbWEZPfd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 11:35:33 -0400
Received: from gw.openss7.com ([142.179.199.224]:29336 "EHLO gw.openss7.com")
	by vger.kernel.org with ESMTP id S1750916AbWEZPfc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 11:35:32 -0400
Date: Fri, 26 May 2006 09:35:30 -0600
From: "Brian F. G. Bidulock" <bidulock@openss7.org>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Lee Revell <rlrevell@joe-job.com>, devmazumdar <dev@opensound.com>,
       linux-kernel@vger.kernel.org
Subject: Re: How to check if kernel sources are installed on a system?
Message-ID: <20060526093530.A20928@openss7.org>
Reply-To: bidulock@openss7.org
Mail-Followup-To: Arjan van de Ven <arjan@infradead.org>,
	Lee Revell <rlrevell@joe-job.com>, devmazumdar <dev@opensound.com>,
	linux-kernel@vger.kernel.org
References: <e55715+usls@eGroups.com> <1148596163.31038.30.camel@mindpipe> <1148653797.3579.18.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1148653797.3579.18.camel@laptopd505.fenrus.org>; from arjan@infradead.org on Fri, May 26, 2006 at 04:29:54PM +0200
Organization: http://www.openss7.org/
Dsn-Notification-To: <bidulock@openss7.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan,

On Fri, 26 May 2006, Arjan van de Ven wrote:

> On Thu, 2006-05-25 at 18:29 -0400, Lee Revell wrote:
> > On Thu, 2006-05-25 at 21:19 +0000, devmazumdar wrote:
> > > How does one check the existence of the kernel source RPM (or deb) on
> > > every single distribution?.
> > > 
> > > We know that rpm -qa | grep kernel-source works on Redhat, Fedora,
> > > SuSE, Mandrake and CentOS - how about other RPM based distros? How
> > > about debian based distros?. There doesn't seem to be a a single
> > > conherent naming scheme.  
> > 
> > I'd really like to see a distro-agnostic way to retrieve the kernel
> > configuration.  /proc/config.gz has existed for soem time but many
> > distros inexplicably don't enable it.
> 
> /boot/config-`uname -r`
> 

Redhat and SuSE put /boot/config- files of the same name for different
architectures (i386, i586) in the same file.  If multiple architecture
kernels of the same verion are installed, there is no guarantee that the
/boot/config-`uname -r` is not for, say, i686 instead of i386.  It takes

 rpm -q --qf "%{ARCH}" --whatprovides /boot/config-`uname -r`

complared with

 uname -m

to see if the mismatch occurs.

Debian (Woody), OTOH strips extra names of their kernels, so 3 or 4
different releases of the same upstream kernel version all install with
the same name and report `uname -r` the same.  If multiple of these
kernels and a vanilla kernel are installed, their config files will be
difficult to distinguish.  dpkg can be used (similar to above for rpm)
to test the condition.

 /boot/config-`uname -r`

works reliability only on Mandrake.

--brian

-- 
Brian F. G. Bidulock    ¦ The reasonable man adapts himself to the ¦
bidulock@openss7.org    ¦ world; the unreasonable one persists in  ¦
http://www.openss7.org/ ¦ trying  to adapt the  world  to himself. ¦
                        ¦ Therefore  all  progress  depends on the ¦
                        ¦ unreasonable man. -- George Bernard Shaw ¦
